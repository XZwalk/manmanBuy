//
//  SearchViewController.m
//  ShoppingApp
//
//  Created by 张祥 on 15/7/8.
//  Copyright (c) 2015年 张祥. All rights reserved.
//



#import "SearchViewController.h"
#import "SearchCollectionView.h"
#import "SearchList.h"
#import "SearchDetail.h"
#import "AFNetworking.h"
#import "SearchHeadView.h"
#import "Record.h"
#import "DetailCollectionViewCell.h"
#import "SearchHotHeaderView.h"
#import "SearchHotFooterView.h"
#import "HotSearchViewCell.h"
#import "HotSearch.h"
#import "UIViewAdditions.h"
#import "SearchContentViewController.h"
#import "SearchListTableViewCell.h"
#import "SearchListViewController.h"
#import "SearchFooterView.h"
#import "UIWindow+YzdHUD.h"



#define  kWIDTH  [UIScreen mainScreen].bounds.size.width
#define  kHEIGHT [UIScreen mainScreen].bounds.size.height

@interface SearchViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, UITabBarControllerDelegate>

@property (nonatomic, retain) SearchCollectionView *searchView;
@property (nonatomic, retain) NSMutableArray *listAry;
@property (nonatomic, retain) NSMutableArray *detailAry;
@property (nonatomic, retain) NSMutableArray *hotSearchAry;
@property (nonatomic, retain) Record *record;
@property (nonatomic, retain) NSMutableArray *touchAry;
@property (nonatomic, retain) SearchHotFooterView *hotFooterView;
@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *searchHistory;
@property (nonatomic, retain) UIView *myView;
@property (nonatomic, retain) UIView *myView1;


@end

@implementation SearchViewController

- (void)dealloc
{
    self.searchView = nil;
    self.listAry = nil;
    self.detailAry = nil;
    self.searchBar.delegate = nil;//一定记得每个页面的代理置空
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    self.hotSearchAry = nil;
    self.hotFooterView = nil;
    self.record = nil;
    self.touchAry = nil;
    self.searchBar = nil;
    self.tableView = nil;
    self.searchHistory = nil;
    self.myView = nil;
    self.myView1 = nil;
    [super dealloc];

}




#pragma mark - loadView

/**
 *重置视图
 */
//- (void)loadView
//{
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSearchbar];
    [self getDetailDataFromServer];
    [self getHotDataFromServer];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.searchView = [[SearchCollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    [self.view addSubview:self.searchView];
    
    [layout release];
    [self.searchView release];
    
    NSString *dou = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    //NSLog(@"%@", dou);

   
    //这里的类别[class]一定不能写错
    // -[DetailCollectionViewCell setHot:]: unrecognized selector sent to instance 0x7fb16b6a3830
    [self.searchView registerClass:[DetailCollectionViewCell class] forCellWithReuseIdentifier:@"detail"];
    [self.searchView registerClass:[HotSearchViewCell class] forCellWithReuseIdentifier:@"hotSearch"];
    [self.searchView registerClass:[SearchHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.searchView registerClass:[SearchFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"footer"];
    
    
    [self.searchView registerClass:[SearchHotHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"hotHeader"];
    [self.searchView registerClass:[SearchHotFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"hotFooter"];
    
    //设置collectionView相关代理
    self.searchView.dataSource = self;
    self.searchView.delegate = self;

    
    //设置标签视图控制器的代理, 以便能监测点击标签的事件
    self.tabBarController.delegate = self;
}



#pragma mark - 加载搜索框


- (void)addSearchbar
{
  
    CGRect mainViewBounds = self.navigationController.view.bounds;
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(CGRectGetMinX(mainViewBounds),
                                                                    20,
                                                                    self.navigationController.view.bounds.size.width,
                                                                    40)];
    //设置搜索框的代理, 以便监测对搜索框的相关操作
    self.searchBar.delegate = self;
    
   //直接设置为tabBarItem的titleView和添加到视图上效果是不一样的
    //self.navigationItem.titleView = customSearchBar;
    
    //这里要添加到导航控制器的view上
    
    //self.navigationController.view
    // The getter first invokes [self loadView] if the view hasn't been set yet. Subclasses must call super if they override the setter or getter.
    [self.navigationController.view addSubview: self.searchBar];
    
    [self.searchBar release];
    
//    CGRect viewBounds = self.navigationController.view.bounds;
//    [self.view setFrame:CGRectMake(CGRectGetMinX(viewBounds),
//                                   CGRectGetMinY(viewBounds) + 40,
//                                   CGRectGetWidth(viewBounds),
//                                   CGRectGetHeight(viewBounds) - 128)];
    
 self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.000 green:0.618 blue:0.062 alpha:1.000];
    
    //去掉搜索框的黑色边框
    [self.searchBar setBackgroundImage:[[[UIImage alloc] init] autorelease]];
    
    
    self.searchBar.barTintColor = [UIColor orangeColor];
    self.searchBar.placeholder = @"输入宝贝名称搜索比价";
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"2-orange-menu-bar.png"] forBarMetrics:UIBarMetricsDefault];
    
}


- (void)removeSearchbar
{
    
    [self.searchBar removeFromSuperview];
    
}


//设置导航栏搜索框点击出现取消按钮并更改取消按钮样式
//必须在这个方法里面写, 不然有可能遍历不到这个取消button
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
    
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(backToFirstPage)] autorelease];
    
    
    //searchBar.subviews[0] searchBar里面只有一个子视图, 故取第一个也是对的
    //cancleButton属于searchBar的子视图的子视图
    //[searchBar setShowsCancelButton:YES animated:YES];
//    for (id obj in [searchBar.subviews[0] subviews]) {
//        if ([obj isKindOfClass:[UIButton class]]) {
//            
//            //强转类型, 将id类型转为UIButton类型
//            UIButton *cancleButton = (UIButton *)obj;
//            //设置文字
//            [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
//            //设置文字颜色
//            //[cancleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        }
//    }
//    
    
    searchBar.frame = CGRectMake(0,
                                      22,
                                      [UIScreen mainScreen].bounds.size.width - 50,
                                      40);

    
    [self getSearchHistoryList];
    
    [self.tableView reloadData];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 43, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    
    //UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(takeBackKeyBoard)];
    
    //[self.tableView addGestureRecognizer:tap];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView release];
}



- (void)backToFirstPage
{
    
    //收回键盘
    [self.searchBar resignFirstResponder];
    
    
    [self.tableView removeFromSuperview];
    
    CGRect mainViewBounds = self.navigationController.view.bounds;
    self.searchBar.frame = CGRectMake(CGRectGetMinX(mainViewBounds),
                                 20,
                                 self.navigationController.view.bounds.size.width,
                                 40);
    
}






//轻触tabView收回键盘
//- (void)takeBackKeyBoard
//{
//    
//    if ([self.searchBar canResignFirstResponder]) {
//        [self.searchBar resignFirstResponder];
//    }
//    
//    
//}


//设置当点击取消按钮时的方法
//- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
//{
//    //收回键盘
//    [searchBar resignFirstResponder];
//    
//    
//    [self.tableView removeFromSuperview];
//    
//    
//    //将取消按钮设为隐藏
//    [searchBar setShowsCancelButton:NO animated:YES];
//    
//}
//


//点击键盘上的搜索按钮时触发此方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (searchBar.text.length != 0) {
        
        
    
    //往数组中添加数据
    if (![self.searchHistory containsObject:self.searchBar.text]) {
        [self.searchHistory addObject:self.searchBar.text];
    }
    
    
    [self updataSearchHistoryList];
    
    [self.tableView reloadData];

    

    if ([searchBar canResignFirstResponder]) {
        [searchBar resignFirstResponder];
    }
    
    
    [searchBar setShowsCancelButton:NO animated:YES];
    
    SearchContentViewController *contentVC = [[SearchContentViewController alloc] init];
    
    contentVC.searchName = searchBar.text;
    
    //在页面发生跳转之前将加载在视图上的tabView移除, 不然回来的时候还是停留在搜索页面且无法返回主页
   
        [self.tableView removeFromSuperview];
        
        [self.navigationController pushViewController:contentVC animated:YES];
        [contentVC release];
    
    }else
    {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"输入内容不能为空"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        
        
        [alertView show];
        [alertView release];
        
    }

}


#pragma mark - 通过点击tabBar返回主页面

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    //更新plist文件
    //[self updataSearchHistoryList];

    //移除搜索列表
    [self.tableView removeFromSuperview];

    
}


#pragma mark - tableView的相关方法  (搜索列表)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"%ld", self.searchHistory.count);
    if (section == 0) {
        return self.searchHistory.count;

    }else{
        return 0;
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *str = @"cell";
        
        SearchListTableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            
            cell = [[SearchListTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
        }
        
        cell.nameLabel.text = self.searchHistory[indexPath.row];
        
        return cell;

    }else{
        
        
        return nil;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        [but setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
        if (self.searchHistory.count > 0) {
            [but setTitle:@"清空当前搜索记录" forState:UIControlStateNormal];
            [but setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        }else{
            [but setTitle:@"没有搜索历史记录" forState:UIControlStateNormal];
            [but setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];

        }
        [but addTarget:self action:@selector(cleanSearchHistoryList) forControlEvents:UIControlEventTouchUpInside];
        return but;
        
    }
    return nil;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        
        UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)] autorelease];
        
        return view;

    }
    
    return nil;
}



- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 50;

    }
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 49;

    }
    return 0;
}


- (void)cleanSearchHistoryList
{
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    NSString *plistPath = [[libraryPath stringByAppendingPathComponent:@"Preferences"] stringByAppendingPathComponent:@"SearchHistoryList.plist"];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    //删除plist文件
    if ([manager fileExistsAtPath:plistPath])
    {
        [manager removeItemAtPath:plistPath error:nil];
    }
    
    //清空数组
    [self.searchHistory removeAllObjects];
    
    
    //刷新数据
    [self.tableView reloadData];
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SearchContentViewController *contentVC = [[SearchContentViewController alloc] init];

    contentVC.searchName = self.searchHistory[indexPath.row];
    
    [self.searchBar setShowsCancelButton:NO animated:YES];
    
    if ([self.searchBar canResignFirstResponder]) {
        [self.searchBar resignFirstResponder];
    }
    
    [self.tableView removeFromSuperview];

    [self.navigationController pushViewController:contentVC animated:YES];
    
    [contentVC release];
    
    
}


#pragma mark - 搜索列表数据 
/*
 每次进来先把plist文件里面的数据读出来存到数组中, 当点击搜索的时候把元素添加到数组中, 然后在移除tabView的时候更新plist文件
 
 不能每次点击搜索的时候都更新一下plist文件, 这样每次都要重新创建对内存耗费较高, 故在页面即将消失的时候更新一下即可, 即remove的时候
 */



- (void)updataSearchHistoryList
{
    
    //有一个很简单的数组去重方法, 看数组是否包含某个元素, 不需要一个个遍历比较
    
    //NSString *dou = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    //NSLog(@"%@", dou);
    
    NSUserDefaults *user = [[[NSUserDefaults alloc] initWithSuiteName:@"SearchHistoryList"] autorelease];
    
    [user setObject:self.searchHistory forKey:@"array"];
    [user synchronize];
}


- (NSMutableArray *)searchHistory
{
    if (!_searchHistory) {
        self.searchHistory = [NSMutableArray arrayWithCapacity:1];
    }
    return _searchHistory;
}


- (void)getSearchHistoryList
{
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    NSString *plistPath = [[libraryPath stringByAppendingPathComponent:@"Preferences"] stringByAppendingPathComponent:@"SearchHistoryList.plist"];
    
    NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    NSArray *ary = dic[@"array"];
    for (NSString *str in ary) {
        
        //保存的时候需要去重, 取出的时候也需要判断, 不然数据会重复
        if (![self.searchHistory containsObject:str]) {
            [self.searchHistory addObject:str];
        }
    }
    
}


#pragma mark - 获取数据详情列表数据


- (NSMutableArray *)listAry
{
    if (!_listAry) {
        self.listAry = [NSMutableArray arrayWithCapacity:1];
    }
    
    return [[_listAry retain] autorelease];
}

- (NSMutableArray *)detailAry
{
    if (!_detailAry) {
        
        self.detailAry = [NSMutableArray arrayWithCapacity:1];
    }
    return [[_detailAry retain] autorelease];
    
}


- (void)getDetailDataFromServer
{
    
    NSString *urlString = [NSString stringWithFormat:@"http://apapia.manmanbuy.com/index_json.ashx?jsoncallback=?&methodName=getsortlist"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    NSString *plistPath = [[libraryPath stringByAppendingPathComponent:@"Preferences"] stringByAppendingPathComponent:@"SearchInfor.plist"];
    
    if ([fileManager fileExistsAtPath:plistPath])
    {
        
        [self getPlistData];
        
        [self.searchView reloadData];

    }else{
    
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self savePlist:responseObject];

        
        [self.searchView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
        
        
    }
    
}


#pragma mark - 从plst文件中获取详情列表数据

- (void)getPlistData
{
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    NSString *plistPath = [[libraryPath stringByAppendingPathComponent:@"Preferences"] stringByAppendingPathComponent:@"SearchInfor.plist"];
    
    NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    NSArray *ary = dic[@"array"];
    for (NSDictionary *dic in ary) {
        
        SearchList  *list = [[SearchList alloc] initWithListDIc:dic];
        [self.listAry addObject:list];
        [list release];
    }

}


- (void)getHotPlist
{
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    NSString *plistPath = [[libraryPath stringByAppendingPathComponent:@"Preferences"] stringByAppendingPathComponent:@"SearchHot.plist"];
    
    NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSArray *ary = dic[@"array"];
    for (NSDictionary *dic in ary) {
        
        HotSearch *hot = [[HotSearch alloc] initWithDic:dic];
        [self.hotSearchAry addObject:hot];
        [hot release];
        
    }
    
}


#pragma mark - 把数据保存到本地

- (void)savePlist:(id)responseObject
{
    
    NSMutableArray *ary = [NSMutableArray arrayWithCapacity:1];

    for (NSDictionary *dic in responseObject)
    {
        SearchList  *list = [[SearchList alloc] initWithListDIc:dic];
        [self.listAry addObject:list];
        [list release];
        
        
        NSMutableArray *ary1 = [NSMutableArray arrayWithCapacity:1];
        
        for (NSDictionary * dic2 in dic[@"subSort"])
        {
            NSDictionary *dic3 = @{@"itemsid" : dic2[@"itemsid"], @"itemname" : dic2[@"itemname"]};
            [ary1 addObject:dic3];
        }
        NSDictionary *dic1 = @{@"itemId": dic[@"itemId"], @"itemSort" : dic[@"itemSort"], @"subSort" : ary1};
        
        [ary addObject:dic1];
    }
    NSString *dou = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    //NSLog(@"%@", dou);
    
    
    NSUserDefaults *user = [[[NSUserDefaults alloc] initWithSuiteName:@"SearchInfor"] autorelease];
    
    [user setObject:ary forKey:@"array"];
    
    [user synchronize];
}



- (void)saveHotPlist:(id)responseObject
{
    NSMutableArray *ary = [NSMutableArray arrayWithCapacity:1];
    
    for (NSDictionary *dic in responseObject) {
        [ary addObject:dic];
    }
    
    //NSString *dou = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    NSUserDefaults *user = [[[NSUserDefaults alloc] initWithSuiteName:@"SearchHot"] autorelease];
    [user setObject:ary forKey:@"array"];
    [user synchronize];
    
}


#pragma mark - 获取热门搜索数据

- (NSMutableArray *)hotSearchAry
{
    if (!_hotSearchAry) {
        self.hotSearchAry = [NSMutableArray arrayWithCapacity:1];
    }
    return _hotSearchAry;
    
    
}


- (void)getHotDataFromServer
{
    NSString *urlString = [NSString stringWithFormat:@"http://apapia.manmanbuy.com/index_json.ashx?jsoncallback=?&methodName=gethotkey"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    NSString *plistPath = [[libraryPath stringByAppendingPathComponent:@"Preferences"] stringByAppendingPathComponent:@"SearchHot.plist"];
    
    if ([fileManager fileExistsAtPath:plistPath])
    {
        
        [self getHotPlist];
        
        [self.searchView reloadData];
        
    }else{
        
        
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        [self saveHotPlist:responseObject];
        
        
        for (NSDictionary *dic in responseObject) {
            
            HotSearch *hot  = [[HotSearch alloc] initWithDic:dic];
            
            [self.hotSearchAry addObject:hot];
            [hot release];
            
        }
        
        [self.searchView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    }
    
}


#pragma mark - UICollectionViewDataSource 返回集合视图的各种数据

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.hotSearchAry.count;
        
    }
    return self.detailAry.count;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
   
    
    return 3;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        HotSearchViewCell *hotCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"hotSearch" forIndexPath:indexPath];
        
        if (self.hotSearchAry.count > 1){
            //NSLog(@"%ld, %ld", indexPath.section, indexPath.row);
        hotCell.hot = [self.hotSearchAry objectAtIndex:indexPath.row];
        //hotCell.layer.borderColor = [UIColor darkGrayColor].CGColor;
        //hotCell.layer.borderWidth = .3;
        return hotCell;
        }
    }
    
    DetailCollectionViewCell *detailCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"detail" forIndexPath:indexPath];
    
    detailCell.detail = [self.detailAry objectAtIndex:indexPath.row];
    
    //detailCell.layer.borderColor = [UIColor darkGrayColor].CGColor;
    //detailCell.layer.borderWidth = .3;
    return detailCell;
    

}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            SearchHotHeaderView *hotView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"hotHeader" forIndexPath:indexPath];
            
            
            return hotView;

        }else{
            self.hotFooterView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"hotFooter" forIndexPath:indexPath];
            
            return self.hotFooterView;
        }
        
    }else if (indexPath.section == 1) {
        
        SearchHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
       
        headerView.button1.number = 1;
        headerView.button2.number = 1;
        headerView.button3.number = 1;
        headerView.button4.number = 1;
        
        if (self.listAry.count > 1) {
            headerView.button1.list = [self.listAry objectAtIndex:0];
            [headerView.button1 addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
            headerView.button2.list = [self.listAry objectAtIndex:1];
            [headerView.button2 addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
            headerView.button3.list = [self.listAry objectAtIndex:2];
            [headerView.button3 addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
            headerView.button4.list = [self.listAry objectAtIndex:3];
            [headerView.button4 addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
        }
        return headerView;
    }
    
        SearchFooterView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
    
        headerView.button1.number = 2;
        headerView.button2.number = 2;
        headerView.button3.number = 2;
        headerView.button4.number = 2;
        
        if (self.listAry.count > 1) {
            headerView.button1.list = [self.listAry objectAtIndex:4];
            [headerView.button1 addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
            headerView.button2.list = [self.listAry objectAtIndex:5];
            [headerView.button2 addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
            headerView.button3.list = [self.listAry objectAtIndex:6];
            [headerView.button3 addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
            headerView.button4.list = [self.listAry objectAtIndex:7];
            [headerView.button4 addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        return headerView;
 
}


- (Record *)record
{
    if (!_record) {
        self.record = [[[Record alloc] init] autorelease];
    }
    return _record;
    
}

#pragma mark - 处理button的点击事件



- (void)touch:(SearchButton *)sender{
    
    //self.hotFooterView.center = CGPointMake(0, 0);
    
    //NSLog(@"####%.f", self.searchView.contentOffset.y);
    
    //使视图发生偏移, 将下面的展开的内容全部显示出来
    self.searchView.contentOffset = CGPointMake(0, 170);
    
    
    //sender.center = CGPointMake(0, 0);
    
    if (sender.number == 1)
    {
        self.record.firstSection = YES;
        self.record.secondSection = NO;
    }else
    {
        self.record.firstSection = NO;
        self.record.secondSection = YES;
    }
 
    if (self.touchAry.count > 1)
    {
    
        [self.touchAry removeObjectAtIndex:0];
    }
    
    if ([self.touchAry containsObject:sender.list.listID])
    {
        self.record.selected = NO;
        [self.touchAry removeObject:sender.list.listID];
    }else{
        
        self.record.selected = YES;
        [self.touchAry addObject:sender.list.listID];

    }
    
     //NSLog(@"selected = %d, first = %d, second = %d", self.record.selected, self.record.firstSection, self.record.secondSection);
    
    [self.detailAry removeAllObjects];
    
    for (NSDictionary *detailDic in sender.list.detailList)
    {
        SearchDetail *detail = [[SearchDetail alloc] initWithDetailDic:detailDic];
        
        [self.detailAry addObject:detail];
        [detail release];
    }
    
    if (!self.myView) {
        self.myView = [[[UILabel alloc] initWithFrame:CGRectMake(kWIDTH / 8 - 5, sender.bottom - 4, 15, 15)] autorelease];
        
        self.myView1 = [[[UIView alloc] initWithFrame:CGRectMake(kWIDTH / 8 - 5 + 0.5, sender.bottom - 4, 13, 15)] autorelease];
        
        self.myView1.backgroundColor = [UIColor whiteColor];
        self.myView.backgroundColor = [UIColor darkGrayColor];
        
        
        self.myView.transform = CGAffineTransformMakeRotation(M_PI_4);
        self.myView1.transform = CGAffineTransformMakeRotation(M_PI_4);
        
    }
    
    if (self.record.selected) {
        [sender addSubview:self.myView];
        [sender addSubview:self.myView1];

    }else
    {
        [self.myView removeFromSuperview];
        [self.myView1 removeFromSuperview];

    }
    
    [self.searchView reloadData];
    
}


- (NSMutableArray *)touchAry
{
    if (!_touchAry) {
        self.touchAry = [NSMutableArray arrayWithCapacity:1];
    }
    
    return _touchAry;
}


#pragma mark - UICollectionViewDelegate  选中的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        
        SearchContentViewController *contentVC = [[SearchContentViewController alloc] init];
        
        //跳转的时候更改跳转之后返回的按钮的名字
        //    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
        //    returnButtonItem.title = @"";
        //    self.navigationItem.backBarButtonItem = returnButtonItem;
        
        contentVC.searchName = [self.hotSearchAry[indexPath.row] searchName];
        
        
        [self.navigationController pushViewController:contentVC animated:YES];
        [self.view.window showHUDWithText:@"加载中" Type:ShowLoading Enabled:YES];
        
        [contentVC release];

    }else
    {
        SearchListViewController *searchListVC = [[SearchListViewController alloc] init];
        
        searchListVC.listId = [self.detailAry[indexPath.row] detailID];
        searchListVC.listTitle = [self.detailAry[indexPath.row] detailName];
        
        
        [self.navigationController pushViewController:searchListVC animated:NO];
        [self.view.window showHUDWithText:@"加载中" Type:ShowLoading Enabled:YES];
        
        [searchListVC release];

    }
    
    //NSLog(@"%ld, %ld, %d", indexPath.section, indexPath.row, self.record.selected);
 
}


#pragma mark - UICollectionViewDelegateFlowLayout 集合视图的布局
//item大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //negative or zero sizes are not supported in the flow layout
    //在流布局中不支持负或零大小
    //也就是说当我在把集合视图某个区的item的尺寸全置为0时, 就会出现点击错误或某一个区消失, 目前自己只试出了这一种解决办法
    
    
    if (self.record.selected && self.record.firstSection)
    {
        switch (indexPath.section) {
            case 0:
                return CGSizeMake([HotSearchViewCell callWidth:self.hotSearchAry[indexPath.row]] + ([UIScreen mainScreen].bounds.size.width / 320) * 30, 30);            case 1:
                return CGSizeMake([UIScreen mainScreen].bounds.size.width / 4, 50);
            case 2:
                return CGSizeMake(0.0001, 0.0001);

        }
    }else if (self.record.selected && self.record.secondSection){
        
        switch (indexPath.section) {
            case 0:
                return CGSizeMake([HotSearchViewCell callWidth:self.hotSearchAry[indexPath.row]] + ([UIScreen mainScreen].bounds.size.width / 320) * 30, 30);
            case 1:
                return CGSizeMake(0.0001, 0.0001);

            case 2:
                return CGSizeMake([UIScreen mainScreen].bounds.size.width / 4, 50);
                
        }
    }else if (!self.record.selected){
        
        switch (indexPath.section) {
            case 0:
                return CGSizeMake([HotSearchViewCell callWidth:self.hotSearchAry[indexPath.row]] + ([UIScreen mainScreen].bounds.size.width / 320) * 30, 30);
            case 1:
                return CGSizeMake(0.00001, 0.0001);
                
            case 2:
                return CGSizeMake(0.00001, 0.000001);
        }
        
        return CGSizeMake(0.0001, 0.0001);

    }
    return CGSizeMake(0.0001, 0.0001);

}

//最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{

    if (section == 0) {
        return [UIScreen mainScreen].bounds.size.width / 32;
    }
    
    return 0;
    
    
}


//最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    
    return 0;
    
}


//区头尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 50);
    }else if (section == 1){
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 110);

    }else{
        
        //通过改变二区和三区区头的尺寸来显示黑色的背景色, 这就需要在设置button尺寸的时候需要把高度的尺寸写死
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 110);

    }
}

//区尾尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 50);

    }
    
    //这里一定要给没有配置区尾的分区加上一句,不然一直崩溃
    return CGSizeMake(0, 0);

    
}

//分区的边界
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        //上 , 左, 下, 右
        return UIEdgeInsetsMake(5, 5, 5, 5);
    }
    
        return UIEdgeInsetsMake(0, 0, 0, 0);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
