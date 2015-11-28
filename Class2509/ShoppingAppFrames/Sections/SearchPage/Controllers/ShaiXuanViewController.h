//
//  ShaiXuanViewController.h
//  Class2509
//
//  Created by laouhn on 15/7/14.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^PassValue) (NSString *brend, NSString *price1, NSString *price2);



@interface ShaiXuanViewController : UIViewController

@property (nonatomic, copy)NSString *shaiXuanId;
@property (nonatomic, copy) PassValue value;



@end
