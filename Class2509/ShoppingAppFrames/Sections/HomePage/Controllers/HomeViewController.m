//
//  HomeViewController.m
//  ShoppingApp
//
//  Created by 张祥 on 15/7/8.
//  Copyright (c) 2015年 张祥. All rights reserved.
//
#define kSCREEN_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#import "HomeViewController.h"
#import "CabbagePriceViewController.h"
#import "ServiceHelper.h"
#import "OnSaleCommodity.h"
#import "CommodityCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+MyString.h"
#import "HomeDetailViewController.h"
#import "HomeModel.h"
#import "AFNetworking.h"
#import "MallNavigationViewController.h"
#import "ScrollViewModel.h"
#import "SDCycleScrollView.h"
#import "PageControllCell.h"
#import "GiftViewController.h"
#import "MJRefresh.h"
#import "MallNavigationViewController.h"
#import "CabbagePriceViewController.h"
#import "SaveMoneyViewController.h"
#import "RecommendViewController.h"
#import "AppDelegate.h"
#import "CollectionViewController.h"
#import "DataBaseHeader.h"
#import "UIWindow+YzdHUD.h"
#import "StatementViewController.h"
#import "AboutUsViewController.h"
@interface HomeViewController ()<UITableViewDataSource, SDCycleScrollViewDelegate, UITableViewDelegate, NetworkHelperDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) ServiceHelper *helper;
@property (nonatomic, retain) NSMutableArray *dataSourceArray;
@property (nonatomic, retain) NSMutableArray *myArray;
@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, retain) NSMutableArray *images;

@property (nonatomic, assign) BOOL isDownRefresh;
@property (nonatomic, assign) int page;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, retain) NSMutableArray *urlArray;


@property (nonatomic, retain) NSMutableArray *collectionArray;


@end

@implementation HomeViewController



//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    CGRect rect = cell.frame;
//    cell.frame = CGRectMake(- [UIScreen mainScreen].bounds.size.width, 0, cell.frame.size.width, cell.frame.size.height);
//
//    [UIView animateWithDuration:.2 animations:^{
//        cell.frame = rect;
//    }];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.homeView.tableView registerClass:[CommodityCell class] forCellReuseIdentifier:@"cell"];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.000 green:0.618 blue:0.062 alpha:1.000];
    [self loadDataForView];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.collectionArray = [DataBaseHeader selectModelWithConditionToTable:@"OnSaleCommodity"];
    [self.homeView.tableView reloadData];
}

- (void)loadDataForView
{
    self.page = 1;
    [self setTitlesAndImages];
    [self loadDataWith:self.page];
    [self downloadData];
    [self addRefresh];
    [self.homeView.collectionView registerClass:[PageControllCell class] forCellWithReuseIdentifier:@"qwe"];
    
    //添加侧边栏按钮图片
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"v6_category_all_icon1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu)] autorelease];
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(showMenu)];
    [DataBaseHeader creatTableWithName:@"OnSaleCommodity"];
    
}
#pragma mark Button actions

- (void)showMenu
{
    if (!_sideMenu) {
//        RESideMenuItem *homeItem = [[[RESideMenuItem alloc] initWithTitle:@"登陆" action:^(RESideMenu *menu, RESideMenuItem *item)
//                                     {
//                                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"登陆功能暂未开放" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                                         [alertView show];
//                                         [alertView release];
//                                     }] autorelease];
//        RESideMenuItem *exploreItem = [[[RESideMenuItem alloc] initWithTitle:@"注册" action:^(RESideMenu *menu, RESideMenuItem *item) {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"登陆功能暂未开放" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertView show];
//            [alertView release];
//        }] autorelease];
        RESideMenuItem *activityItem = [[[RESideMenuItem alloc] initWithTitle:@"我的收藏" action:^(RESideMenu *menu, RESideMenuItem *item) {
            
            CollectionViewController *collectionVC = [CollectionViewController new];
            collectionVC.title = item.title;
            [menu hide];
            [self.navigationController pushViewController:collectionVC animated:YES];
            
            collectionVC.tabBarController.tabBar.hidden = YES;
        }] autorelease];
        RESideMenuItem *profileItem = [[[RESideMenuItem alloc] initWithTitle:@"清除缓存" action:^(RESideMenu *menu, RESideMenuItem *item) {
            [self folderSizeAtPath:[self getPath]];
        }] autorelease];
        RESideMenuItem *logOutItem = [[[RESideMenuItem alloc] initWithTitle:@"免责声明" action:^(RESideMenu *menu, RESideMenuItem *item) {
            
            StatementViewController *statementVC = [[StatementViewController alloc] init];
            [menu hide];
            [self presentViewController:statementVC animated:YES completion:nil];
            [statementVC release];
            
        }] autorelease];
        RESideMenuItem *aboutUs = [[[RESideMenuItem alloc] initWithTitle:@"关于我们" action:^(RESideMenu *menu, RESideMenuItem *item) {
            [menu hide];
            AboutUsViewController *aboutVC = [[AboutUsViewController alloc] init];
            [self presentViewController:aboutVC animated:YES completion:nil];
            [aboutVC release];
        }] autorelease];
        RESideMenuItem * blackModelItem = [[[RESideMenuItem alloc] initWithTitle:@"夜间模式" action:^(RESideMenu *menu, RESideMenuItem *item) {
            if (self.view.window.alpha == 1.0) {
                self.view.window.alpha = 0.5;
            }else
            {
                self.view.window.alpha = 1.0;
            }
            
        }] autorelease];
        _sideMenu = [[RESideMenu alloc] initWithItems:@[activityItem, blackModelItem,profileItem, logOutItem, aboutUs]];
        _sideMenu.verticalOffset = IS_WIDESCREEN ? 110 : 76;
        _sideMenu.hideStatusBarArea = [AppDelegate OSVersion] < 7;
    }
    
    [_sideMenu show];
}

- (CGFloat)folderSizeAtPath:(NSString *)path
{
    //初始化一个文件管理类对象
    NSFileManager * fileManager = [NSFileManager defaultManager];
    CGFloat folderSize;
    
    //如果文件夹存在
    if ([fileManager fileExistsAtPath:path]) {
        NSArray * childerFiles = [fileManager subpathsAtPath:path];
        for (NSString * fileName in childerFiles) {
            if ([fileName hasSuffix:@".mp4"] || [fileName hasSuffix:@".sqlite"]) {
                //NSLog(@"不计算");
            }else
            {
                NSString * absolutePath = [path stringByAppendingPathComponent:fileName];
                folderSize += [self filePathSize:absolutePath];
            }
        }[self showCacheFileSizeToDelete:folderSize];
        return folderSize;
    }return 0;
    
}

- (CGFloat)filePathSize:(NSString *)path
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        long long size = [fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return  size / 1024.0 / 1024.0;
        
    }
    
    return 0;
}

- (void)showCacheFileSizeToDelete:(CGFloat)fileSize
{
    if (fileSize < 0.01) {
        
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你的手机很干净, 不需要清理" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show ];
        [alertView release];

        
        return;
    }
    NSString * string = [NSString stringWithFormat:@"缓存大小为:%.2fM,是否删除",fileSize];
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:string delegate:self cancelButtonTitle:@"删除" otherButtonTitles:@"取消", nil];
    [alertView show ];
    [alertView release];
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self clearCache:[self getPath]];
    }
}



- (NSString *)getPath
{

    NSString * path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
   // NSLog(@"%@", path);
    return path;
    
}

- (void)clearCache:(NSString *)path
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles = [fileManager subpathsAtPath:path];
        for (NSString * fileName in childerFiles) {
            //如有需要,加入条件,过滤不想删除的文件
            if ([fileName hasSuffix:@".mp4"] || [fileName hasSuffix:@".sqlite"]) {
                //NSLog(@"不删除");
            }else{
                NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
                [fileManager removeItemAtPath:absolutePath error:nil];
            }
        }
        
    }
}

#pragma mark - 下拉刷新和上拉加载更多

- (void)addRefresh
{
    [self.homeView.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    [self.homeView.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
- (void)loadNewData
{
    self.isDownRefresh = YES;
    [self loadDataWith:1];
    
}
- (void)loadMoreData
{
    self.isDownRefresh = NO;
    [self loadDataWith:++self.page];
    
}





#pragma mark - 集合视图数
- (void)setTitlesAndImages
{
    NSArray *titles = @[@"省钱控", @"值得买", @"网友推荐", @"商场导航"];
    NSArray *images = @[@"00", @"01", @"02", @"03"];
    self.myArray = [NSMutableArray arrayWithCapacity:1];
    for (int i = 0; i < 4; i++) {
        HomeModel *homeModel = [[HomeModel alloc] init];
        homeModel.image = images[i];
        homeModel.labelText = titles[i];
        [self.myArray addObject:homeModel];
        [homeModel release];
    }
}



#pragma mark - 懒加载


- (NSMutableArray *)collectionArray
{
    if (!_collectionArray) {
        self.collectionArray = [@[] mutableCopy];
    }
    
    return _collectionArray;
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        self.dataArray = [@[] mutableCopy];
    }
    return _dataArray;
}
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
        self.helper.delegate = self;
    }
    
    return _helper;
}

- (NSMutableArray *)images
{
    if (!_images) {
        self.images = [@[] mutableCopy];
    }
    
    return _images;
}

- (NSMutableArray *)myArray
{
    if (!_myArray) {
        self.myArray = [@[] mutableCopy];
    }
    return _myArray;
}


#pragma mark - 下载数据
- (void)loadDataWith:(int)page
{
    self.urlArray = [@[] mutableCopy];
    
    NSString *urlString = [NSString stringWithFormat:@"http://apapia.manmanbuy.com/index_json.ashx?jsoncallback=?&methodName=getcuxiaolist&page=%d", page];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    __block HomeViewController *blockSelf = self;
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.homeView.tableView.header endRefreshing];
        [self.homeView.tableView.footer endRefreshing];
        if (self.isDownRefresh) {
            [self.dataSourceArray removeAllObjects];
        }
        for (NSDictionary *dic in responseObject) {
            OnSaleCommodity *commodity = [[OnSaleCommodity alloc] initWithDictionary:dic];
            [blockSelf.dataSourceArray addObject:commodity];
            
            [commodity release];
        }
        [self.homeView.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    
}




- (void)downloadData
{
    [self.helper downloadDataWithUrlString:@"http://api.liwushuo.com/v1/banners?channel=iOS"];
}

#pragma mark - NetworkHelperDelegate
- (void)networkDataIsSuccessful:(id)obj
{
    
    id dataObj = [NSJSONSerialization JSONObjectWithData:obj options:NSJSONReadingMutableContainers error:nil];
    NSArray *array = dataObj[@"data"][@"banners"];
    for (NSDictionary *dic in array) {
        
        ScrollViewModel *model = [ScrollViewModel new];
        
        model.ID = dic[@"target_id"];
        
        [model setValuesForKeysWithDictionary:dic[@"target"]];
        model.cover_image_url = dic[@"image_url"];
        [self.dataArray addObject:model];
        
        [self.images addObject:model.cover_image_url];
        [model release];
    }
    
    [self addScrollViews];
    [self.homeView.tableView reloadData];
}


- (void)networkDataIsFail:(NSError *)error
{
    //UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"网络连接错误" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //[alertView show];
    //[alertView release];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [self.helper connectionCancel];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *cellIdentifier = @"cell";
    CommodityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    if (!cell) {
//        cell = [[CommodityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//    }
    cell.commodity = self.dataSourceArray[indexPath.row];
    
    if ([self containsObject:cell.commodity]) {
        [cell.collectionButton setImage:[UIImage imageNamed:@"rr"] forState:UIControlStateNormal];
        cell.commodity.isCollection = YES;
    }
    else
    {
        [cell.collectionButton setImage:[UIImage imageNamed:@"tt"] forState:UIControlStateNormal];
        cell.commodity.isCollection = NO;
    }
    [cell.collectionButton addTarget:self action:@selector(handelCollection:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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
    NSIndexPath *indexPath = [self.homeView.tableView indexPathForCell:(CommodityCell *)obj];
    
    
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





#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    HomeDetailViewController *homeDetailVC = [HomeDetailViewController new];
    homeDetailVC.ID = [self.dataSourceArray[indexPath.row] ID];
    [self.navigationController pushViewController:homeDetailVC animated:YES];
    homeDetailVC.tabBarController.tabBar.hidden = YES;
    
    [self.view.window showHUDWithText:@"加载中" Type:ShowLoading Enabled:YES];
    
}



#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.myArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PageControllCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"qwe" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.model = self.myArray[indexPath.row];
    
    return cell;
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            SaveMoneyViewController *saveMoneyVC = [SaveMoneyViewController new];
            [self.navigationController pushViewController:saveMoneyVC animated:YES];
            saveMoneyVC.tabBarController.tabBar.hidden = YES;
            [self.view.window showHUDWithText:@"加载中" Type:ShowLoading Enabled:YES];

            [saveMoneyVC release];
        }
            break;
        case 1:
        {
            CabbagePriceViewController *cabbageVC = [CabbagePriceViewController new];
            [self.navigationController pushViewController:cabbageVC animated:YES];
            cabbageVC.tabBarController.tabBar.hidden = YES;
            [self.view.window showHUDWithText:@"加载中" Type:ShowLoading Enabled:YES];

            [cabbageVC release];
        }
            break;
        case 2:
        {
            RecommendViewController *recommendVC = [RecommendViewController new];
            [self.navigationController pushViewController:recommendVC animated:YES];
            recommendVC.tabBarController.tabBar.hidden = YES;
            [self.view.window showHUDWithText:@"加载中" Type:ShowLoading Enabled:YES];
            [recommendVC release];
        }
            break;
        case 3:
        {
            MallNavigationViewController *mallVC = [MallNavigationViewController new];
            [self.navigationController pushViewController:mallVC animated:YES];
            
            mallVC.tabBarController.tabBar.hidden = YES;
            [mallVC release];
        }
            break;
        default:
            break;
    }
}

#pragma mark - 懒加载设置代理和数据源
- (HomeView *)homeView
{
    if (!_homeView) {
        self.homeView = [[[HomeView alloc] initWithFrame:[UIScreen mainScreen].bounds] autorelease];
        _homeView.tableView.delegate = self;
        _homeView.tableView.dataSource = self;
        _homeView.collectionView.delegate = self;
        _homeView.collectionView.dataSource = self;
    }
    return _homeView;
}

- (void)loadView
{
    [super loadView];
    self.view = self.homeView;
    
}



#pragma  mark - 轮播图页面相关

- (void)addScrollViews
{
    SDCycleScrollView *scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 135) imageURLStringsGroup:self.images];
    scrollView.delegate = self;
    scrollView.autoScrollTimeInterval = 2;
    scrollView.placeholderImage = [UIImage imageNamed:@"placeholder"];
    [self.homeView.tableView.tableHeaderView addSubview:scrollView];
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    GiftViewController *giftVC = [GiftViewController new];
    giftVC.ID = [self.dataArray[index] ID];
    [self.navigationController pushViewController:giftVC animated:YES];
    giftVC.tabBarController.tabBar.hidden = YES;
    [giftVC release];
    [self.view.window showHUDWithText:@"加载中" Type:ShowLoading Enabled:YES];
    
}

#pragma  mark - dealloc

- (void)dealloc
{
    self.urlArray = nil;
    self.link = nil;
    self.collectionArray = nil;
    self.images = nil;
    self.dataArray = nil;
    self.myArray = nil;
    self.helper = nil;
    self.dataSourceArray = nil;
    self.timer = nil;
    self.homeView = nil;
    [super dealloc];
}


@end
