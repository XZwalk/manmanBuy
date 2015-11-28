//
//  MallList.h
//  Class2509
//
//  Created by 张祥 on 15/7/16.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MallList : NSObject
@property (nonatomic, copy) NSString *mall_img, *mall_link, *mall_name, *mall_price, *mall_sales;



- (id)initWithMallListDic:(NSDictionary *)dic;

@end
