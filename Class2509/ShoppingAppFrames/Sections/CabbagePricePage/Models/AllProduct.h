//
//  AllProduct.h
//  Class2509
//
//  Created by laouhn on 15/7/9.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllProduct : NSObject

@property (nonatomic, copy)NSString *img;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *link;
@property (nonatomic, retain)NSString *mall;
@property (nonatomic, assign)float price;
@property (nonatomic, assign)float oprice;


- (id)initWithProductDic:(NSDictionary *)dic;

@end
