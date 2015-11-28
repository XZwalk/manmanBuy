//
//  MallNavigation.m
//  Class2509
//
//  Created by laouhn on 15/7/10.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "MallNavigation.h"

@implementation MallNavigation

- (id)initWithMallDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
        self.urlString = [dic objectForKey:@"url"];
    }
    return self;
}


- (void)dealloc
{
    self.img = nil;
    self.urlString = nil;
    self.name  = nil;
    [super dealloc];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
