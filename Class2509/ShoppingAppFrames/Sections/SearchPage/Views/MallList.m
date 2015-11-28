//
//  MallList.m
//  Class2509
//
//  Created by 张祥 on 15/7/16.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "MallList.h"

@implementation MallList


- (void)dealloc
{
    self.mall_img = nil;
    self.mall_link = nil;
    self.mall_name = nil;
    self.mall_price = nil;
    self.mall_sales = nil;
    [super dealloc];
}


- (id)initWithMallListDic:(NSDictionary *)dic
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
