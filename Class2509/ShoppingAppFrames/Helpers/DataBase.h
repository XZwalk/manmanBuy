//
//  DataBase.h
//  Class2509
//
//  Created by laouhn on 15/7/17.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface DataBase : NSObject




+ (sqlite3 *)openDataBase;


+ (void)closeDataBase;



@end
