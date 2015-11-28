//
//  ItemModel.h
//  Lesson_UI_19
//
//  Created by MouXiangyang on 14/10/15.
//  Copyright (c) 2014年 Duke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ItemModel : NSObject

@property (nonatomic, copy) NSString *thumbURLstring;//图片地址
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *mall;
@property (nonatomic, copy) NSString *gourl;
- (id)initWithDictionary:(NSDictionary *)dict;
+ (id)itemWithDictionary:(NSDictionary *)dict;

@end
