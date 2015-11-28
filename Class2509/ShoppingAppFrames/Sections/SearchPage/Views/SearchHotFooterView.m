//
//  SearchHotFooterView.m
//  Class2509
//
//  Created by 张祥 on 15/7/10.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "SearchHotFooterView.h"

@interface SearchHotFooterView ()


@property (nonatomic, retain) UILabel *titleName;


@end

@implementation SearchHotFooterView
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
        self.titleName.text = @"商品类目";

        //self.backgroundColor = [UIColor redColor];
        [self.titleName release];
        
    }
    return self;
}






@end
