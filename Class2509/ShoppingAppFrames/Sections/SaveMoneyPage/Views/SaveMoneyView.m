//
//  SaveMoneyView.m
//  Class2509
//
//  Created by laouhn on 15/7/9.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "SaveMoneyView.h"

@interface SaveMoneyView ()



@end
@implementation SaveMoneyView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
     
        [self addAllViews];
    }
    return self;
}


- (void)addAllViews
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    [self addSubview:self.tableView];
    [self.tableView release];
}



- (void)dealloc
{
    self.tableView = nil;
    [super dealloc];
}

@end
