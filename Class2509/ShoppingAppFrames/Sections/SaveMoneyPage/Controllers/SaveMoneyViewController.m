//
//  SaveMoneyViewController.m
//  ShoppingApp
//
//  Created by 张祥 on 15/7/8.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "SaveMoneyViewController.h"
#import "SaveMoneyView.h"
#import "CommodityCell.h"
#import "HomeDetailViewController.h"
#import "ServiceHelper.h"
#import "MJRefresh.h"
#import "DataBaseHeader.h"
#import "UIWindow+YzdHUD.h"
@interface SaveMoneyViewController ()<UITableViewDataSource, UITableViewDelegate, NetworkHelperDelegate>
@property (nonatomic, retain) SaveMoneyView *saveMoneyView;
@property (nonatomic, retain) NSMutableArray *dataSourceArray;
@property (nonatomic, retain) ServiceHelper *helper;
@property (nonatomic, assign) BOOL isDownRefresh;
@property (nonatomic, assign) int page;
@property (nonatomic, retain) NSMutableArray *collectionArray;
@end

@implementation SaveMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backToFirstPage)];
    
    
    [self loadDataForeView];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.collectionArray = [DataBaseHeader selectModelWithConditionToTable:@"OnSaleCommodity"];
    [self.saveMoneyView.tableView reloadData];
}

- (void)backToFirstPage
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden = NO;
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
}

- (void)loadDataForeView
{
    self.page = 1;
    [self.saveMoneyView.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.saveMoneyView.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.saveMoneyView.tableView.delegate = self;
    self.saveMoneyView.tableView.dataSource = self;
    [self.saveMoneyView.tableView registerClass:[CommodityCell class] forCellReuseIdentifier:@"hehe"];
    [self downloadDataWithPage:self.page];

}

- (void)loadNewData
{
    self.isDownRefresh = YES;
    [self downloadDataWithPage:1];
    
}
- (void)loadMoreData
{
    self.isDownRefresh = NO;
    [self downloadDataWithPage:++self.page];
    
}

#pragma mark - 懒加载
- (NSMutableArray *)dataSourceArray
{
    if (!_dataSourceArray) {
        self.dataSourceArray = [@[] mutableCopy];
    }
    
    return _dataSourceArray;
}
- (ServiceHelper *)helper
{
    if (!_helper) {
        self.helper = [[ServiceHelper alloc] init];
        _helper.delegate  = self;
    }
    return _helper;
}

- (void)downloadDataWithPage:(int)page
{
    [self.helper downloadDataWithUrlString:@"http://apapia.manmanbuy.com/index_json.ashx?jsoncallback=?&methodName=getcuxiaolist&page=2"];
}
#pragma mark - NetworkHelperDelegate

- (void)networkDataIsSuccessful:(id)obj
{
    id dataObj = [NSJSONSerialization JSONObjectWithData:obj options:NSJSONReadingMutableContainers error:nil];
    for (NSDictionary *dic in dataObj) {
        OnSaleCommodity *commodity = [[OnSaleCommodity alloc] initWithDictionary:dic];
        [self.dataSourceArray addObject:commodity];
        [commodity release];
    }
    [self.saveMoneyView.tableView reloadData];
}


- (void)networkDataIsFail:(NSError *)error
{
   // UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"网络连接错误" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //[alertView show];
    //[alertView release];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommodityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hehe" forIndexPath:indexPath];
    cell.commodity = self.dataSourceArray[indexPath.row];
    if ([self containsObject:cell.commodity]) {
        [cell.collectionButton setImage:[UIImage imageNamed:@"rr"] forState:UIControlStateNormal];
        cell.commodity.isCollection = YES;
    }
    else
    {
        [cell.collectionButton setImage:[UIImage imageNamed:@"tt"] forState:UIControlStateNormal];
        cell.commodity.isCollection = NO;
    }    [cell.collectionButton addTarget:self action:@selector(handelCollection:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}


- (BOOL)containsObject:(OnSaleCommodity *)commodity
{
    
    for (OnSaleCommodity *obj in self.collectionArray) {
        if ([obj.title isEqualToString:commodity.title]) {
            return YES;
        }
    }
    
    return NO;
}
#pragma mark - 收藏按钮相关
- (void)handelCollection:(UIButton *)sender
{
    
    id obj = sender;
    while (![obj isKindOfClass:[UITableViewCell class]]) {
        obj = [obj nextResponder];
    }
    NSIndexPath *indexPath = [self.saveMoneyView.tableView indexPathForCell:(CommodityCell *)obj];
    
    
    OnSaleCommodity *commodity = self.dataSourceArray[indexPath.row];
    if (commodity.isCollection)
    {
        commodity.isCollection = !commodity.isCollection;
        [DataBaseHeader deleteDataWithKey:commodity.title];
        [self.collectionArray removeObject:commodity];
        [((CommodityCell *)obj).collectionButton setImage:[UIImage imageNamed:@"tt"] forState:UIControlStateNormal];
    }
    else
    {
        commodity.isCollection = !commodity.isCollection;
        [DataBaseHeader addDataToTable:@"OnSaleCommodity" WithModel:commodity];
        [self.collectionArray addObject:commodity];
        [((CommodityCell *)obj).collectionButton setImage:[UIImage imageNamed:@"rr"] forState:UIControlStateNormal];
    }
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

#pragma mark -
- (void)loadView
{
    self.saveMoneyView = [[SaveMoneyView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.saveMoneyView;
    [self.saveMoneyView release];
}

- (void)dealloc
{
    self.helper.delegate = nil;
    self.dataSourceArray = nil;
    self.helper = nil;
    self.saveMoneyView = nil;
    [super dealloc];
}


@end
