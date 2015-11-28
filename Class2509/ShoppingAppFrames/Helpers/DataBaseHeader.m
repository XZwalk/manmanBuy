//
//  DataBaseHeader.m
//  Class2509
//
//  Created by laouhn on 15/7/17.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "DataBaseHeader.h"
#import <sqlite3.h>
#import "DataBase.h"
@implementation DataBaseHeader

+ (BOOL)creatTableWithName:(NSString *)tableName
{
    sqlite3 *dataBase = [DataBase openDataBase];
    
    NSString *Command = [NSString stringWithFormat:@"create table OnSaleCommodity(ID text primary key, img text, title text, subTitle text, mall text)"];
    const char *command = [Command cStringUsingEncoding:NSASCIIStringEncoding];
    int result = sqlite3_exec(dataBase, command, nil, nil, nil);
    
    if (result == SQLITE_OK) {
        [DataBase closeDataBase];
        return YES;
    }
    else
    {
        [DataBase closeDataBase];
        return NO;
    }
}

+ (BOOL)addDataToTable:(NSString *)tableName WithModel:(OnSaleCommodity *)onSaleCommodity
{
    sqlite3 *db = [DataBase openDataBase];
    sqlite3_stmt *stmt = nil;
    NSString *Command = [NSString stringWithFormat:@"insert into OnSaleCommodity values (?, ?, ?, ?, ?)"];
   
    const char *command = [Command cStringUsingEncoding:NSASCIIStringEncoding];
    int result = sqlite3_prepare_v2(db, command, -1, &stmt, nil);
    
    
    
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [onSaleCommodity.ID UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 2, [onSaleCommodity.img UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 3, [onSaleCommodity.title UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 4, [onSaleCommodity.subTitle UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 5, [onSaleCommodity.mall UTF8String], -1, nil);
        
        if (sqlite3_step(stmt) == SQLITE_DONE) {
            sqlite3_finalize(stmt);
            [DataBase closeDataBase];
            return YES;
        }
    }
    
    [DataBase closeDataBase];
    return NO;
}

+ (NSMutableArray *)selectModelWithConditionToTable:(NSString *)tableName
{
    sqlite3 *db = [DataBase openDataBase];
    sqlite3_stmt *stmt = nil;
    NSString *Command = [NSString stringWithFormat:@"select * from %@", tableName];
    
    const char *command = [Command cStringUsingEncoding:NSASCIIStringEncoding];
    int result = sqlite3_prepare_v2(db, command, -1, &stmt, nil);
    
    NSMutableArray *dataArray = [@[] mutableCopy];
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            const unsigned char *ID = sqlite3_column_text(stmt, 0);
            const unsigned char *img = sqlite3_column_text(stmt, 1);
            const unsigned char *title = sqlite3_column_text(stmt, 2);
            const unsigned char *subTitle = sqlite3_column_text(stmt, 3);
            const unsigned char *mall = sqlite3_column_text(stmt, 4);
            OnSaleCommodity *onSaleCommodity = [OnSaleCommodity new];

            onSaleCommodity.ID = [NSString stringWithUTF8String:(const char *)ID];
            onSaleCommodity.img = [NSString stringWithUTF8String:(const char *)img];

            onSaleCommodity.title = [NSString stringWithUTF8String:(const char *)title];

            onSaleCommodity.subTitle = [NSString stringWithUTF8String:(const char *)subTitle];

            onSaleCommodity.mall = [NSString stringWithUTF8String:(const char *)mall];
            [dataArray addObject:onSaleCommodity];
            
            [onSaleCommodity release];
        }
    }
    sqlite3_finalize(stmt);
    [DataBase closeDataBase];
    return dataArray;
}

+ (BOOL)selectModelWithConditionWithTitle:(NSString *)title
{
    sqlite3 *db = [DataBase openDataBase];
    sqlite3_stmt *stmt = nil;
    NSString *Command = [NSString stringWithFormat:@"select * from OnSaleCommodity where title = ?"];
    
    const char *command = [Command cStringUsingEncoding:NSASCIIStringEncoding];
    int result = sqlite3_prepare_v2(db, command, -1, &stmt, nil);
    
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [title UTF8String], -1, nil);
        
        if (sqlite3_step(stmt) == SQLITE_ROW) {
            
            sqlite3_finalize(stmt);
            [DataBase closeDataBase];
            return YES;
        }

    }
    sqlite3_finalize(stmt);
    [DataBase closeDataBase];
    return NO;
}
+ (BOOL)deleteDataWithKey:(id)key
{
    sqlite3 *db = [DataBase openDataBase];
    sqlite3_stmt *stmt = nil;
    NSString *Command = [NSString stringWithFormat:@"delete from OnSaleCommodity where title = ?"];
    const char *command = [Command cStringUsingEncoding:NSASCIIStringEncoding];
    int result = sqlite3_prepare_v2(db, command, -1, &stmt, nil);
    
    if (result == SQLITE_OK) {
        
        sqlite3_bind_text(stmt, 1, [key UTF8String], -1, nil);
        if (sqlite3_step(stmt) == SQLITE_DONE) {
            
            //NSLog(@"删除");
            sqlite3_finalize(stmt);
            [DataBase closeDataBase];
            return YES;
        }
    }
    
    return NO;
}



@end
