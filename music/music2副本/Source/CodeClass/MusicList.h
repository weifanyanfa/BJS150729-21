//
//  MusicList.h
//  music2
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 uis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicList : NSObject
@property(nonatomic,strong)NSString *lyricTime;
@property(nonatomic,strong)NSString *lyricText;
@property(nonatomic,strong)NSString *mp3Url;
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *picUrl;
@property(nonatomic,strong)NSString *singer;
@property(nonatomic,strong)NSString *duration;
@property(nonatomic,strong)NSString *srtists_name;
@property(nonatomic,strong)NSString *timeLyric;
@property(nonatomic,strong)NSString *blurPicUrl;//模糊图片地址
@end
