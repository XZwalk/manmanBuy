//
//  ClassBuyViewController.m
//  Class2509
//
//  Created by 张祥 on 15/7/19.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "ClassBuyViewController.h"
#import "MyWebView.h"
#import "SearchViewController.h"
#import "SearchContentViewController.h"
#import "UIWindow+YzdHUD.h"


@interface ClassBuyViewController ()<UIWebViewDelegate>
@property (nonatomic, retain)MyWebView *myWebView;
@property (nonatomic, retain) UISearchBar *searchBar;


@end

@implementation ClassBuyViewController




- (void)dealloc
{
    self.myWebView.webView.delegate = nil;
    self.myWebView = nil;
    self.searchBar = nil;
    self.link = nil;
    [super dealloc];
}


- (void)loadView
{
    self.myWebView = [[MyWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.myWebView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myWebView.webView.delegate = self;
    self.navigationItem.title = @"购买商品";
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self action:@selector(returnCabBage:)] autorelease];
    
    
    NSURL *url = [NSURL URLWithString:self.link];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.myWebView.webView loadRequest:request];
    
    
    [self.navigationItem setHidesBackButton:YES];
    
    
    
    
    for (UIView *view in self.navigationController.view.subviews)
    {
        if ([view isKindOfClass:[UISearchBar class]])
        {
            self.searchBar = (UISearchBar *)view;
            
        }
    }
    
    
    [self.myWebView.but1 addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.myWebView.but2 addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.myWebView.but3 addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.myWebView.but4 addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
}




- (void)actionClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 1000:
        {
            [self.myWebView.webView goBack];
            
            
        }
            break;
        case 1001:
        {
            
            [self.myWebView.webView goForward];
            
        }
            break;
        case 1002:
        {
            
            [self.myWebView.webView reload];
            
        }
            break;
        case 1003:
        {
            [self.myWebView.webView stopLoading];
            
        }
            break;
            
        default:
            break;
    }
    
    
}




- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

}



- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication  sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
}


- (void)returnCabBage:(UIBarButtonItem *)sender
{
    [self.myWebView.webView stopLoading];
    self.myWebView.webView.delegate = nil;
    [self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden = NO;
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}


@end
