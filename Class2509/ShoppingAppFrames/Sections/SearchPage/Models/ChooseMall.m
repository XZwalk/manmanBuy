//
//  ChooseMall.m
//  Class2509
//
//  Created by 张祥 on 15/7/14.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "ChooseMall.h"

@implementation ChooseMall

- (void)dealloc
{
    self.mallid = nil;
    self.mallname = nil;
    self.mallnum = nil;
    [super dealloc];
}

- (id)initWithDic:(NSDictionary *)dic
{
    
    self = [super init];
    if (self) {
        
        self.mallid = dic[@"mallid"];
        self.mallname = dic[@"mallname"];
        self.mallnum = dic[@"mallnum"];
        
    }
    
    return self;
}
@end
