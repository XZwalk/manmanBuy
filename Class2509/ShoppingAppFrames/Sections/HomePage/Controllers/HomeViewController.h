//
//  HomeViewController.h
//  ShoppingApp
//
//  Created by 张祥 on 15/7/8.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#import <UIKit/UIKit.h>
#import "HomeView.h"
#import "RESideMenu.h"
@interface HomeViewController : UIViewController

@property (nonatomic, retain) HomeView *homeView;
@property (retain, readonly, nonatomic) RESideMenu *sideMenu;
@end
