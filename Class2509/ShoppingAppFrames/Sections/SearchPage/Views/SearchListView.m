//
//  SearchListView.m
//  Class2509
//
//  Created by laouhn on 15/7/14.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "SearchListView.h"

@implementation SearchListView

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
    self.seachTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    
    [self addSubview:self.seachTableView];
    [self.seachTableView release];
}



- (void)dealloc
{
    self.seachTableView = nil;
    [super dealloc];
}

@end
