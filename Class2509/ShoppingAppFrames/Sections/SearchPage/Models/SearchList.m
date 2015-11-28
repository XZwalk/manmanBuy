//
//  SearchList.m
//  Class2509
//
//  Created by 张祥 on 15/7/9.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "SearchList.h"

@implementation SearchList

- (void)dealloc
{
    self.listID = nil;
    self.listName = nil;
    self.detailList = nil;
    
    [super dealloc];
}

- (id)initWithListDIc:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        self.listName = dic[@"itemSort"];
        self.listID = dic[@"itemId"];
        self.detailList = dic[@"subSort"];
    }
    
    return self;
    
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@, %@", _listID, _listName];
}

@end
