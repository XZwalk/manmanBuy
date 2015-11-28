//
//  SearchHotHeaderView.m
//  Class2509
//
//  Created by 张祥 on 15/7/10.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "SearchHotHeaderView.h"

@interface SearchHotHeaderView ()


@property (nonatomic, retain) UILabel *titleName;


@end

@implementation SearchHotHeaderView

- (void)dealloc
{
    self.titleName = nil;
    [super dealloc];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.frame.size.height);
        self.titleName = [[UILabel alloc] initWithFrame:rect];
        [self addSubview:self.titleName];
        
        self.titleName.text = @"热门搜索";
        
        //self.backgroundColor = [UIColor redColor];
        [self.titleName release];
    }
    return self;
}


@end
