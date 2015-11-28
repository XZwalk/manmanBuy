//
//  HeaderCell.m
//  Class2509
//
//  Created by 张祥 on 15/7/14.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "HeaderCell.h"

@interface HeaderCell ()




@end

@implementation HeaderCell


- (void)dealloc
{
    self.label = nil;
    
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
        self.label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.label];
        [self.label release];
        
    }
    return self;
}

@end
