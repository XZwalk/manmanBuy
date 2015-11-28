//
//  MallNavigationViewController.m
//  Class2509
//
//  Created by laouhn on 15/7/10.
//  Copyright (c) 2015年 张祥. All rights reserved.
//


#import "MallNavigationViewController.h"
#import "MallNavigationView.h"
#import "MallCollectionViewCell.h"
#import "ServiceHelper.h"
#import "MallNavigation.h"
#import "ClassBuyViewController.h"
#import "UIWindow+YzdHUD.h"
@interface MallNavigationViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,NetworkHelperDelegate>


@property (nonatomic, retain) ServiceHelper *helper;
@property (nonatomic, retain)MallNavigationView *mView;
@property (nonatomic, retain)NSMutableArray *dataAry;

@end

@implementation MallNavigationViewController

- (void)loadView
{
    [super loadView];
    self.mView = [[MallNavigationView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.mView;
    [self.mView release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.000 green:0.618 blue:0.062 alpha:1.000];
    self.methodName = @"getHzSiteList";
    if (self.tabBarController.selectedIndex == 0) {
         self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backToFirstpage)];
    }
   
    

    [self setForAllViews];
    
}


- (void)setForAllViews
{
    
    
    self.mView.mallView.delegate = self;
    self.mView.mallView.dataSource = self;
    [self.mView.mallView registerClass:[MallCollectionViewCell class] forCellWithReuseIdentifier:@"item"];
    self.mView.mallView.alwaysBounceVertical = YES;
    
    [self getDataFromServer];
    
}

#pragma mark - 获取网络数据解析
- (void)getDataFromServer
{
    self.helper = [[ServiceHelper alloc] init];
    self.helper.delegate = self;
    NSString *urlString = [NSString stringWithFormat:@"http://apapia.manmanbuy.com/index_json.ashx?jsoncallback=?&methodName=%@", self.methodName];
    [self.helper downloadDataWithUrlString:urlString];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.helper connectionCancel];
}
- (void)networkDataIsSuccessful:(id)obj
{
    
    NSArray *ary = [NSJSONSerialization JSONObjectWithData:obj
                                                   options:NSJSONReadingMutableContainers
                                                     error:nil];
    for (NSDictionary *dic in ary) {
        MallNavigation *mallNav = [[MallNavigation alloc] initWithMallDic:dic];
        [self.dataAry addObject:mallNav];
        [mallNav release];
    }
    [self.mView.mallView reloadData];
}

- (void)networkDataIsFail:(NSError *)error
{
    
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
    MallCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    cell.mallNavigation = self.dataAry[indexPath.row];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    ClassBuyViewController *mallNavigation = [[ClassBuyViewController alloc] init];
    mallNavigation.link = [self.dataAry[indexPath.row] urlString];
    [self.navigationController pushViewController:mallNavigation animated:YES];
    [mallNavigation release];
    self.tabBarController.tabBar.hidden = YES;
    [self.view.window showHUDWithText:@"加载中" Type:ShowLoading Enabled:YES];
    
}
- (void)dealloc
{
    self.mView = nil;
    self.dataAry = nil;
    [super dealloc];
}


- (void)backToFirstpage
{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden = NO;
    
    
}







@end
