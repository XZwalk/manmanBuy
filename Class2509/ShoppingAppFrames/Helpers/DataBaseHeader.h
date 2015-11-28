//
//  DataBaseHeader.h
//  Class2509
//
//  Created by laouhn on 15/7/17.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OnSaleCommodity.h"
@interface DataBaseHeader : NSObject

+ (BOOL)creatTableWithName:(NSString *)tableName;


+ (BOOL)addDataToTable:(NSString *)tableName WithModel:(OnSaleCommodity *)onSaleCommodity;
+ (NSMutableArray *)selectModelWithConditionToTable:(NSString *)tableName;
+ (BOOL)selectModelWithConditionWithTitle:(NSString *)title;
+ (BOOL)deleteDataWithKey:(id)key;
@end
