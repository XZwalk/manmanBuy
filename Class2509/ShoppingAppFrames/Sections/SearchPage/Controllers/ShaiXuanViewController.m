//
//  ShaiXuanViewController.m
//  Class2509
//
//  Created by laouhn on 15/7/14.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "ShaiXuanViewController.h"
#import "ShaiXuan.h"
#import "ProductDetailViewController.h"
#import "PriceView.h"
#import "UIWindow+YzdHUD.h"
@interface ShaiXuanViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain)NSMutableArray *dataAry;
@property (nonatomic, retain)UITableView *sxView;
@property (nonatomic, assign) int page;
@property (nonatomic, retain) PriceView *pView;

@end

@implementation ShaiXuanViewController

- (void)dealloc
{
    self.dataAry = nil;
    self.sxView = nil;
    self.pView = nil;
    self.shaiXuanId = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    self.sxView = [[UITableView alloc] initWithFrame:CGRectMake(0, 15, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];

    self.sxView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.sxView];
    
    [self.sxView release];
    
    self.navigationItem.title = @"筛选";
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(returnPageAction:)] autorelease];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:self action:nil] autorelease];
    
    self.sxView.delegate = self;
    self.sxView.dataSource = self;
    
    
    
    [self addSegmentControl];
    
    [self getDataFromServer];
    
}



- (void)addSegmentControl
{
    
    
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"品牌", @"价格"]];
    segment.backgroundColor = [UIColor whiteColor];
    segment.tintColor = [UIColor orangeColor];
    
    segment.selectedSegmentIndex = 0;
    segment.frame = CGRectMake(10, 70, [UIScreen mainScreen].bounds.size.width - 20, 40);
    [self.view addSubview:segment];
    [segment release];
    [segment addTarget:self action:@selector(segmentedControlAction:) forControlEvents:UIControlEventValueChanged];
}


- (void)segmentedControlAction:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.page = 0;
            [self.sxView reloadData];
            break;
        case 1:
            self.page = 1;
            [self.sxView reloadData];
            break;
            
            
          }

}


- (void)getDataFromServer
{
    NSString *urlString = [NSString stringWithFormat:@"http://apapia.manmanbuy.com/index_json.ashx?jsoncallback=?&methodName=getProlist&page=1&smallid=%@&orderby=MR&price1=0&price2=0&ppid=0", self.shaiXuanId];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSString *dataStr = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
        
        NSArray *array = [dataStr componentsSeparatedByString:@"shaixuan"];
        
        if (array.count > 1) {
            
            
       
        
        NSString *str = array[1];
        NSData *data1 = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *ary = [NSJSONSerialization JSONObjectWithData:data1
                                                          options:NSJSONReadingMutableContainers
                                                            error:nil];
        NSArray *array1 = [[ary objectAtIndex:0] objectForKey:@"brend"];
        //NSLog(@"%@", array1);
        for (NSDictionary *smallDic in array1) {
            ShaiXuan *shaiXuan = [[ShaiXuan alloc] initWithShaiXuanDic:smallDic];
            
            
            
            [self.dataAry addObject:shaiXuan];
            [shaiXuan release];
        }
        [self.sxView reloadData];
             }
        //NSLog(@"%@", self.dataAry);
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.page == 0) {
        return self.dataAry.count;

    }
    return 0;
}






- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strCell = @"cells";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
    }
    
    
    if (self.page == 0) {
        
        
    if (indexPath.row == 0) {
        cell.textLabel.text = @"全部商品";
        cell.textLabel.font = [UIFont systemFontOfSize:16];
    }else
    {
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.text = [self.dataAry[indexPath.row] brendname];
 
    }
    
    return cell;
    }
    
    
    return nil;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (self.page == 1) {
        return 150;
    }
    return 0;
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    if (self.page == 1) {
        self.pView = [[[PriceView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)] autorelease];
        
        [self.pView.chooseBut addTarget:self action:@selector(touchSendValue) forControlEvents:UIControlEventTouchUpInside];
        
        
        return self.pView;
        
    }
    
    return nil;
    
}

- (void)touchSendValue
{
    
    
    
    self.value(@"0", self.pView.minField.text, self.pView.maxField.text);
    [self dismissViewControllerAnimated:YES completion:nil];

    [self.view.window showHUDWithText:@"加载中" Type:ShowLoading Enabled:YES];

    
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    self.value([self.dataAry[indexPath.row] brendid], @"0", @"0");
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.view.window showHUDWithText:@"加载中" Type:ShowLoading Enabled:YES];

    
}


- (void)returnPageAction:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSMutableArray *)dataAry
{
    if (_dataAry == nil) {
        self.dataAry = [NSMutableArray array];
    }
    return [[_dataAry retain] autorelease];
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
