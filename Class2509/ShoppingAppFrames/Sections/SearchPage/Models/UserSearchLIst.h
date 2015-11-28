//
//  UserSearchLIst.h
//  Class2509
//
//  Created by 张祥 on 15/7/13.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSearchLIst : NSObject
@property (nonatomic, copy) NSString *iszy;
@property (nonatomic, copy) NSString *titleName;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *sell;
@property (nonatomic, copy) NSString *mall;
@property (nonatomic, copy) NSString *imageUrl;

@property (nonatomic, copy) NSString *gourl;



- (id)initWithDic:(NSDictionary *)dic;


@end
