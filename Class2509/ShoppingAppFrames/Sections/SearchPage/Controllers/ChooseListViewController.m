//
//  ChooseListViewController.m
//  Class2509
//
//  Created by 张祥 on 15/7/14.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "ChooseListViewController.h"
#import "ChooseBrend.h"
#import "ChooseCat.h"
#import "ChooseMall.h"
#import "PriceView.h"
#import "ChooseTableViewCell.h"
#import "UIWindow+YzdHUD.h"
@interface ChooseListViewController ()<UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, retain) UITableView *tabView;
@property (nonatomic, assign) int page;
@property (nonatomic, retain) PriceView *pView;

@end

@implementation ChooseListViewController


- (void)dealloc
{
    self.tabView = nil;
    self.pView = nil;
    self.dic = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"筛选";

    [self addTableView];
    [self addSegmentControl];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)] autorelease];
    
    
}

- (void)addSegmentControl
{
    
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"商城", @"类别", @"品牌", @"价格"]];
    segment.backgroundColor = [UIColor whiteColor];
    segment.tintColor = [UIColor orangeColor];
    
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
            [self.tabView reloadData];
            break;
        case 1:
            self.page = 1;
            [self.tabView reloadData];

            break;
        case 2:
            self.page = 2;
            [self.tabView reloadData];

            break;
        case 3:
            self.page = 3;
            [self.tabView reloadData];

            break;

        default:
            break;
    }

    
    
    
    
}




- (void)addTableView
{
    self.tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 15, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    
    self.tabView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tabView];
    [self.tabView release];
    self.tabView.delegate = self;
    self.tabView.dataSource = self;
    
    
}


- (void)cancel
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.page == 0) {
        
        return [self.dic[@"mall"] count];
        
    }else if (self.page == 1){
        return [self.dic[@"cat"] count];

    }else if (self.page == 2){
        return [self.dic[@"brend"] count];

    }else{
        return 0;
    }
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    if (self.page == 3) {
        self.pView = [[[PriceView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)] autorelease];
        
        [self.pView.chooseBut addTarget:self action:@selector(touchSendValue) forControlEvents:UIControlEventTouchUpInside];
        
        
        return self.pView;

    }
    
    return nil;
    
}

- (void)touchSendValue
{
    
    
    if ([self.pView.maxField canResignFirstResponder]) {
        [self.pView.maxField resignFirstResponder];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];

    [self.view.window showHUDWithText:@"加载中" Type:ShowLoading Enabled:YES];

    
    self.value(@"0", @"0", @"0", self.pView.minField.text, self.pView.maxField.text);
    
    
    
    
    
}








- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    
    if (self.page == 3) {
        return 150;
        
    }
    return 0;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *str = @"cell";
    ChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[ChooseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    
    if (self.page == 0) {
        
        if (indexPath.row == 0) {
            cell.textLabel.text = @"全部商城";
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            cell.mall = @"";
            
        }else{
            
            NSString *name = [(ChooseMall *)[self.dic[@"mall"] objectAtIndex:indexPath.row] mallname];
            NSString *num = [(ChooseMall *)[self.dic[@"mall"] objectAtIndex:indexPath.row] mallnum];
            NSString *ID = [(ChooseMall *)[self.dic[@"mall"] objectAtIndex:indexPath.row] mallid];
            
            cell.textLabel.text = [NSString stringWithFormat:@"%@(%@)", name, num];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.mall = ID;
        }
       
        
    }else if (self.page == 1){
        
        
        
        if (indexPath.row == 0) {
            cell.textLabel.text = @"全部分类";
            cell.cat = @"";
        }else{
            
            NSString *name = [(ChooseCat *)[self.dic[@"cat"] objectAtIndex:indexPath.row] catname];
            NSString *num = [(ChooseCat *)[self.dic[@"cat"] objectAtIndex:indexPath.row] catnum];
            NSString *ID = [(ChooseCat *)[self.dic[@"cat"] objectAtIndex:indexPath.row] catid];
            
            cell.textLabel.text = [NSString stringWithFormat:@"%@(%@)", name, num];
            cell.cat = ID;
        }

        
    }else if (self.page == 2){
        
        
        if (indexPath.row == 0) {
            cell.textLabel.text = @"全部品牌";
            cell.brend = @"";
        }else{
            
            
            NSString *name = [(ChooseBrend *)[self.dic[@"brend"] objectAtIndex:indexPath.row] brendname];
            NSString *num = [(ChooseBrend *)[self.dic[@"brend"] objectAtIndex:indexPath.row] brendnum];
            NSString *ID = [(ChooseBrend *)[self.dic[@"brend"] objectAtIndex:indexPath.row] brendid];

            
            cell.textLabel.text = [NSString stringWithFormat:@"%@(%@)", name, num];
            cell.brend = ID;
            
        }

        
        
       
        
    }else{
    
    }
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell1 = [tableView cellForRowAtIndexPath:indexPath];
    ChooseTableViewCell *cell = (ChooseTableViewCell *)cell1;
    
    if (self.page == 0) {
        
        
        self.value(@"0", @"0", cell.mall, @"0", @"0");

        
    }else if (self.page == 1)
    {
        self.value(cell.cat, @"0", @"0", @"0", @"0");

        
    }else if (self.page == 2){
        
        
        self.value(@"0", cell.brend, @"0", @"0", @"0");

        
    }else{
        
        

        
    }
        
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    [self.view.window showHUDWithText:@"加载中" Type:ShowLoading Enabled:YES];

    
    
    
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
