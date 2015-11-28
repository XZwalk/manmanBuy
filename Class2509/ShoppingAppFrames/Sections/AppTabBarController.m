//
//  AppTabBarController.m
//  ShoppingApp
//
//  Created by 张祥 on 15/7/8.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "AppTabBarController.h"

@interface AppTabBarController ()

@end

@implementation AppTabBarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    //self.tabBar.tintColor = [UIColor colorWithRed:1.000 green:0.547 blue:0.147 alpha:1.000];
    
    self.tabBar.tintColor = [UIColor orangeColor];
    
    [self loadSubControllersSecondMenthod];
    
    
    

    






}




- (void)loadSubControllersSecondMenthod
{
    
    NSArray * controllersNames = @[@"HomeViewController",
                                   @"SearchViewController",
                                   @"CabbagePriceViewController",
                                   @"MallNavigationViewController"];
    
    
    NSArray * titles = @[@"首页", @"搜索", @"值得买", @"商城导航"];
    
    
    
    NSArray * images = @[@"tag_jinri_normal", @"tag_category_nor", @"tag_brand_group_nor", @"tag_back_integration_nor"];
    //NSArray *selectedImages = @[@"tag_jinri_process", @"tag_category_process", @"tag_back_integration_process", @"tag_brand_group_process"];
    
    NSMutableArray * controllers = [@[] mutableCopy];
    
    
    
    for (int i = 0; i < 4; i++)
    {
     
        
        UIViewController * vc = [[NSClassFromString(controllersNames[i]) alloc] init];
        
        UINavigationController * naVC = [[UINavigationController alloc] initWithRootViewController:vc];
        
        
        if (i != 1) {
            vc.navigationItem.title = titles[i];
        }
        
        vc.tabBarItem.title = titles[i];
        vc.tabBarItem.image = [UIImage imageNamed:images[i]];
        //vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImages[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [controllers addObject:naVC];
        [vc release];
        [naVC release];
        
        
        
    }
    
    self.viewControllers = controllers;
    
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
