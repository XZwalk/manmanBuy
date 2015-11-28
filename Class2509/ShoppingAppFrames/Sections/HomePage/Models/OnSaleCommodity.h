//
//  OnSaleCommodity.h
//  Class2509
//
//  Created by laouhn on 15/7/9.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OnSaleCommodity : NSObject

@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *mall;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, assign) BOOL isCollection;






- (id)initWithDictionary:(NSDictionary *)dic;

@end
