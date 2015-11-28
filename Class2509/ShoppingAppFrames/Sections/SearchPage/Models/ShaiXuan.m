//
//  ShaiXuan.m
//  Class2509
//
//  Created by laouhn on 15/7/14.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "ShaiXuan.h"

@implementation ShaiXuan


- (void)dealloc
{
    self.brendid = nil;
    self.brendname = nil;
    [super dealloc];
}
- (id)initWithShaiXuanDic:(NSDictionary *)dic;
{
    self = [super init];
    if (self) {
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
