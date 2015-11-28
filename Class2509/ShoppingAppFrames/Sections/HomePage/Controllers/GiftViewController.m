//
//  GiftViewController.m
//  Class2509
//
//  Created by laouhn on 15/7/13.
//  Copyright (c) 2015年 张祥. All rights reserved.
//
#define kSCREEN_BOUNDS [UIScreen mainScreen].bounds
#import "GiftViewController.h"
#import "GiftView.h"
#import "GiftList.h"
#import "GiftCell.h"
#import "ServiceHelper.h"
#import "AFNetworking.h"
#import "BuySecondViewController.h"
#import "UIWindow+YzdHUD.h"

@interface GiftViewController ()<UITableViewDelegate, UITableViewDataSource, NetworkHelperDelegate>
@property (nonatomic, retain) GiftView *giftView;
@property (nonatomic, retain) NSMutableArray *dataSourceArray;
@property (nonatomic, retain) ServiceHelper *helper;
@end

@implementation GiftViewController

- (NSMutableArray *)dataSourceArray
{
    if (!_dataSourceArray) {
        self.dataSourceArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSourceArray;
}
- (GiftView *)giftView
{
    if (!_giftView) {
        self.giftView = [[[GiftView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_BOUNDS.size.width, kSCREEN_BOUNDS.size.height - 100)] autorelease];
        self.giftView.tableView.delegate = self;
        self.giftView.tableView.dataSource = self;
    }
    return _giftView;
}
- (void)loadView
{
    [super loadView];
    self.view = self.giftView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self downloadData];
    
    
    
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(returnLastPage)] autorelease];
    
    
    [self getDataFromServer];

    [self.giftView.tableView registerClass:[GiftCell class] forCellReuseIdentifier:@"cellss"];

}


- (void)viewDidDisappear:(BOOL)animated
{
    [self.helper connectionCancel];
}
- (void)getDataFromServer
{
     self.helper=  [[ServiceHelper new] autorelease ];
    self.helper.delegate = self;
    [self.helper downloadDataWithUrlString:[NSString stringWithFormat:@"http://api.liwushuo.com/v2/collections/%@/posts?limit=20&offset=0", self.ID]];
}
#pragma mark - NetworkHelperDelegate
- (void)networkDataIsSuccessful:(id)obj
{
    
    
    id dataObj = [NSJSONSerialization JSONObjectWithData:obj options:NSJSONReadingMutableContainers error:nil];
    NSArray *array = dataObj[@"data"][@"posts"];
    
    for (NSDictionary *dic in array) {
        
        GiftList *gift = [[GiftList alloc] init];
        gift.title = [dic objectForKey:@"title"];
        gift.cover_image_url = [dic objectForKey:@"cover_image_url"];
        gift.content_url = [dic objectForKey:@"content_url"];
        [self.dataSourceArray addObject:gift];
        [gift release];
        
    }
    
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
    [self.giftView.tableView reloadData];
    
    
}


- (void)networkDataIsFail:(NSError *)error
{
    
    
    //UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"网络连接错误" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //[alertView show];
    //[alertView release];
}



- (void)downloadData
{
    
    
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/collections/%@/posts?limit=20&offset=0", self.ID];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
}



#pragma  mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BuySecondViewController *buyProductVC = [BuySecondViewController new];
    buyProductVC.link = [self.dataSourceArray[indexPath.row] content_url];
    [self.navigationController pushViewController:buyProductVC animated:YES];
    [self.view.window showHUDWithText:@"加载中" Type:ShowLoading Enabled:YES];
    
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        GiftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellss" forIndexPath:indexPath];
//    if (!cell) {
//        cell = [[[GiftCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
//    }
    cell.gift = self.dataSourceArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 126;
}



- (void)returnLastPage
{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    self.tabBarController.tabBar.hidden = NO;
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
}

#pragma mark -

- (void)dealloc
{
    self.helper = nil;
    self.ID = nil;
    self.giftView = nil;
    self.dataSourceArray = nil;
    [super dealloc];
}

@end
