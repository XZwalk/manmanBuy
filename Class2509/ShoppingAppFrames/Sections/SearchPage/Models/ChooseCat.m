//
//  ChooseCat.m
//  Class2509
//
//  Created by 张祥 on 15/7/14.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "ChooseCat.h"

@implementation ChooseCat

- (void)dealloc
{
    self.catid = nil;
    self.catname = nil;
    self.catnum = nil;
    [super dealloc];
}

- (id)initWithDic:(NSDictionary *)dic
{
    
    self = [super init];
    if (self) {
        
        self.catid = dic[@"catid"];
        self.catname = dic[@"catname"];
        self.catnum = dic[@"catnum"];

    }
    
    return self;
}
@end
