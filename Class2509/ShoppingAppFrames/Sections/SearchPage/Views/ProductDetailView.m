//
//  ProductDetailView.m
//  Class2509
//
//  Created by laouhn on 15/7/15.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "ProductDetailView.h"

@implementation ProductDetailView


- (void)dealloc
{
    self.detailView = nil;
    [super dealloc];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTableView];
    }
    return self;
}

- (void)addTableView
{
    self.detailView = [[UITableView alloc] initWithFrame:CGRectMake(0, -34, self.frame.size.width, self.frame.size.height) style:UITableViewStyleGrouped];
    self.detailView.backgroundColor = [UIColor whiteColor];
    
    
    [self addSubview:self.detailView];
    [self.detailView release];
}

@end
