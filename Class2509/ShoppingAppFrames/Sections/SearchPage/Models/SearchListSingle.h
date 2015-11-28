//
//  SearchListSingle.h
//  Class2509
//
//  Created by laouhn on 15/7/13.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchListSingle : NSObject

@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *mall;
@property (nonatomic, copy) NSString *proID;
@property (nonatomic, copy) NSString *mall_pic;
@property (nonatomic, copy) NSString *sales;
@property (nonatomic, copy) NSArray *mall_list;



- (id)initWithSearchListSingleDic:(NSDictionary *)dic;

@end
