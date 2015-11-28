//
//  HotSearch.m
//  Class2509
//
//  Created by 张祥 on 15/7/10.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "HotSearch.h"

@implementation HotSearch


- (void)dealloc
{
    self.searchID = nil;
    self.searchName = nil;
    [super dealloc];
}

- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.searchName = dic[@"itemSort"];
        self.searchID = dic[@"itemId"];
    }
    return self;
}



- (NSString *)description
{
    return [NSString stringWithFormat:@"%@, %@", self.searchID, self.searchName];
}



@end
