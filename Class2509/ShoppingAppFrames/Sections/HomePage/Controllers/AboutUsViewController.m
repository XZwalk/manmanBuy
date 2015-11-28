//
//  AboutUsViewController.m
//  Class2509
//
//  Created by 张祥 on 15/7/22.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "AboutUsViewController.h"
#import "UIViewAdditions.h"
@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self addView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToFirstPage)];
    [self.view addGestureRecognizer:tap];
    

    
    
}
- (void)backToFirstPage
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)addView
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 50) / 2, 100, 50, 50)];
    [self.view addSubview:imgView];
    imgView.image = [UIImage imageNamed:@"Icon"];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, imgView.bottom + 20, [UIScreen mainScreen].bounds.size.width - 40, 130)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    titleLabel.text = @"便宜购是一款购物比价软件, 您搜索一款商品以后, 它能够给你罗列出同种商品在不同商城的价格, 销量等, 能让您花最少的钱买到最称心的商品, 祝您购物愉快!";
    titleLabel.numberOfLines = 0;
    UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, titleLabel.bottom + 50, [UIScreen mainScreen].bounds.size.width - 40, 100)];
    emailLabel.text = @"如果您在使用过程中有任何问题, 欢迎给我们留言反馈 \n email:960376043@qq.com";
    [self.view addSubview:emailLabel];
    emailLabel.textAlignment = NSTextAlignmentCenter;
    emailLabel.numberOfLines = 0;
    emailLabel.font = [UIFont systemFontOfSize:15];
    
    UILabel *backLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, emailLabel.bottom + 20, [UIScreen mainScreen].bounds.size.width - 40, 30)];
    backLabel.text = @"^_^单击任意地方返回首页";
    [self.view addSubview:backLabel];
    backLabel.font = [UIFont systemFontOfSize:14];
    backLabel.textAlignment = NSTextAlignmentCenter;
    backLabel.textColor = [UIColor darkGrayColor];

    [imgView release];
    [titleLabel release];
    [emailLabel release];
    [backLabel release];
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
