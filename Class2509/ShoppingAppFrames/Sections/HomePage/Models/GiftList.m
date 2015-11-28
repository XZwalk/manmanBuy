//
//  GiftList.m
//  Class2509
//
//  Created by laouhn on 15/7/13.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "GiftList.h"

@implementation GiftList


- (void)dealloc
{
    self.cover_image_url = nil;
    self.title = nil;
    self.content_url = nil;
    [super dealloc];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
