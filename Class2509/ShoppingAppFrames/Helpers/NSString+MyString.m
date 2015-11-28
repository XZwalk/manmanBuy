//
//  NSString+MyString.m
//  Class2509
//
//  Created by laouhn on 15/7/9.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "NSString+MyString.h"

@implementation NSString (MyString)




#pragma mark - 分割出网址

- (NSString *)separateString
{
    return  [self componentsSeparatedByString:@"'"][1];
}

#pragma  mark - 分隔出图片网址

- (NSString *)findImageUrlString
{

    
    return nil;
}


- (NSString *)separateUrl
{
    NSString *myString = self;
    if ([self hasSuffix:@".app"]) {
        myString = [[myString componentsSeparatedByString:@"&m.app"] firstObject];
    }
    
    NSString *str = [myString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   return  [[str componentsSeparatedByString:@"tourl="] lastObject];
    
    
    
}



- (NSString *)separateLinkUrl
{
    return [[self componentsSeparatedByString:@"&url="] lastObject];
}




@end
