//
//  CabbagePriceViewController.m
//  ShoppingApp
//
//  Created by 张祥 on 15/7/8.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "CabbagePriceViewController.h"

#import "SCNavTabBarController.h"
#import "AllProductViewController.h"
#import "NinePostViewController.h"
#import "NineteenPostViewController.h"
#import "DigitalHomeAppliancesViewController.h"
#import "HomeLivingViewController.h"
#import "FoodViewController.h"
#import "ManViewController.h"
#import "WomenViewController.h"
#import "ShoeBagViewController.h"
#import "StyleViewController.h"
#import "BabyViewController.h"
#import "MeiZhuangViewController.h"
#import "UIWindow+YzdHUD.h"

@interface CabbagePriceViewController ()



@end

@implementation CabbagePriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.tabBarController.selectedIndex == 0) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backToFirstPage)];
    }
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.000 green:0.618 blue:0.062 alpha:1.000];
    
    
    [self addCollectionViews];
    
}



- (void)backToFirstPage
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden = NO;
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
}

- (void)addCollectionViews
{
    
    AllProductViewController *allVC = [AllProductViewController new];
    NinePostViewController *ninePostVC = [NinePostViewController new];
    NineteenPostViewController *nineteenPostVC = [NineteenPostViewController new];
    DigitalHomeAppliancesViewController *dhaVC = [DigitalHomeAppliancesViewController new];
    HomeLivingViewController *homeVC = [HomeLivingViewController new];
    FoodViewController *foodVC = [FoodViewController new];
    ManViewController *manVC = [ManViewController new];
    WomenViewController *womenVC = [WomenViewController new];
    ShoeBagViewController *shoeBagVC = [ShoeBagViewController new];
    StyleViewController *styleVC = [StyleViewController new];
    BabyViewController *babyVC =[BabyViewController new];
    MeiZhuangViewController *meiZhuangVC = [MeiZhuangViewController new];
    
    
    allVC.title = @"全部";
    ninePostVC.title = @"九块邮";
    nineteenPostVC.title = @"十九块邮";
    dhaVC.title = @"数码家电";
    homeVC.title = @"居家";
    foodVC.title = @"美食";
    manVC.title = @"男装";
    womenVC.title = @"女装";
    shoeBagVC.title = @"鞋包装饰";
    styleVC.title = @"文体";
    babyVC.title = @"母婴";
    meiZhuangVC.title = @"美妆";
    
    
    SCNavTabBarController *scnTC = [[SCNavTabBarController alloc] initWithSubViewControllers:@[allVC, ninePostVC, nineteenPostVC, dhaVC, homeVC, foodVC, manVC, womenVC, shoeBagVC, styleVC, babyVC, meiZhuangVC]];
    [scnTC addParentController:self];
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
