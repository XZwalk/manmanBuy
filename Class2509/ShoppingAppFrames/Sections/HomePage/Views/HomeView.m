//
//  HomeView.m
//  Class2509
//
//  Created by laouhn on 15/7/8.
//  Copyright (c) 2015年 张祥. All rights reserved.
//
#define kSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#import "HomeView.h"

@interface HomeView ()

@property (nonatomic, retain) UILabel *label;

@end

@implementation HomeView



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
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, CGRectGetHeight(self.frame)) style:UITableViewStyleGrouped];
    [self addSubview:self.tableView];
    [self.tableView release];
    
    self.tableView.tableHeaderView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 210)] autorelease];
    UICollectionViewFlowLayout *flowLayout = [[[UICollectionViewFlowLayout alloc] init] autorelease];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 135, kSCREEN_WIDTH, 65) collectionViewLayout:flowLayout];
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.itemSize = CGSizeMake((kSCREEN_WIDTH - 60) / 4, 55);
    
    [self.tableView.tableHeaderView addSubview:self.collectionView];
    self.collectionView.alwaysBounceHorizontal = NO;
    
    [self.collectionView release];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(5, 200, kSCREEN_WIDTH, 20)];
    self.label.text = @"今日活动推荐";
    self.label.font = [UIFont systemFontOfSize:14];
    [self.tableView.tableHeaderView addSubview:self.label];
    [self.label release];
}


- (void)dealloc
{
    self.collectionView = nil;
    self.tableView = nil;
    self.label = nil;
    [super dealloc];
}
@end
