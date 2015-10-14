//
//  GetDataTools.h
//  music2
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 uis. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MusicList;
typedef void(^PassValue)(NSArray *arrray);
@interface GetDataTools : NSObject
//作为单例的属性，这个数组可以在任何位置，任何时间被访问
@property(nonatomic,strong)NSMutableArray *dataArr;
//单例方法
+(instancetype)shareGetData;

//根据传入的URL，通过Block返回一个数组
//这种‘block’回传值的形式
//工作之后，有些单位专门编写SDK（第三方）
-(void)getDataWithURL:(NSString *)URL PassValue:(PassValue )passValue;
//根据传入的index，返回一个歌曲信息的模型，这个模型来自上面的属性数组
-(MusicList *)getModelWithIndex:(NSInteger)index;


@end
