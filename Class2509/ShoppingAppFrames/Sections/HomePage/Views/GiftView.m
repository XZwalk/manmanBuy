//
//  GiftView.m
//  Class2509
//
//  Created by laouhn on 15/7/13.
//  Copyright (c) 2015年 张祥. All rights reserved.
//
#define kSCREEN_BOUNDS [UIScreen mainScreen].bounds
#import "GiftView.h"



@implementation GiftView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(kSCREEN_BOUNDS), CGRectGetHeight(kSCREEN_BOUNDS) + 40) style:UITableViewStylePlain];
        [self addSubview:self.tableView];
        [self.tableView release];
    }
    return self;
}
- (void)dealloc
{
    self.tableView = nil;
    [super dealloc];
}

@end