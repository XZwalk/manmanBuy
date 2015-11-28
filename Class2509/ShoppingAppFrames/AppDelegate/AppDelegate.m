//
//  AppDelegate.m
//  ShoppingApp
//
//  Created by 张祥 on 15/7/8.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworking.h"
#import "GuidePageView.h"

@interface AppDelegate ()
@property (nonatomic, retain) GuidePageView *guide;

@end

@implementation AppDelegate


+ (NSInteger)OSVersion
{
    static NSUInteger _deviceSystemMajorVersion = -1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
    });
    return _deviceSystemMajorVersion;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    self.tabBar = [[AppTabBarController alloc] init];
    self.window.rootViewController = self.tabBar;
    [self.tabBar release];
    
    [self addGuidePage];
    
    
    return YES;
}


//- (void)addLanchPicture
//{
//    self.window.rootViewController.view.alpha = 0;
//    UIImageView *splashImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Default"]];
//    [self.window addSubview:splashImageView];
//    [UIView animateWithDuration:0.7 animations:^{
//        self.window.rootViewController.view.alpha = 1.0;
//    } completion:^(BOOL finished) {
//        [splashImageView removeFromSuperview];
//    }];
//}

- (void)addGuidePage
{
    
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"isRuned"] boolValue])
    {
        NSArray * ary = @[@"welcome1.png",
                          @"welcome2.png",
                          @"welcome3.png"];
        
        self.guide = [[GuidePageView alloc] initWithFrame:self.window.bounds
                                               namesArray:ary];
        [self.tabBar.view addSubview:self.guide];
        
        [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"isRuned"];
        
        [self.guide.but addTarget:self action:@selector(beginExperience:) forControlEvents:UIControlEventTouchUpInside];
        
    }else
    {
        [self checkNetworkStatus];
        //[self addLanchPicture];

    }
}

- (void)beginExperience:(UIButton *)sender
{
    [self.guide removeFromSuperview];
    [self checkNetworkStatus];
}

#pragma mark - UI方法
#pragma mark - 私有方法
#pragma mark 网络状态变化提示

-(void)alert:(NSString *)message{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
}

#pragma mark 网络状态监测
-(void)checkNetworkStatus{
    //创建一个用于测试的url
    NSURL *url=[NSURL URLWithString:@"http://www.apple.com"];
    AFHTTPRequestOperationManager *operationManager=[[[AFHTTPRequestOperationManager alloc]initWithBaseURL:url] autorelease];
    
    //根据不同的网络状态改变去做相应处理
    [operationManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [self alert:@"您当前网络为2G/3G/4G网络."];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                //[self alert:@"WiFi 网络."];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                [self alert:@"无网络, 请检查网络连接."];
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                break;
                
            default:
                [self alert:@"Unknown."];
                break;
        }
    }];
    
    //开始监控
    [operationManager.reachabilityManager startMonitoring];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
