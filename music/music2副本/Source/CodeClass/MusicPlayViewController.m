//
//  MusicPlayViewController.m
//  music2
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 uis. All rights reserved.
//

#import "MusicPlayViewController.h"
#import "MusicPlay.h"
#import "MusicPlayTools.h"
#import "GetDataTools.h"
#import "UIImageView+WebCache.h"
@interface MusicPlayViewController ()<MusicPlayDelegate,MusicPlayToosDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *lyrivArr;
@property(nonatomic,strong)MusicPlay *rv;
@end
static MusicPlayViewController *mp = nil;
@implementation MusicPlayViewController
-(void)loadView
{
    self.rv = [[MusicPlay alloc]init];
    self.view = _rv;
}
+(instancetype)shareMusicViewPlayCon
{
    if (mp == nil) {
        dispatch_once_t once_token;
        dispatch_once(&once_token, ^{
            mp = [[MusicPlayViewController alloc]init];
        });
//        mp = [[MusicPlayViewController alloc]init];
    }
    return mp;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [MusicPlayTools shareMusicPlay].delegate = self;
    self.rv.delegate = self;
    
    [self.rv.lastButton addTarget:self action:@selector(nextSongButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.rv.progressSlider addTarget:self action:@selector(progressSliderAction:) forControlEvents:(UIControlEventValueChanged)];
    [self.rv.playButton addTarget:self action:@selector(playPauseButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
   [ [MusicPlayTools shareMusicPlay].player addObserver:self forKeyPath:@"rate" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil] ;
    self.rv.lyricTableView.delegate = self;
    self.rv.lyricTableView.dataSource = self;
    
    
    // Do any additional setup after loading the view.
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"rate"]) {
        if ([[change valueForKey:@"new"]integerValue] == 0) {
            [self.rv.playButton setTitle:@"已经暂停" forState:UIControlStateNormal];
        }
        else
        {
            [self.rv.playButton setTitle:@"正在播放" forState:UIControlStateNormal];
        }
    }
}
-(void)viewDidAppear:(BOOL)animated
{
    [self p_play];
}
-(void)p_play
{
    if ([[MusicPlayTools shareMusicPlay].model isEqual:[[GetDataTools shareGetData] getModelWithIndex:self.index]]) {
        return;
    }
    [MusicPlayTools shareMusicPlay].model = [[GetDataTools shareGetData]getModelWithIndex:self.index];
    [[MusicPlayTools shareMusicPlay]musicPlay];
    [self.rv.rotateImageView sd_setImageWithURL:[NSURL URLWithString:[MusicPlayTools shareMusicPlay].model.picUrl]];
    self.lyrivArr = [[MusicPlayTools shareMusicPlay] getMusicLyricArray];
    [self.rv.lyricTableView reloadData];
}
-(void)getCurTiem:(NSString *)curTime Totle:(NSString *)totleTime Progress:(CGFloat)progress
{
    self.rv.currentTimeLabel.text = curTime;
    self.rv.totleTiemLabel.text = totleTime;
    self.rv.progressSlider.value = progress;
    
    // 2d仿真变换.
    self.rv.rotateImageView.transform = CGAffineTransformRotate(self.rv.rotateImageView.transform, M_PI/360);
    
    // 返回歌词在数组中的位置,然后根据这个位置,将tableView跳到对应的那一行.
    NSInteger index = [[MusicPlayTools shareMusicPlay] getIndexWithCurTime];
    if (index == -1) {
        return;
    }
    NSIndexPath * tmpIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.rv.lyricTableView  selectRowAtIndexPath:tmpIndexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

-(void)lastSongAction
{
    if (self.index > 0) {
        self.index --;
    }else{
        self.index = [GetDataTools shareGetData].dataArr.count - 1;
    }
    [self p_play];
}
-(void)nextSongButtonAction:(UIButton *)sender
{
    if (self.index == [GetDataTools shareGetData].dataArr.count -1) {
        self.index = 0;
    }else
    {
        self.index ++;
    }
    [self p_play];
}

-(void)endOfPlayAction
{
    [self nextSongButtonAction:nil];
}
// 滑动slider
-(void)progressSliderAction:(UISlider *)sender
{
    [[MusicPlayTools shareMusicPlay] seekToTimeWithValue:sender.value];
}

// 暂停播放方法
-(void)playPauseButtonAction:(UIButton *)sender
{
    // 根据AVPlayer的rate判断.
    if ([MusicPlayTools shareMusicPlay].player.rate == 0) {
        [[MusicPlayTools shareMusicPlay] musicPlay];
    }else
    {
        [[MusicPlayTools shareMusicPlay] musicPause];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lyrivArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault)reuseIdentifier:@"cell"];
    }
    
    // 这里使用kvc取值,只是为了展示用,并不是必须用.
    cell.textLabel.text = [self.lyrivArr[indexPath.row] valueForKey:@"lyricStr"];
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
