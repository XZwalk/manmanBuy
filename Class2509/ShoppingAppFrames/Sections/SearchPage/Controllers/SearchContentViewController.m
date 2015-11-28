//
//  SearchContentViewController.m
//  Class2509
//
//  Created by 张祥 on 15/7/10.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "SearchContentViewController.h"
#import "UserSearchListCell.h"
#import "UserSearchLIst.h"
#import "MJRefresh.h"
#import "PopoverView.h"
#import "HeaderCell.h"
#import "ChooseCat.h"
#import "ChooseBrend.h"
#import "ChooseMall.h"
#import "ChooseListViewController.h"
#import "UIWindow+YzdHUD.h"
#import "NetworkHelper.h"
#import "BuyProductViewController.h"
#import "SearchViewController.h"
#import "NoProductView.h"

#define kSPACE ([UIScreen mainScreen].bounds.size.width - 240) / 4





@interface SearchContentViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, NetworkHelperDelegate>

@property (nonatomic, retain) NSMutableArray *dataAry;
@property (nonatomic, retain) UITableView *tabView;
@property (nonatomic, retain) NSMutableArray *listAry;
@property (nonatomic, assign) int page;
@property (nonatomic, assign) BOOL isDownRefresh;
@property (nonatomic, assign) CGFloat lastContentOffset;
@property (nonatomic, retain) UIToolbar *bar;
@property (nonatomic, retain) UICollectionView *headerView;
@property (nonatomic, retain) NSMutableArray *catAry;
@property (nonatomic, retain) NSMutableArray *mallAry;
@property (nonatomic, retain) NSMutableArray *brendAry;
@property (nonatomic, retain) NSMutableArray *touchAry;
@property (nonatomic, retain) NSMutableArray *refreshAry;
@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) NoProductView *noResultView;

@end

@implementation SearchContentViewController

- (void)dealloc
{
    self.searchBar.delegate = nil;
    self.searchName = nil;
    self.searchBar = nil;
    self.refreshAry = nil;
    self.touchAry = nil;
    self.brendAry = nil;
    self.mallAry = nil;
    self.catAry = nil;
    self.headerView = nil;
    self.bar = nil;
    self.listAry = nil;
    self.tabView = nil;
    self.dataAry = nil;
    [super dealloc];

}


- (void)viewWillAppear:(BOOL)animated
{
    
    //当返回的时候取消cell的选中状态
    [self.tabView deselectRowAtIndexPath:[self.tabView indexPathForSelectedRow] animated:YES];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //NSLog(@"%@", NSStringFromCGRect(self.tabBarController.tabBar.frame));
    
    self.tabBarController.tabBar.hidden = YES;
    
    
    self.tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    
    [self.view addSubview:self.tabView];
    [self.tabView release];
    
    self.tabView.dataSource = self;
    self.tabView.delegate = self;
    
    
    self.tabView.scrollsToTop = NO;
    
    [self addRefreshEffect];
    
    for (UIView *view in self.navigationController.view.subviews)
    {
        if ([view isKindOfClass:[UISearchBar class]])
        {
            self.searchBar = (UISearchBar *)view;

            self.searchBar.frame = CGRectMake(40,
                                         20,
                                         [UIScreen mainScreen].bounds.size.width - 80,
                                         40);
            self.searchBar.text = self.searchName;
            self.searchBar.delegate = self;
            
            
        }
    }
    
    
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(returnLastPage)] autorelease];
    
    
    self.page = 1;
    
    [self.refreshAry removeAllObjects];
    [self.refreshAry addObject:@"1"];
    [self.refreshAry addObject:@"MR"];
    for (int i = 0; i < 5; i++)
    {
        [self.refreshAry addObject:@"0"];
    }
    
    
    [self getSearchListFromServer:1 order:@"MR" smallclass:@"0" ppid:@"0" siteid:@"0" price1:@"0" price2:@"0"];
    
    [self.tabView reloadData];
    
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(chooseList)] autorelease];
    
}


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(touchCancel)] autorelease];
    
    return YES;
    
}



- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
{
    
    if ([searchBar canResignFirstResponder]) {
        [searchBar resignFirstResponder];
    }
    
    
    [self.listAry removeAllObjects];
    
    self.searchName = searchBar.text;
    
    [self.refreshAry removeAllObjects];
    [self.refreshAry addObject:@"1"];
    [self.refreshAry addObject:@"MR"];
    for (int i = 0; i < 5; i++)
    {
        [self.refreshAry addObject:@"0"];
    }
    
    
    [self getSearchListFromServer:1 order:@"MR" smallclass:@"0" ppid:@"0" siteid:@"0" price1:@"0" price2:@"0"];
    
    [self.tabView reloadData];
    

    
    
}




- (void)touchCancel
{
    
    for (UIView *view in self.navigationController.view.subviews)
    {
        if ([view isKindOfClass:[UISearchBar class]])
        {
            UISearchBar *searchBar = (UISearchBar *)view;
            
           
            //收回键盘
            [searchBar resignFirstResponder];
            
            
            searchBar.text = self.searchName;
            
            
        }
    }


    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(chooseList)] autorelease];
   
    
}





- (void)chooseList
{
    
    
    ChooseListViewController *listVC = [[ChooseListViewController alloc] init];
    UINavigationController *naVC= [[UINavigationController alloc] initWithRootViewController:listVC];

    
    listVC.dic = @{@"brend" : self.brendAry, @"cat" : self.catAry, @"mall" : self.mallAry};
    
    naVC.navigationBar.barTintColor = [UIColor orangeColor];
    
    
    
    listVC.value = ^(NSString *smallclass, NSString *ppid, NSString *siteid, NSString *price1, NSString *price2){
        
        [self.refreshAry removeAllObjects];
        [self.listAry removeAllObjects];
        [self.refreshAry removeAllObjects];
        [self.refreshAry addObject:@"1"];
        [self.refreshAry addObject:@"MR"];
        [self.refreshAry addObject:smallclass];
        [self.refreshAry addObject:ppid];
        [self.refreshAry addObject:siteid];
        [self.refreshAry addObject:price1];
        [self.refreshAry addObject:price2];
        
        [self getSearchListFromServer:1 order:@"MR" smallclass:smallclass ppid:ppid siteid:siteid price1:price1 price2:price2];
        
        [self.tabView reloadData];
        
    };
    
    
    
    [self presentViewController:naVC animated:YES completion:nil];
    
    
    //当前的特效药放在推出去的代码的前面      下一个视图的特效药放在推出去的代码之后, 不然没有作用
    self.presentingViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    self.presentedViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [listVC release];
    [naVC release];
    
}


#pragma mark - 下拉刷新, 上拉加载

- (NSMutableArray *)refreshAry
{
    if (!_refreshAry) {
        self.refreshAry = [NSMutableArray arrayWithCapacity:1];
        
          }
    return _refreshAry;
}



- (void)addRefreshEffect
{

    //下拉刷新
    [self.tabView addLegendHeaderWithRefreshingBlock:^{
        
        self.isDownRefresh = YES;
        
         [self getSearchListFromServer:1 order:self.refreshAry[1] smallclass:self.refreshAry[2] ppid:self.refreshAry[3] siteid:self.refreshAry[4] price1:self.refreshAry[5] price2:self.refreshAry[6]];
        
        [self.tabView.header endRefreshing];
        
    }];
    

    [self.tabView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    //上拉加载
//    [self.tabView addLegendFooterWithRefreshingBlock:^{
//        
//        self.isDownRefresh = NO;
//        
//        
//
//
//        
//        //注意++self.page和self.page++的区别
//         [self getSearchListFromServer:++self.page order:self.refreshAry[1] smallclass:self.refreshAry[2] ppid:self.refreshAry[3] siteid:self.refreshAry[4] price1:self.refreshAry[5] price2:self.refreshAry[6]];
//        
//        [self.tabView.footer endRefreshing];
//        
//    }];
//    
    //[self.tabView.footer beginRefreshing];
    
}

- (void)footerRefresh
{
    
    self.isDownRefresh = NO;
    
    //注意++self.page和self.page++的区别
    [self getSearchListFromServer:++self.page order:self.refreshAry[1] smallclass:self.refreshAry[2] ppid:self.refreshAry[3] siteid:self.refreshAry[4] price1:self.refreshAry[5] price2:self.refreshAry[6]];
    
    [self.tabView.footer endRefreshing];

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
                         self.tabView.contentOffset = CGPointMake(0, -64);
                         
                     } completion:^(BOOL finished) {
                         
                         [self.bar removeFromSuperview];
                         self.bar  = nil;

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


#pragma mark - UITableViewDataSource



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.listAry.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"cell";
    
    UserSearchListCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UserSearchListCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:str];
    }
    
    cell.userSearch = self.listAry[indexPath.row];
    
    
    return cell;
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 135;
    
}






- (NSMutableArray *)listAry
{
    if (!_listAry) {
        
        self.listAry = [NSMutableArray arrayWithCapacity:1];
        
    }
    return _listAry;
}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}

#pragma mark - 选中跳转

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = [self.listAry[indexPath.row] gourl];
    
    NSArray *ary = [str componentsSeparatedByString:@"&tourl="];
    
    BuyProductViewController *buy = [[BuyProductViewController alloc] init];
    
    buy.link = ary[1];
    buy.title = [self.listAry[indexPath.row] titleName];
    buy.imageUrl = [self.listAry[indexPath.row] imageUrl];
    
    NSArray *ary1 =  self.navigationController.viewControllers;
    
    [(SearchViewController *)ary1[0] removeSearchbar];
    
    [self.navigationController pushViewController:buy animated:YES];
    [self.view.window showHUDWithText:@"加载中" Type:ShowLoading Enabled:YES];
    [buy release];

}


#pragma mark - 区头视图

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    [self addHeaderView];
    
    self.headerView.backgroundColor = [UIColor whiteColor];
    
    return self.headerView;
    
    
    
}


- (void)addHeaderView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(80, 30);
    //NSLog(@"%.f", ([UIScreen mainScreen].bounds.size.width - 240) / 4);
    layout.minimumInteritemSpacing = kSPACE;
    layout.sectionInset = UIEdgeInsetsMake(10, kSPACE, 5, kSPACE);
    self.headerView = [[[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout] autorelease];
    [layout release];
    
    self.headerView.delegate = self;
    self.headerView.dataSource = self;
    
    [self.headerView  registerClass:[HeaderCell class] forCellWithReuseIdentifier:@"item"];
    
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    if ([self.touchAry containsObject:indexPath]) {
        cell.backgroundColor = [UIColor orangeColor];
    }
    

    
    
    [cell.layer setMasksToBounds:YES];
    cell.layer.cornerRadius = 10;//高度的一半
    
    
    NSArray *ary = @[@"综合", @"价格", @"销量"];
    cell.label.text = ary[indexPath.row];
    
    return cell;
    
}

- (NSMutableArray *)touchAry
{
    if (!_touchAry) {
        self.touchAry = [NSMutableArray arrayWithCapacity:1];
        
    }
    return _touchAry;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.touchAry removeAllObjects];
    
    [self.touchAry addObject:indexPath];
    
    if (indexPath.row == 1) {
        
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        
        [self changePrice:cell];
    }
    
    
    
    if (indexPath.row == 0) {
        [self.listAry removeAllObjects];
        
        [self.refreshAry removeObjectAtIndex:0];
        [self.refreshAry insertObject:@"1" atIndex:0];
        [self.refreshAry removeObjectAtIndex:1];
        [self.refreshAry insertObject:@"MR" atIndex:1];
  

        [self getSearchListFromServer:1 order:self.refreshAry[1] smallclass:self.refreshAry[2] ppid:self.refreshAry[3] siteid:self.refreshAry[4] price1:self.refreshAry[5] price2:self.refreshAry[6]];

        
    }else if (indexPath.row == 2) {
        [self.listAry removeAllObjects];

        
        [self.refreshAry removeObjectAtIndex:0];
        [self.refreshAry insertObject:@"1" atIndex:0];
        [self.refreshAry removeObjectAtIndex:1];
        [self.refreshAry insertObject:@"sell" atIndex:1];
        
        
        [self getSearchListFromServer:1 order:self.refreshAry[1] smallclass:self.refreshAry[2] ppid:self.refreshAry[3] siteid:self.refreshAry[4] price1:self.refreshAry[5] price2:self.refreshAry[6]];
    }
    
    [self.tabView reloadData];
}


- (void)changePrice:(UICollectionViewCell *)sender
{
    
    CGPoint point = CGPointMake(sender.frame.origin.x + sender.frame.size.width/2, sender.frame.origin.y + sender.frame.size.height + 64);
    NSArray *titles = @[@"从低到高", @"从高到低"];
    PopoverView *pop = [[[PopoverView alloc] initWithPoint:point titles:titles images:nil] autorelease];
    
    pop.selectRowAtIndex = ^(NSInteger index){
        
        if (index == 0) {
            [self.listAry removeAllObjects];
            
            [self.refreshAry removeObjectAtIndex:0];
            [self.refreshAry insertObject:@"1" atIndex:0];
            [self.refreshAry removeObjectAtIndex:1];
            [self.refreshAry insertObject:@"price" atIndex:1];
          
            [self getSearchListFromServer:1 order:@"price" smallclass:self.refreshAry[2] ppid:self.refreshAry[3] siteid:self.refreshAry[4] price1:self.refreshAry[5] price2:self.refreshAry[6]];
            
        }else{
            [self.listAry removeAllObjects];
            
            [self.refreshAry removeObjectAtIndex:0];
            [self.refreshAry insertObject:@"1" atIndex:0];
            [self.refreshAry removeObjectAtIndex:1];
            [self.refreshAry insertObject:@"price2" atIndex:1];
            
            
            [self getSearchListFromServer:1 order:self.refreshAry[1] smallclass:self.refreshAry[2] ppid:self.refreshAry[3] siteid:self.refreshAry[4] price1:self.refreshAry[5] price2:self.refreshAry[6]];

        }
        
        [self.tabView reloadData];
        
        //NSLog(@"select index:%ld", index);
    };
    [pop show];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}




#pragma mark - 数据解析

- (NSMutableArray *)catAry
{
    if (!_catAry) {
        self.catAry  = [NSMutableArray arrayWithCapacity:1];
    }
    return _catAry;
}


- (NSMutableArray *)brendAry
{
    if (!_brendAry) {
        self.brendAry = [NSMutableArray arrayWithCapacity:1];
        
    }
    return _brendAry;
    
}




- (NSMutableArray *)mallAry
{
    if (!_mallAry) {
        self.mallAry = [NSMutableArray arrayWithCapacity:1];
    }
    return _mallAry;
}





- (void)getSearchListFromServer:(int)page order:(NSString *)order smallclass:(NSString *)smallclass ppid:(NSString *)ppid siteid:(NSString *)siteid price1:(NSString *)price1 price2:(NSString *)price2
{
//    if (self.listAry.count == 0) {
//        self.tabView.footer.hidden = YES;
//        
//    }else
//    {
//        self.tabView.footer.hidden = NO;
//
//        
//    }
    


    NSString *urlEncodeStr = [self.searchName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *urlString = [NSString stringWithFormat:@"http://apapia.manmanbuy.com/index_json.ashx?jsoncallback=?&methodName=getsearchkeylist&page=%d&key=%@&orderby=%@&smallclass=%@&price1=%@&price2=%@&ppid=%@&siteid=%@", page, urlEncodeStr, order, smallclass, price1, price2, ppid, siteid];
    
    NetworkHelper *helper = [[[NetworkHelper alloc] init] autorelease];
    
    helper.delegate = self;
    
    [helper getDataWithUrlString:urlString];
    
    
    
}


//当数据成功获取后使用此方法回调
- (void)networkDataIsSuccessful:(NSData *)data
{
    
    if (data) {
        NSString *dataStr = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
        NSArray *array = [dataStr componentsSeparatedByString:@"shaixuan"];
        NSString *str1 = array[0];
        NSData *data1 = [str1 dataUsingEncoding:NSUTF8StringEncoding];
        
        NSArray *array1 = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingMutableContainers error:nil];
        //如果是下拉刷新则先清除之前的数据
        if (self.isDownRefresh) {
            [self.listAry removeAllObjects];
        }
        
        for (NSDictionary *dic in array1) {
            
            UserSearchLIst *list = [[[UserSearchLIst alloc] initWithDic:dic] autorelease];
            
            [self.listAry addObject:list];
            
        }
        
        if (array.count > 1) {
            NSString *str2 = array[1];
            NSData *data2 = [str2 dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *array2 = [NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableContainers error:nil];
            
            NSArray *ary1 = [array2[0] objectForKey:@"cat"];
            NSArray *ary2 = [array2[0] objectForKey:@"brend"];
            NSArray *ary3 = [array2[0] objectForKey:@"mall"];
            
            for (NSDictionary *dic in ary1) {
                
                ChooseCat *cat = [[ChooseCat alloc] initWithDic:dic];
                
                [self.catAry addObject:cat];
                [cat release];
            }
            
            for (NSDictionary *dic in ary2) {
                ChooseBrend *brend = [[ChooseBrend alloc] initWithDic:dic];
                [self.brendAry addObject:brend];
                [brend release];
            }
            
            for (NSDictionary *dic in ary3) {
                ChooseMall *mall = [[ChooseMall alloc] initWithDic:dic];
                [self.mallAry addObject:mall];
                [mall release];
            }
            
            
        }
        
        
        if (self.listAry.count == 0) {
            [self addNoProductView];
        }
        
        
        [self.tabView reloadData];
        
    }
}


//当数据获取失败后使用此方法回调
- (void)networkDataIsFail:(NSError *)error

{
    
    
}








- (void)returnLastPage
{
    
    for (UIView *view in self.navigationController.view.subviews)
    {
        if ([view isKindOfClass:[UISearchBar class]])
        {
            UISearchBar *searchBar = (UISearchBar *)view;
            
            CGRect mainViewBounds = self.navigationController.view.bounds;

            searchBar.frame = CGRectMake(CGRectGetMinX(mainViewBounds),
                                         20,
                                         self.navigationController.view.bounds.size.width,
                                         40);
            
            
            //[searchBar setShowsCancelButton:NO animated:YES];
            
            [searchBar resignFirstResponder];
            NSArray *ary =  self.navigationController.viewControllers;
            searchBar.delegate = ary[0];
            
            searchBar.text = nil;
            
        }
    }
    

    self.tabBarController.tabBar.hidden = NO;
    
    
    NSArray *ary =  self.navigationController.viewControllers;
    
    
    self.searchBar.delegate = ary[0];
    
    
    
    
    //当页面消失的时候将指示信号取消
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}



- (void)addNoProductView
{
    
    self.noResultView = [[NoProductView alloc] initWithFrame:self.view.bounds];
    self.noResultView.nameTitle = @"没有搜索到相关产品";

    self.noResultView.center = self.view.center;
    
    [self.view addSubview:self.noResultView];
    [self.noResultView release];
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
