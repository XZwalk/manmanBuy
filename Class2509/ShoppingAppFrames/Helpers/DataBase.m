//
//  DataBase.m
//  Class2509
//
//  Created by laouhn on 15/7/17.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "DataBase.h"

static sqlite3 *dataBase = nil;

@implementation DataBase


+ (sqlite3 *)openDataBase
{
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString *dataBasePath = [documentPath stringByAppendingPathComponent:@"OnSaleCommodity.sqlite"];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:dataBasePath]) {
        
        sqlite3_open([dataBasePath UTF8String], &dataBase);
    
        //NSLog(@"数据库已打开");
    }
    else
    {
        int result = sqlite3_open([dataBasePath UTF8String], &dataBase);
        if (result == SQLITE_DONE) {
            //NSLog(@"数据库创建成功");
        }
    }
    
    return dataBase;
}


+ (void)closeDataBase
{
    sqlite3_close(dataBase);
    dataBase = nil;
}

@end
