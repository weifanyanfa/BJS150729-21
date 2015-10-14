//
//  MusicPlayTools.m
//  music2
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 uis. All rights reserved.
//

#import "MusicPlayTools.h"
#import "MusicLyric.h"
static MusicPlayTools *mp = nil;
@interface MusicPlayTools ()
@property(nonatomic,strong)NSTimer *timer;

@end
@implementation MusicPlayTools

+(instancetype)shareMusicPlay
{
    if (mp == nil) {
        dispatch_once_t once_token;
        dispatch_once(&once_token, ^{
            mp = [[MusicPlayTools alloc]init];
        });
    }
    return mp;
}
//重写init方法，因为要得到某手歌曲播放结束这一事件，之后由外界决定播放结束之后采取什么操作。
//AVPlayer并没有通过block或者代理向我们返回这一状态（事件），而是向通知中心注册了一条通知（AVPlayerItemDidPlayToEndTimeNotification）我们也只有这一条途径获取播放结束这一事件
//所以，在我们创建好一个播放器时（[[AVPlayer alloc]init]），应该立刻为通知中心添加观察者，来观察这一事件的发生。
//这个动作放在init里，最及时也最合理
-(instancetype)init
{
    if (self = [super init]) {
        _player = [[AVPlayer alloc]init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endOfPlay:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    return self;
}
//播放结束后的方法，由代理具体实现行为
-(void)endOfPlay:(NSNotification *)sender
{
    [self musicPause];
    [self.delegate endOfPlayAction];
}
-(void)musicPrePlay
{
    //通过下面逻辑，只要AVPlay有currentItem,那么一定被添加了观察者
    //所以上来直接移除
    if (self.player.currentItem) {
        [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    }
    //根据传入的URL，创建一个item对象
    //initwithURL的初始化方法建立异步链接。什么时候链接建立完成我们不知道。但是它完成链接后，会修改自身内部的属性status。所以，我们要观察这个属性，当它的状态变为AVPlayerItemStatusReadyToPlay时。我们就知道播放器已经准备好了
    AVPlayerItem * item = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:self.model.mp3Url]];
    [item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    //用新创建的item代替AVPlayer之前的item。新的item是带观察者的
    [self.player replaceCurrentItemWithPlayerItem:item];
}
//观察者的处理方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"]) {
        switch ([[change valueForKey:@"new"]integerValue]) {
            case AVPlayerItemStatusUnknown:
                NSLog(@"不知道什么错误");
                break;
            case AVPlayerStatusReadyToPlay:
                [self musicPlay];
                break;
            case AVPlayerStatusFailed:
                NSLog(@"准备失败");
                break;
            default:
                break;
        }
    }
}
-(void)musicPlay
{
    if (self.timer != nil) {
        return;
    }
    //播放后我们开启一个计时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    [self.player play];
    
}
-(void)musicPause
{
    [self.timer invalidate];
    self.timer = nil;
    [self.player pause];
}
-(void)seekToTimeWithValue:(CGFloat)value
{
    [self musicPause];
    [self.player seekToTime:CMTimeMake(value *[self getTotleTime], 1) completionHandler:^(BOOL finished) {
        if (finished == YES) {
            [self musicPlay];
        }
    }];
}
-(NSInteger)getCurTime
{
    if (self.player.currentItem) {
        return self.player.currentTime.value / self.player.currentTime.timescale;
    }
    return 0;
}
-(NSInteger)getTotleTime
{
    CMTime totleTime  = [self.player.currentItem duration];
    if (totleTime.timescale == 0) {
        return 1;
    }
    else
    {
        return totleTime.value / totleTime.timescale;
    }
}
-(CGFloat)getProgress
{
    return (CGFloat)[self getCurTime] / (CGFloat)[self getTotleTime];
}
-(NSString *)valueToString:(NSInteger)value
{
    return [NSString stringWithFormat:@"%.2ld:%.2ld",value/60,value%60];
}
-(NSMutableArray *)getMusicLyricArray
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *str in self.model.timeLyric) {
        if (str.length == 0) {
            continue;
        }
        MusicLyric *model = [[MusicLyric alloc]init];
        model.lyricTime = [str substringWithRange:NSMakeRange(1, 9)];
        model.lyricStr = [str substringFromIndex:11];
        [array addObject:model];
    }
    return array;
}
-(NSInteger)getIndexWithCurTime
{
    NSInteger index = 0;
    NSString *curTime = [self valueToString:[self getCurTime]];
    for (NSString *str in self.model.timeLyric) {
        if (str.length == 0) {
            continue;
        }
        if ([curTime isEqualToString:[str substringWithRange:NSMakeRange(1, 5)]]) {
            return index;
        }
        index ++;
    }
    return -1;
}

@end
