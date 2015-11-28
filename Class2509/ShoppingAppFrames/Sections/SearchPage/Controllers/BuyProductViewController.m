//
//  BuyProductViewController.m
//  Class2509
//
//  Created by laouhn on 15/7/10.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "BuyProductViewController.h"
#import "MyWebView.h"
#import "SearchViewController.h"
#import "SearchContentViewController.h"
#import "UIWindow+YzdHUD.h"
@interface BuyProductViewController ()<UIWebViewDelegate>

@property (nonatomic, retain)MyWebView *myWebView;
@property (nonatomic, retain) UISearchBar *searchBar;


@end

@implementation BuyProductViewController


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
    
    //这样形式写的webView不能在后面缀上autorelease, 不然一点取消直接崩溃
    self.myWebView = [[MyWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.myWebView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myWebView.webView.delegate = self;
    
    
    [self.navigationItem setHidesBackButton:YES];

    
    
    self.navigationItem.title = @"购买商品";
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self action:@selector(returnLastPage)] autorelease];
    
    NSURL *url = [NSURL URLWithString:self.link];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.myWebView.webView loadRequest:request];
    
    
    
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
            [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
        }
            break;
            
        default:
            break;
    }
    
    
}







- (void)returnLastPage
{
    NSArray *ary =  self.navigationController.viewControllers;
    
    [(SearchViewController *)ary[0] addSearchbar];
    
    
    for (UIView *view in self.navigationController.view.subviews)
    {
        if ([view isKindOfClass:[UISearchBar class]])
        {
            self.searchBar = (UISearchBar *)view;
            
            self.searchBar.frame = CGRectMake(40,
                                              20,
                                              [UIScreen mainScreen].bounds.size.width - 80,
                                              40);
            
        }
    }

    self.searchBar.delegate = ary[1];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{

    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:YES];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
}





- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}


@end
