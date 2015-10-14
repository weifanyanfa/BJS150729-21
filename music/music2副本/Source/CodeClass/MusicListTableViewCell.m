//
//  MusicListTableViewCell.m
//  music2
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 uis. All rights reserved.
//

#import "MusicListTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation MusicListTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setupView];
    }
    return self;
}
-(void)p_setupView
{
    self.MyimageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 100, 70)];
    //self.MyimageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_MyimageView];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 10, 220, 30)];
    //self.titleLabel.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_titleLabel];
    self.xiangqingLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 50, 220, 30)];
    //self.xiangqingLabel.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_xiangqingLabel];
}
- (void)awakeFromNib {
    // Initialization code
}
-(void)setModel:(MusicList *)model
{
    self.titleLabel.text = model.name;
    self.xiangqingLabel.text = model.singer;
    [self.MyimageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
