//
//  SearchListViewController.m
//  Class2509
//
//  Created by laouhn on 15/7/13.
//  Copyright (c) 2015年 张祥. All rights reserved.
//


#import "SearchListViewController.h"
#import "SearchListView.h"
#import "SearchListHeaderView.h"
#import "SearchListSingle.h"
#import "SearchListCell.h"
#import "ShaiXuanViewController.h"
#import "PopoverView.h"
#import "ProductDetailViewController.h"
#import "SearchViewController.h"
#import "NetworkHelper.h"
#import "UIWindow+YzdHUD.h"
#import "NoProductView.h"
#import "MJRefresh.h"
#import "UIWindow+YzdHUD.h"

@interface SearchListViewController ()<UITableViewDataSource,UITableViewDelegate, NetworkHelperDelegate>

@property (nonatomic, retain)SearchListView *listView;
@property (nonatomic, retain)SearchListHeaderView *headerView;
@property (nonatomic, retain)NSMutableArray *dataAry;
@property (nonatomic, copy) NSString *order;
@property (nonatomic, retain) NSMutableArray *refreshAry;
@property (nonatomic, assign) BOOL isDownRefresh;
@property (nonatomic, assign) int page;
@property (nonatomic, retain) UIToolbar *bar;
@property (nonatomic, assign) double lastContentOffset;
@property (nonatomic, retain) NoProductView *noResultView;

@end

@implementation SearchListViewController

- (void)dealloc
{
    self.listId = nil;
    self.listTitle = nil;
    self.listView = nil;
    self.headerView = nil;
    self.dataAry = nil;
    self.order = nil;
    self.refreshAry = nil;
    [super dealloc];
}


- (void)loadView
{
    self.listView = [[[SearchListView alloc] initWithFrame:[UIScreen mainScreen].bounds] autorelease];
    self.view = self.listView;
    
}


- (void)viewWillAppear:(BOOL)animated
{
    //当返回的时候取消cell的选中状态
    [self.listView.seachTableView deselectRowAtIndexPath:[self.listView.seachTableView indexPathForSelectedRow] animated:YES];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.listTitle;
    
    self.tabBarController.tabBar.hidden = YES;
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"筛选"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(shaiXuanPage:)] autorelease];

    for (UIView *view in self.navigationController.view.subviews)
    {
        if ([view isKindOfClass:[UISearchBar class]])
        {
            UISearchBar *searchBar = (UISearchBar *)view;
            
            [searchBar removeFromSuperview];
        }
    }
    
    self.headerView = [[[SearchListHeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)] autorelease];
    self.listView.seachTableView.tableHeaderView = self.headerView;
    self.listView.seachTableView.delegate = self;
    self.listView.seachTableView.dataSource = self;
    
    [self.headerView.allBut addTarget:self
                               action:@selector(getString:)
                     forControlEvents:UIControlEventTouchUpInside];
    [self.headerView.priceBut addTarget:self
                                 action:@selector(touchChangePrice:)
                       forControlEvents:UIControlEventTouchUpInside];
    [self.headerView.scoreBut addTarget:self
                                 action:@selector(getString:)
                       forControlEvents:UIControlEventTouchUpInside];
    
    
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(returnLastPage)] autorelease];
    
    self.page = 1;
    
    [self.refreshAry removeAllObjects];
    for (int i = 0; i < 3; i++)
    {
        [self.refreshAry addObject:@"0"];
    }

    self.order = @"MR";
    [self getDataFromServer:1 ppid:@"0" pricr1:@"0" price2:@"0"];
    [self.listView.seachTableView reloadData];
    
    [self addRefreshEffect];

    
}

#pragma mark - 悬浮按钮

- (void)addSuspendButton
{
    
    
    if (!self.bar) {
        self.bar = [[UIToolbar alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 40, [UIScreen mainScreen].bounds.size.height - 40, 30, 30)];
        [self.view addSubview:self.bar];
        [self.bar release];
        self.bar.backgroundColor = [UIColor blackColor];
        
        //圆角效果, 这个必须打开, 不然无法修改
        self.bar.layer.masksToBounds = YES;
        
        //按钮宽的一半
        self.bar.layer.cornerRadius = 15;
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToTop)];
        [self.bar addGestureRecognizer:tap];
        [tap release];
        self.bar.alpha = 0.5;
        [self.bar setBackgroundImage:[UIImage imageNamed:@"muying_to_top_btn"] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
   
}





- (void)backToTop
{
    
    
    //加一个动画, 不然效果太突兀了
    [UIView animateWithDuration:.3
                          delay:0
                        options:UIViewAnimationOptionTransitionFlipFromLeft
                     animations:^{
                         self.listView.seachTableView.contentOffset = CGPointMake(0, -64);
                         
                     } completion:^(BOOL finished) {
                         
                         [self.bar removeFromSuperview];
                         self.bar = nil;
                     }];
    
    
}

#pragma mark - UIScrollViewDelegate
/*
 @interface UITableView : UIScrollView
 因为tabView继承于scrollView, 所以当给tabView指定代理的时候也就是给scrollView指定了代理
 
 遵守协议, 然后直接用代理方法就好
 */

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.lastContentOffset = scrollView.contentOffset.y;
    
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //NSLog(@"%.f", scrollView.contentOffset.y);
    if (self.lastContentOffset < scrollView.contentOffset.y) {//向下减速
        
        [self addSuspendButton];
        
    }else if (scrollView.contentOffset.y == - 64){//当滑到屏幕顶部的时候
        
        
        
        [self.bar removeFromSuperview];
        self.bar = nil;
    }
    
}



#pragma mark - 上拉加载, 下拉刷新
- (void)addRefreshEffect
{
    [self.listView.seachTableView addLegendHeaderWithRefreshingBlock:^{
        self.isDownRefresh = YES;
        [self getDataFromServer:1 ppid:self.refreshAry[0] pricr1:self.refreshAry[1] price2:self.refreshAry[2]];
        [self.listView.seachTableView reloadData];

        [self.listView.seachTableView.header endRefreshing];
    }];
    
    
    
    
    
    [self.listView.seachTableView addLegendFooterWithRefreshingBlock:^{
        
        self.isDownRefresh = NO;
        
        [self getDataFromServer:++self.page ppid:self.refreshAry[0] pricr1:self.refreshAry[1] price2:self.refreshAry[2]];
        [self.listView.seachTableView reloadData];

        [self.listView.seachTableView.footer endRefreshing];
    }];
    
}





- (void)returnLastPage
{
    
    NSArray *ary =  self.navigationController.viewControllers;
    
    [(SearchViewController *)ary[0] addSearchbar];
    
    
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
    [self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden = NO;
    
}










#pragma mark - Button点击事件方法
- (void)getString:(UIButton *)sender
{
    switch (sender.tag) {
        case 100:
            
        {
            self.order = @"MR";
            sender.backgroundColor = [UIColor orangeColor];
            self.headerView.priceBut.backgroundColor = [UIColor whiteColor];
            self.headerView.scoreBut.backgroundColor = [UIColor whiteColor];
            
            
            break;
            
        }

        case 101:
        {
            self.order = @"ca";
            sender.backgroundColor = [UIColor orangeColor];
            self.headerView.priceBut.backgroundColor = [UIColor whiteColor];
            self.headerView.allBut.backgroundColor = [UIColor whiteColor];
            break;
            

        }
            
        default:
            break;
    }
    
   
    [self.dataAry removeAllObjects];

    
    [self getDataFromServer:1 ppid:self.refreshAry[0] pricr1:self.refreshAry[1] price2:self.refreshAry[2]];
    [self.listView.seachTableView reloadData];
}

- (void)touchChangePrice:(UIButton *)sender
{
    
    
    sender.backgroundColor = [UIColor orangeColor];
    self.headerView.allBut.backgroundColor = [UIColor whiteColor];
    self.headerView.scoreBut.backgroundColor = [UIColor whiteColor];
    
    
    
    CGPoint point = CGPointMake(sender.frame.origin.x + sender.frame.size.width / 2, sender.frame.origin.y + sender.frame.size.height + 64);
    NSArray *titles = @[@"升序", @"降序"];
    PopoverView *pop = [[[PopoverView alloc] initWithPoint:point titles:titles images:nil] autorelease];
    pop.selectRowAtIndex = ^(NSInteger index){
        switch (index) {
            case 0:
                self.order = @"price";
                break;
            case 1:
                self.order = @"price2";
                break;
                
            default:
                break;
        }
        
        
        [self.dataAry removeAllObjects];

        [self getDataFromServer:1 ppid:self.refreshAry[0] pricr1:self.refreshAry[1] price2:self.refreshAry[2]];
        [self.listView.seachTableView reloadData];

    };
    [pop show];
}


- (NSMutableArray *)refreshAry
{
    if (!_refreshAry) {
        self.refreshAry = [NSMutableArray arrayWithCapacity:1];
    }
    return _refreshAry;
}



#pragma mark - 获取数据解析
- (void)getDataFromServer:(int)page ppid:(NSString *)ppid pricr1:(NSString *)price1 price2:(NSString *)price2
{
    
    NSString *urlString = [NSString stringWithFormat:@"http://apapia.manmanbuy.com/index_json.ashx?jsoncallback=?&methodName=getProlist&page=%d&smallid=%@&orderby=%@&price1=%@&price2=%@&ppid=%@", page, self.listId, self.order, price1, price2, ppid];
    
    
    NetworkHelper *help = [[[NetworkHelper alloc] init] autorelease];
    help.delegate = self;
    
    [help getDataWithUrlString:urlString];
    

   }

//当数据成功获取后使用此方法回调
- (void)networkDataIsSuccessful:(NSData *)data
{
    
    
    if (self.isDownRefresh) {
        [self.dataAry removeAllObjects];
    }
    NSString *dataStr = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    
    NSArray *array = [dataStr componentsSeparatedByString:@"shaixuan"];
    NSString *str1 = array[0];
    NSData *data1 = [str1 dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *array1 = [NSJSONSerialization JSONObjectWithData:data1
                                                      options:NSJSONReadingMutableContainers
                                                        error:nil];
    for (NSDictionary *dic in array1) {
        SearchListSingle *listSingle = [[SearchListSingle alloc] initWithSearchListSingleDic:dic];
        [self.dataAry addObject:listSingle];
        [listSingle release];
    }
    
    if (self.dataAry.count == 0) {
        [self addNoProductView];
    }
    [self.listView.seachTableView reloadData];
    
}


- (void)addNoProductView
{
    
    self.noResultView = [[NoProductView alloc] initWithFrame:self.view.bounds];
    
    self.noResultView.center = self.view.center;
    self.noResultView.nameTitle = @"该分类下还没有相关产品信息";
    
    [self.view addSubview:self.noResultView];
    [self.noResultView release];
    
}







//当数据获取失败后使用此方法回调
- (void)networkDataIsFail:(NSError *)error
{
    
    
    
    
    
}











#pragma mark - cell代理方法实现


//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//    
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    
//    return 50;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataAry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strCell = @"cell";
    SearchListCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    if (cell == nil) {
        cell = [[SearchListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
    }
    cell.searchSingle = self.dataAry[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

#pragma mark - UIBarButtonItem筛选页面跳转
- (void)shaiXuanPage:(UIBarButtonItem *)sender
{
    
    
    
    
    ShaiXuanViewController *shaiXuanVC = [[ShaiXuanViewController alloc] init];
    
    UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:shaiXuanVC];
    
    [shaiXuanVC release];
    
    naVC.navigationBar.barTintColor = [UIColor orangeColor];
    

    shaiXuanVC.value = ^(NSString *brend, NSString *price1, NSString *price2){
        
        
        
        self.order = @"MR";
        
        [self.refreshAry removeAllObjects];
        [self.refreshAry addObject:brend];
        [self.refreshAry addObject:price1];
        [self.refreshAry addObject:price2];
       
        [self.dataAry removeAllObjects];
        [self getDataFromServer:1 ppid:brend pricr1:price1 price2:price2];
        
        [self.listView.seachTableView reloadData];

    };
    
    
    [self presentViewController:naVC animated:YES completion:nil];
    
    
    
    self.presentingViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    self.presentedViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    

    [naVC release];
    
    
    
    shaiXuanVC.shaiXuanId = self.listId;
}
#pragma mark - 跳转到商品详情页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductDetailViewController *productDetailVC = [[ProductDetailViewController alloc] init];
    
    
    productDetailVC.produceID = [self.dataAry[indexPath.row] proID];
    
    
    [self.navigationController pushViewController:productDetailVC animated:YES];
    [self.view.window showHUDWithText:@"加载中" Type:ShowLoading Enabled:YES];
    
    [productDetailVC release];
}



- (NSMutableArray *)dataAry
{
    if (_dataAry == nil) {
        self.dataAry = [NSMutableArray array];
    }
    return [[_dataAry retain] autorelease];
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
