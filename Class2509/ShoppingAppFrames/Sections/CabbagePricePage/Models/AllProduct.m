//
//  AllProduct.m
//  Class2509
//
//  Created by laouhn on 15/7/9.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "AllProduct.h"

@implementation AllProduct

- (id)initWithProductDic:(NSDictionary *)dic
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

- (void)dealloc
{
    self.img = nil;
    self.title = nil;
    self.mall = nil;
    self.link = nil;
    [super dealloc];
}

@end
