//
//  CommodityCell.h
//  Class2509
//
//  Created by laouhn on 15/7/9.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OnSaleCommodity.h"

@interface CommodityCell : UITableViewCell

@property (nonatomic, retain) UIButton *collectionButton;

@property (nonatomic, retain) OnSaleCommodity *commodity;
@end
