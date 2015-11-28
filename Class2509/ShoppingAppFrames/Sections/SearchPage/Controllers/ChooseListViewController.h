//
//  ChooseListViewController.h
//  Class2509
//
//  Created by 张祥 on 15/7/14.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^PassValue) (NSString *smallclass, NSString *ppid, NSString *siteid, NSString *price1, NSString *price2);


@interface ChooseListViewController : UIViewController


@property (nonatomic, copy) NSDictionary *dic;

@property (nonatomic, copy) PassValue value;

@end
