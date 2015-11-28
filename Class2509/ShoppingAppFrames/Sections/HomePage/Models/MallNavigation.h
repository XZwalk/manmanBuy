//
//  MallNavigation.h
//  Class2509
//
//  Created by laouhn on 15/7/10.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MallNavigation : NSObject

@property (nonatomic, copy)NSString *img;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *urlString;

- (id)initWithMallDic:(NSDictionary *)dic;

@end
