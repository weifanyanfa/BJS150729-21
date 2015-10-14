//
//  MusicPlay.h
//  music2
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 uis. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MusicPlayDelegate <NSObject>

-(void)lastSongAction;

@end
@interface MusicPlay : UIView
@property(nonatomic,strong)UIScrollView *mainScrollView;
@property(nonatomic,strong)UIImageView *Musicimageview;
@property(nonatomic,strong)UITableView *lyricTableView;
@property(nonatomic,strong)UILabel *currentTimeLabel;

@property(nonatomic,strong)UISlider *progressSlider;
@property(nonatomic,strong)UILabel *totleTiemLabel;
@property(nonatomic,strong)UIButton *lastButton;
@property(nonatomic,strong)UIButton *playButton;
@property(nonatomic,strong)UIButton *nextButton;

@property(nonatomic,strong)UIImageView *rotateImageView;
@property(nonatomic,strong)CALayer *mvLaver;
@property(nonatomic,weak)id<MusicPlayDelegate>delegate;
@end
