//
//  MusicPlayTools.h
//  music2
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 uis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "MusicList.h"
//与block回传值作比较
//定义协议，如果外界想使用本类，必须遵循和实现协议中的两个方法
@protocol MusicPlayToosDelegate <NSObject>
//外界实现这个方法的同时，也将参数的值拿走了，这样就通过代理方法向外界传递值
-(void)getCurTime:(NSString *)curTime TotleTime:(NSString *)totleTime Progress:(CGFloat)progress;
//播放结束之后，做什么操作由外部决定
-(void)endOfPlayAction;

@end

@interface MusicPlayTools : NSObject
//本类中播放器的指针
@property(nonatomic,strong)AVPlayer *player;
@property(nonatomic,strong)MusicList *model;
@property(nonatomic,weak)id<MusicPlayToosDelegate>delegate;
+(instancetype)shareMusicPlay;
-(void)musicPlay;
-(void)musicPrePlay;
-(void)musicPause;
-(void)seekToTimeWithValue:(CGFloat)value;
//返回一个歌词组
-(NSMutableArray *)getMusicLyricArray;
//根据当前播放时间，返回对应歌词在数组中的位置
-(NSInteger)getIndexWithCurTime;

@end
