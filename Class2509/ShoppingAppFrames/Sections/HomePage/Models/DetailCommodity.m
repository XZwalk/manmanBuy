//
//  DetailCommodity.m
//  Class2509
//
//  Created by laouhn on 15/7/10.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "DetailCommodity.h"

@implementation DetailCommodity


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (void)dealloc
{
    self.addtime = nil;
    self.author = nil;
    self.content = nil;
    self.golink = nil;
    self.img = nil;
    self.mall = nil;
    self.subTitle = nil;
    self.title = nil;
    [super dealloc];
}
@end
