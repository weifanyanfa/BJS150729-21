//
//  MusicList.m
//  music2
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 uis. All rights reserved.
//

#import "MusicList.h"

@implementation MusicList
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    if ([key isEqualToString:@"lyric"]) {
        self.timeLyric = [value componentsSeparatedByString:@"\n"];
    }
}
@end
