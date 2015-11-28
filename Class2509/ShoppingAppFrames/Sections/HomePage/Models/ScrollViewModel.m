//
//  ScrollViewModel.m
//  Class2509
//
//  Created by laouhn on 15/7/10.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "ScrollViewModel.h"

@implementation ScrollViewModel


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


- (void)dealloc
{
    self.title = nil;
    self.cover_image_url = nil;
    self.ID = nil;
    [super dealloc];
}
@end
