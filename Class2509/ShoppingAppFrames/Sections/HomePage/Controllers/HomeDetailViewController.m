//
//  HomeDetailViewController.m
//  Class2509
//
//  Created by laouhn on 15/7/9.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "HomeDetailView.h"
#import "ServiceHelper.h"
#import "DetailCommodity.h"
#import "NSString+MyString.h"
#import "MyWebView.h"
#import "UIWindow+YzdHUD.h"

@interface HomeDetailViewController ()<NetworkHelperDelegate, UIWebViewDelegate>
@property (nonatomic, retain) ServiceHelper *helper;
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, assign) int count;

@property (nonatomic, retain) MyWebView *myWebView;
@end

@implementation HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.count = 0;
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(returnLastPage)] autorelease];
    self.myWebView.webView.delegate = self;
    
    [self downloadData];
}


- (void)returnLastPage
{
//    [self.helper connectionCancel];
    [self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden = NO;
    self.myWebView.webView.delegate = nil;
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}
#pragma mark - NetworkHelperDelegate
- (void)downloadData
{
    [self.helper downloadDataWithUrlString:[NSString stringWithFormat:@"http://apapia.manmanbuy.com/index_json.ashx?jsoncallback=?&methodName=getcuxiaoinfo&id=%@", self.ID]];
}
- (ServiceHelper *)helper
{
    if (!_helper) {
        self.helper = [[[ServiceHelper alloc] init] autorelease];
        _helper.delegate = self;
    }
    return _helper;
}


- (void)viewWillDisappear:(BOOL)animated
{
    [self.helper connectionCancel];
}
#pragma mark - NetworkHelperDelegate
- (void)networkDataIsSuccessful:(id)obj
{
    id dataObj = [NSJSONSerialization JSONObjectWithData:obj options:NSJSONReadingMutableContainers error:nil];
    self.urlString = [dataObj firstObject][@"golink"];
    NSURL *url = [NSURL URLWithString:[self.urlString separateUrl]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.myWebView.webView loadRequest:request];
}

- (void)networkDataIsFail:(NSError *)error
{
    //UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"网络连接错误" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //[alertView show];
    //[alertView release];
}

#pragma mark -
- (void)loadView
{
    [super loadView];
    self.myWebView = [[[MyWebView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds))] autorelease];
    self.view = self.myWebView;
    
    
    
    [self.myWebView.but1 addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.myWebView.but2 addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.myWebView.but3 addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.myWebView.but4 addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
//    [self.myWebView release];
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
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        }
            break;
            
        default:
            break;
    }
    
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    if (!self.count) {
        [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];

    }
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    self.count++;
}



- (void)dealloc
{
    self.ID = nil;
    self.helper = nil;
    self.urlString = nil;
    self.myWebView = nil;
    [super dealloc];
}

@end
