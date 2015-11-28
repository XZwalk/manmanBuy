//
//  WomenViewController.m
//  Class2509
//
//  Created by laouhn on 15/7/9.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "WomenViewController.h"
#import "CollectionCell.h"
#import "ServiceHelper.h"
#import "CabBageView.h"
#import "AllProduct.h"
#import "ClassBuyViewController.h"
#import "NSString+MyString.h"
#import "UIWindow+YzdHUD.h"
@interface WomenViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,NetworkHelperDelegate>

@property (nonatomic, retain)CabBageView *cabView;
@property (nonatomic, retain)NSMutableArray *dataAry;
@property (nonatomic, assign)int pageNum;
@property (nonatomic, assign)BOOL isDownRefresh;
@end

@implementation WomenViewController

- (void)loadView
{
    self.cabView = [[[CabBageView alloc] initWithFrame:[UIScreen mainScreen].bounds] autorelease];
    self.view = self.cabView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cabView.cabBageView.delegate = self;
    self.cabView.cabBageView.dataSource = self;
    [self.cabView.cabBageView registerClass:[CollectionCell class] forCellWithReuseIdentifier:@"item"];
    
    [self.cabView.cabBageView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.cabView.cabBageView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    self.pageNum = 1;
    [self getDataFromServerWithPage:self.pageNum];
    
}

#pragma mark - 获取网络数据解析
- (void)getDataFromServerWithPage:(int)page
{
    ServiceHelper *helper = [[ServiceHelper alloc] init];
    helper.delegate = self;
    NSString *urlString = [NSString stringWithFormat:@"http://apapia.manmanbuy.com/index_json.ashx?jsoncallback=?&methodName=getBCJlist&cat=fushi&page=%d", page];
    [helper downloadDataWithUrlString:urlString];
    [helper release];
}
- (void)networkDataIsSuccessful:(id)obj
{
    [self.cabView.cabBageView.header endRefreshing];
    [self.cabView.cabBageView.footer endRefreshing];
    if (self.isDownRefresh) {
        [self.dataAry removeAllObjects];
    }
    
    NSArray *ary = [NSJSONSerialization JSONObjectWithData:obj
                                                   options:NSJSONReadingMutableContainers
                                                     error:nil];
    for (NSDictionary *dic in ary) {
        AllProduct *product = [[AllProduct alloc] initWithProductDic:dic];
        [self.dataAry addObject:product];
        [product release];
    }
    [self.cabView.cabBageView reloadData];
}

- (void)networkDataIsFail:(NSError *)error
{
    [self.cabView.cabBageView.header endRefreshing];
    [self.cabView.cabBageView.footer endRefreshing];
    
}

#pragma mark - 上拉刷新 下拉加载
- (void)loadNewData
{
    self.isDownRefresh = YES;
    [self getDataFromServerWithPage:1];
}

- (void)loadMoreData
{
    self.isDownRefresh = NO;
    [self getDataFromServerWithPage:++self.pageNum];
}

#pragma mark - 懒加载数据源
- (NSMutableArray *)dataAry
{
    if (_dataAry == nil) {
        self.dataAry = [NSMutableArray array];
    }
    return [[_dataAry retain] autorelease];
}


#pragma mark - dataSource代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataAry.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    cell.product = self.dataAry[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ClassBuyViewController *buyProduct = [[ClassBuyViewController alloc] init];
    [self.navigationController pushViewController:buyProduct animated:NO];
    self.tabBarController.tabBar.hidden = YES;
    [self.view.window showHUDWithText:@"加载中" Type:ShowLoading Enabled:YES];

    buyProduct.link = [[self.dataAry[indexPath.row] link] separateLinkUrl];
    [buyProduct release];
}


- (void)dealloc
{
    self.dataAry = nil;
    self.cabView = nil;
    [super dealloc];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
