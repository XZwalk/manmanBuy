//
//  ChooseList.m
//  Class2509
//
//  Created by 张祥 on 15/7/14.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "ChooseBrend.h"

@implementation ChooseBrend

- (void)dealloc
{
    self.brendnum = nil;
    self.brendname = nil;
    self.brendid = nil;
    [super dealloc];
}


- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        self.brendid = dic[@"brendid"];
        self.brendname = dic[@"brendname"];
        self.brendnum = dic[@"brendnum"];
        
    }
    return self;
}

@end
