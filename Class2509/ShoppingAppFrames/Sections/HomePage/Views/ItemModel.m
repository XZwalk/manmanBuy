//
//  ItemModel.m
//  Lesson_UI_19
//
//  Created by MouXiangyang on 14/10/15.
//  Copyright (c) 2014年 Duke. All rights reserved.
//

#import "ItemModel.h"

@implementation ItemModel

- (id)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        self.thumbURLstring = dict[@"img"];
    }
    return self;
}

+ (id)itemWithDictionary:(NSDictionary *)dict{
    return [[[[self class] alloc] initWithDictionary:dict] autorelease];
}
- (void)dealloc{
    [_thumbURLstring release];
    self.title = nil;
    self.subTitle = nil;
    self.mall = nil;
    self.gourl = nil;
    [super dealloc];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
