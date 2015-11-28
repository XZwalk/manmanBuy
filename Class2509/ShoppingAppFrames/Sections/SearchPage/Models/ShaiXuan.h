//
//  ShaiXuan.h
//  Class2509
//
//  Created by laouhn on 15/7/14.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShaiXuan : NSObject

@property (nonatomic, copy)NSString *brendid;
@property (nonatomic, copy)NSString *brendname;

- (id)initWithShaiXuanDic:(NSDictionary *)dic;

@end
