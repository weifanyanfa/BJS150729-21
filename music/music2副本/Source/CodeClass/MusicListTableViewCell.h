//
//  MusicListTableViewCell.h
//  music2
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 uis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicList.h"
@interface MusicListTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *MyimageView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *xiangqingLabel;
@property(nonatomic,strong)MusicList *model;
@end
