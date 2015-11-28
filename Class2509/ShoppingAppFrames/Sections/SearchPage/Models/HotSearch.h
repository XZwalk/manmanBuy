//
//  HotSearch.h
//  Class2509
//
//  Created by 张祥 on 15/7/10.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotSearch : NSObject

@property (nonatomic, copy) NSString *searchName;

@property (nonatomic, copy) NSString *searchID;


- (id)initWithDic:(NSDictionary *)dic;

@end
