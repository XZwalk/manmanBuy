//
//  HomeDetailView.h
//  Class2509
//
//  Created by laouhn on 15/7/9.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailCommodity.h"
@interface HomeDetailView : UIView

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) DetailCommodity *detailConten;
@property (nonatomic, retain) UIWebView *webView;
@end
