//
//  StatementViewController.m
//  Class2509
//
//  Created by 张祥 on 15/7/22.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "StatementViewController.h"

@interface StatementViewController ()

@end

@implementation StatementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addStatementLabel];
    self.view.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToFirstPage)];
    [self.view addGestureRecognizer:tap];
    [tap release];
    
}


- (void)backToFirstPage
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addStatementLabel
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, [UIScreen mainScreen].bounds.size.width - 40, 60)];
    UILabel *backLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 100, [UIScreen mainScreen].bounds.size.width, 30)];
    backLabel.textAlignment = NSTextAlignmentCenter;
    backLabel.text =@"^_^单击任意地方返回首页";
    backLabel.font = [UIFont systemFontOfSize:14];
    backLabel.textColor = [UIColor darkGrayColor];

    [self.view addSubview:backLabel];
    [backLabel release];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"此应用只供用于技术交流使用, 不做商业用途";
    [self.view addSubview:label];
    label.numberOfLines = 0;
    [label release];
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
