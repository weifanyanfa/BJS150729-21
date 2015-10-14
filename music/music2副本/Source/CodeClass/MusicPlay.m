//
//  MusicPlay.m
//  music2
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 uis. All rights reserved.
//

#import "MusicPlay.h"
#define kScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
@implementation MusicPlay
-(instancetype)init
{
    if (self = [super init]) {
        [self p_setup];
    }
    return self;
}
-(void)p_setup
{
    //ImageView
    self.Musicimageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 375, 667)];
    [self addSubview:_Musicimageview];
    //1、scrollView
    self.mainScrollView = [[UIScrollView alloc]init];
    
    
    self.mainScrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth);
    self.mainScrollView.contentSize = CGSizeMake(kScreenWidth *2, CGRectGetHeight(self.mainScrollView.frame));
    //self.mainScrollView.backgroundColor = [UIColor greenColor];
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.alwaysBounceHorizontal = YES;
    self.mainScrollView.alwaysBounceVertical = NO;
    [self addSubview:_mainScrollView];
    
    //旋转图片
    self.rotateImageView = [[UIImageView alloc]initWithFrame:CGRectMake(60, 60, 250,250)];
    //图片转起来的方法
    self.rotateImageView.layer.masksToBounds =YES;
    self.rotateImageView.layer.cornerRadius = 250/2;
    /*self.rotateImageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
     [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(TimerTick:) userInfo:nil repeats:YES];*/
    [self.mainScrollView addSubview:_rotateImageView];
    //TableView
    self.lyricTableView = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, CGRectGetHeight(self.mainScrollView.frame))style:UITableViewStylePlain];
    self.lyricTableView.backgroundColor = [UIColor clearColor];
    [self.mainScrollView addSubview:_lyricTableView];
    
    //
    self.currentTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, kScreenWidth + 20, 50, 40)];
    self.currentTimeLabel.backgroundColor = [UIColor redColor];
    //self.currentTimeLabel.text = @"00:00";
    self.currentTimeLabel.layer.cornerRadius =8;
    _currentTimeLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _currentTimeLabel.layer.borderWidth = 2.0;
    [self addSubview:_currentTimeLabel];
    self.progressSlider = [[UISlider alloc]initWithFrame:CGRectMake(70, kScreenWidth +35, 230, 10)];
    //    self.progressSlider.minimumValue = 0;
    //    self.progressSlider.maximumValue = 30;
    //    self.progressSlider.value = 10;
    //    [self.progressSlider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_progressSlider];
    
    self.totleTiemLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.progressSlider.frame) + 10, CGRectGetMinY(self.currentTimeLabel.frame), CGRectGetWidth(self.currentTimeLabel.frame), CGRectGetHeight(self.currentTimeLabel.frame))];
    self.totleTiemLabel.backgroundColor = [UIColor redColor];
    //self.totleTiemLabel.text = @"30:00";
    self.totleTiemLabel.layer.cornerRadius =8;
    self.totleTiemLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.totleTiemLabel.layer.borderWidth = 2.0;
    [self addSubview:_totleTiemLabel];
    self.lastButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.lastButton.layer.cornerRadius = 8;
    self.lastButton.frame = CGRectMake(20, 500, 90, 70);
    //self.lastButton.backgroundColor = [UIColor greenColor];
    [self.lastButton setTitle:@"上一首" forState:UIControlStateNormal];
    [self.lastButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.lastButton addTarget:self action:@selector(lastButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_lastButton];
    self.playButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.playButton.frame = CGRectMake(CGRectGetMaxX(self.lastButton.frame) + 30, CGRectGetMinY(self.lastButton.frame), CGRectGetWidth(self.lastButton.frame), CGRectGetHeight(self.lastButton.frame));
    // self.playButton.backgroundColor = [UIColor redColor];
    self.playButton.layer.cornerRadius = 8;
    [self.playButton setTitle:@"播放" forState:UIControlStateNormal];
    [self.playButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[self.playButton addTarget:self action:@selector(playButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_playButton];
    self.nextButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.nextButton.frame = CGRectMake(CGRectGetMaxX(self.playButton.frame) + 30, CGRectGetMinY(self.playButton.frame), CGRectGetWidth(self.lastButton.frame), CGRectGetHeight(self.lastButton.frame));
    //self.nextButton.backgroundColor = [UIColor greenColor];
    [self.nextButton setTitle:@"下一首" forState:UIControlStateNormal];
    self.nextButton.layer.cornerRadius = 8;
    [self.nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[self.nextButton addTarget:self action:@selector(nextButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_nextButton];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)lastButtonAction:(UIButton *)sender
{
    [self.delegate lastSongAction];
}
@end
