//
//  HomeModel.m
//  Class2509
//
//  Created by laouhn on 15/7/10.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "HomeModel.h"

@interface HomeModel  ()

@end
@implementation HomeModel

- (void)dealloc
{
    self.image = nil;
    self.labelText = nil;
    self.ID = nil;
    [super dealloc];
}
@end
