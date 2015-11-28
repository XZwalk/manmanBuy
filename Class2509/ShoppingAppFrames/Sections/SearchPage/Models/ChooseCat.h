//
//  ChooseCat.h
//  Class2509
//
//  Created by 张祥 on 15/7/14.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChooseCat : NSObject
@property (nonatomic, copy) NSString *catid, *catname, *catnum;




- (id)initWithDic:(NSDictionary *)dic;

@end
