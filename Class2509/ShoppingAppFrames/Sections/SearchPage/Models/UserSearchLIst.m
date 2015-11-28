//
//  UserSearchLIst.m
//  Class2509
//
//  Created by 张祥 on 15/7/13.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "UserSearchLIst.h"

@implementation UserSearchLIst

- (void)dealloc
{
    self.iszy = nil;
    self.titleName = nil;
    self.price = nil;
    self.sell = nil;
    self.imageUrl = nil;
    self.mall = nil;
    self.gourl = nil;
    [super dealloc];
}


- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        self.iszy = dic[@"iszy"];
        self.titleName = dic[@"title"];
        self.price = dic[@"price"];
        self.mall = dic[@"mall"];
        self.sell = dic[@"sales"];
        self.imageUrl = dic[@"img"];
        self.gourl = dic[@"gourl"];
        
    }
    
    
    return self;
    
}






@end
