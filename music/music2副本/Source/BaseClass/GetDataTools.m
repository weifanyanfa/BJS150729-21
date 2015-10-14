//
//  GetDataTools.m
//  music2
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 uis. All rights reserved.
//

#import "GetDataTools.h"
#import "MusicList.h"
static GetDataTools *gd = nil;
@implementation GetDataTools

+(instancetype)shareGetData
{
    if (gd == nil) {
        dispatch_once_t once_token;
        dispatch_once(&once_token, ^{
            gd = [[GetDataTools alloc]init];
        });
//        gd = [[GetDataTools alloc]init];
    }
    return gd;
}
-(void)getDataWithURL:(NSString *)URL PassValue:(PassValue)passValue
{
    //在请求数据时，arrayWithContentsOfURL方法是同步请求（请求不结束，主线程什么也干不了）
    //为了避免这种现象，我们将请求的动作放在子线程中。
    //创建线程队列（全局）
    dispatch_queue_t globl_t = dispatch_get_global_queue(0, 0);
    //定义子线程的内容
    dispatch_async(globl_t, ^{
        //在这对花括号内的所有操作都不会阻塞主线程
        //请求数据
        NSArray *array = [NSArray arrayWithContentsOfURL:[NSURL URLWithString:URL]];
        //解析，将解析好的“歌曲信息模型”，加入我们的属性数组，以便外界随时访问
        for (NSDictionary *dict in array) {
            MusicList *model = [[MusicList alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [self.dataArr addObject:model];
        }
        //这个Block是外界传入的（外界的代码放到这里来执行），但是我们的self.dataArr可以作为参数，传递给外界的代码块中，这样外界就可以拿到这个数组
        passValue(self.dataArr);
    });
}
//属性数组的懒加载（全局用）
-(NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
//根据传入的index 返回一个“歌曲信息模型”
-(MusicList *)getModelWithIndex:(NSInteger)index
{
    return self.dataArr[index];
}


@end
