
//
//  CollectionViewController.m
//  Class2509
//
//  Created by laouhn on 15/7/17.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "CollectionViewController.h"
#import "OnSaleCommodity.h"
#import "CommodityCell.h"
#import "SaveMoneyView.h"
#import "HomeDetailViewController.h"
#import "DataBaseHeader.h"
@interface CollectionViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) SaveMoneyView *myView;

@property (nonatomic, retain) NSMutableArray *datasourceArray;

@end

@implementation CollectionViewController

- (void)loadView
{
    [super loadView];
    self.myView = [[SaveMoneyView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.myView;
    [self.myView release];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.datasourceArray = [DataBaseHeader selectModelWithConditionToTable:@"OnSaleCommodity"];
    self.myView.tableView.delegate = self;
    self.myView.tableView.dataSource = self;
    [self.myView.tableView registerClass:[CommodityCell class] forCellReuseIdentifier:@"haha"];
    
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(handleBarButtonItem:)] autorelease];
}
- (void)handleBarButtonItem:(UIBarButtonItem *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden = NO;
}


#pragma mark - 懒加载
- (NSMutableArray *)dataSourceArray
{
    if (!_datasourceArray) {
        self.datasourceArray = [@[] mutableCopy];
    }
    
    return _datasourceArray;
}





#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommodityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"haha" forIndexPath:indexPath];
    cell.commodity = self.dataSourceArray[indexPath.row];
    [cell.collectionButton removeFromSuperview];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}
#pragma mark - UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeDetailViewController *homeDetailVC = [HomeDetailViewController new];
    homeDetailVC.ID = [self.dataSourceArray[indexPath.row] ID];
    homeDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:homeDetailVC animated:YES];
    [homeDetailVC release];
}

#pragma mark - 滑动删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [DataBaseHeader deleteDataWithKey:[self.datasourceArray[indexPath.row] title]];
        
        [self.dataSourceArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else {
        
    }
}
- (void)dealloc
{
    self.myView = nil;
    self.datasourceArray = nil;
    [super dealloc];
}

@end
