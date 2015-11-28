//
//  SearchDetail.h
//  Class2509
//
//  Created by 张祥 on 15/7/9.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchDetail : NSObject

@property (nonatomic, copy) NSString *detailName;

@property (nonatomic, copy) NSString *detailID;


- (id)initWithDetailDic:(NSDictionary *)dic;

@end
