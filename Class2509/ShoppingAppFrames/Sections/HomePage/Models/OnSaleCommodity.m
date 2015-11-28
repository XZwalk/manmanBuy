//
//  OnSaleCommodity.m
//  Class2509
//
//  Created by laouhn on 15/7/9.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "OnSaleCommodity.h"

@implementation OnSaleCommodity
- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
        self.ID = dic[@"id"];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (void)dealloc
{
    self.title = nil;
    self.subTitle = nil;
    self.mall = nil;
    self.ID = nil;
    self.img = nil;
    [super dealloc];
}


@end
