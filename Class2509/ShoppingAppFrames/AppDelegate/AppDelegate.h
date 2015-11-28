//
//  AppDelegate.h
//  ShoppingApp
//
//  Created by 张祥 on 15/7/8.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) AppTabBarController *tabBar;
+ (NSInteger)OSVersion;


@end

