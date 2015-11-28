//
//  SearchListSingle.m
//  Class2509
//
//  Created by laouhn on 15/7/13.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "SearchListSingle.h"

@implementation SearchListSingle

- (void)dealloc
{
    self.mall = nil;
    self.mall_list = nil;
    self.mall_pic = nil;
    self.sales = nil;
    self.price = nil;
    self.proID = nil;
    self.img = nil;
    self.title = nil;
    [super dealloc];
}


- (id)initWithSearchListSingleDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
        
        self.proID = dic[@"id"];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
