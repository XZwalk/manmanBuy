//
//  ProductDetailViewController.m
//  Class2509
//
//  Created by laouhn on 15/7/14.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "ProducDetailCell.h"
#import "ProductDetailView.h"
#import "NetworkHelper.h"
#import "SearchListSingle.h"
#import "MallListCell.h"
#import "BuySecondViewController.h"
#import "UIWindow+YzdHUD.h"


@interface ProductDetailViewController ()<UITableViewDataSource,UITableViewDelegate, NetworkHelperDelegate>

@property (nonatomic, retain)ProductDetailView *pvView;
@property (nonatomic, retain) NSMutableArray *mallAry;
@property (nonatomic, retain) NSMutableArray *dataAry;

@end


@implementation ProductDetailViewController

- (void)dealloc
{
    self.produceID = nil;
    self.pvView = nil;
    self.mallAry = nil;
    self.dataAry = nil;
    [super dealloc];
}


- (void)loadView
{
    self.pvView = [[[ProductDetailView alloc] initWithFrame:[UIScreen mainScreen].bounds] autorelease];
    self.view = self.pvView;
    
}


- (void)viewWillAppear:(BOOL)animated
{
    
    //当返回的时候取消cell的选中状态
    [self.pvView.detailView deselectRowAtIndexPath:[self.pvView.detailView indexPathForSelectedRow] animated:YES];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"商品详情";
    
    self.pvView.detailView.delegate = self;
    self.pvView.detailView.dataSource = self;
    
    self.pvView.backgroundColor = [UIColor whiteColor];
    [self getDataFromService];
    [self.pvView.detailView reloadData];
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return self.dataAry.count;
            break;
            
        default:return self.mallAry.count;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *strCell = @"cell";
        ProducDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
        if (cell == nil) {
            cell = [[ProducDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
            
       
            
            cell.searchSingle = self.dataAry[0];
        }
        return cell;
    }
    
    static NSString *strCell = @"cells";
    MallListCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    if (cell == nil) {
        cell = [[MallListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strCell];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.mallList = self.mallAry[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 200;
    }
    return 40;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BuySecondViewController *buy = [[BuySecondViewController alloc] init];
    
    NSString *str = [self.mallAry[indexPath.row] mall_link];
    
    NSArray *urlAry = [str componentsSeparatedByString:@"&tourl="];
    
    buy.link = urlAry[1];
    
    [self.navigationController pushViewController:buy animated:YES];
    
    [self.view.window showHUDWithText:@"加载中" Type:ShowLoading Enabled:YES];
    [buy release];
    
}



#pragma mark - 数据解析

- (void)getDataFromService
{
    
    NSString *urlStr = [NSString stringWithFormat:@"http://apapia.manmanbuy.com/index_json.ashx?jsoncallback=?&methodName=getProinfo&id=%@", self.produceID];
    
    NetworkHelper *helper=  [[[NetworkHelper alloc] init] autorelease];
    helper.delegate = self;
    [helper getDataWithUrlString:urlStr];
    
}


- (NSMutableArray *)mallAry
{
    if (!_mallAry) {
        self.mallAry = [NSMutableArray arrayWithCapacity:1];
    }
    return _mallAry;
}


- (NSMutableArray *)dataAry
{
    if (!_dataAry) {
        self.dataAry = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataAry;
}


//当数据成功获取后使用此方法回调
- (void)networkDataIsSuccessful:(NSData *)data
{
    NSArray *ary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    SearchListSingle *single = [[SearchListSingle alloc] initWithSearchListSingleDic:ary[0]];
    [self.dataAry addObject:single];
    [single release];
    
    for (NSDictionary *dic in single.mall_list)
    {
        
        MallList *mallLIst = [[MallList alloc] initWithMallListDic:dic];
        
        [self.mallAry addObject:mallLIst];
        [mallLIst release];
        
    }
    
    
    [self.pvView.detailView reloadData];
    
    
    
    
    
    
}


//当数据获取失败后使用此方法回调
- (void)networkDataIsFail:(NSError *)error
{
    
    
    
    
    
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
