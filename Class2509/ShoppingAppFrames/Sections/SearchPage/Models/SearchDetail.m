//
//  SearchDetail.m
//  Class2509
//
//  Created by 张祥 on 15/7/9.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "SearchDetail.h"





@implementation SearchDetail


- (void)dealloc
{
    self.detailID = nil;
    self.detailName =nil;
    [super dealloc];
}


- (id)initWithDetailDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        
        self.detailName = dic[@"itemname"];
        self.detailID = dic[@"itemsid"];
        
    }
    
    return self;
    
    
}
@end
