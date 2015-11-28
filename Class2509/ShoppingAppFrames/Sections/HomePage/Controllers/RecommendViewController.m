//
//  RecommendViewController.m
//  Class2509
//
//  Created by laouhn on 15/7/15.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "RecommendViewController.h"
#import "ItemModel.h"
#import "UIImageView+WebCache.h"
#import "MyWaterFlowLayout.h"
#import "ServiceHelper.h"
#import "RecommendCell.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "BuySecondViewController.h"
#import "NSString+MyString.h"
#import "UIWindow+YzdHUD.h"
@interface RecommendViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateWaterFlowLayout, NetworkHelperDelegate>

@property (nonatomic, retain) UICollectionView *collectionView;

@property (nonatomic, retain) NSMutableArray *datasource;

@property (nonatomic, retain) ServiceHelper *helper;

@property (nonatomic, assign) int page;

@property (nonatomic, assign) BOOL isDownRefresh;

@end

@implementation RecommendViewController

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        MyWaterFlowLayout *layout = [[MyWaterFlowLayout alloc] init];
        layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width / 2, 0);
        layout.numberOfColumns = 2;
        layout.delegate = self;
        layout.sectionInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        
        //创建collectionView对象时必须为其指定layout参数，否则会出现crash
        self.collectionView = [[[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout] autorelease];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        [layout release];
        //预留位置
        
    }
    return _collectionView;
}
- (void)viewDidDisappear:(BOOL)animated
{
    [self.helper connectionCancel];
}


- (NSMutableArray *)datasource{
    if (!_datasource) {
        self.datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (void)dealloc{
    self.helper = nil;
    [_datasource release];
    [_collectionView release];
    [super dealloc];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView{
    [super loadView];
    [self.view addSubview:self.collectionView];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.page = 1;
    [self loadDataFromServerWithPage:self.page];
    
    [self.collectionView registerClass:[RecommendCell class] forCellWithReuseIdentifier:@"Cell"];
    [self addRefresh];
    
    
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backToFirstpage)] autorelease];
    
    
    
    
    
}

#pragma mark - 下拉刷新和上拉加载更多

- (void)addRefresh
{
    [self.collectionView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    [self.collectionView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
- (void)loadNewData
{
    self.isDownRefresh = YES;
    [self loadDataFromServerWithPage:1];
    
}
- (void)loadMoreData
{
    self.isDownRefresh = NO;
    [self loadDataFromServerWithPage:++self.page];
    
}
#pragma mark - 下载数据


- (void)loadDataFromServerWithPage:(int)page;
{
    self.helper = [ServiceHelper new];
    self.helper.delegate = self;
    [self.helper downloadDataWithUrlString:[NSString stringWithFormat:@"http://apapia.manmanbuy.com/index_json.ashx?jsoncallback=?&methodName=getWYtj&page=%d", self.page]];
}


#pragma mark - NetworkHelperDelegate
- (void)networkDataIsSuccessful:(id)obj
{
    [self.collectionView.header endRefreshing];
    [self.collectionView.footer endRefreshing];
    if (self.isDownRefresh) {
        [self.datasource removeAllObjects];
    }
    id array = [NSJSONSerialization JSONObjectWithData:obj options:NSJSONReadingMutableContainers error:nil];
    for (NSDictionary *dict in array) {
        ItemModel *itemModel = [[ItemModel alloc] initWithDictionary:dict];
        [self.datasource addObject:itemModel];
        [itemModel release];
    }
    
    [self.collectionView reloadData];
    
}

- (void)networkDataIsFail:(NSError *)error
{
    [self.collectionView.header endRefreshing];
    [self.collectionView.footer endRefreshing];
    //UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"网络连接错误请检查网络连接" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //[alertView show];
    //[alertView release];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datasource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    if (self.datasource.count != 0) {
        cell.itemModel = self.datasource[indexPath.row];
    }
    return cell;
}



- (CGFloat)collectionView:(UICollectionView *)collectionView waterFlowLayout:(MyWaterFlowLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ItemModel *item = self.datasource[indexPath.item];
    
    return [RecommendCell returnHeightForCell:item];
}

#pragma mark - UICollectionViewDelegate


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BuySecondViewController *buyProductVC = [BuySecondViewController new];
    buyProductVC.link = [[self.datasource[indexPath.row] gourl] separateUrl];
    [self.navigationController pushViewController:buyProductVC animated:YES];
    [self.view.window showHUDWithText:@"加载中" Type:ShowLoading Enabled:YES];
}


#pragma mark -
- (void)backToFirstpage
{
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden = NO;
    
    
}

@end
