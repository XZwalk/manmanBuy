//
//  HotSearchViewCell.h
//  Class2509
//
//  Created by 张祥 on 15/7/10.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotSearch.h"
@interface HotSearchViewCell : UICollectionViewCell


@property (nonatomic, retain) HotSearch *hot;


+ (CGFloat)callWidth:(HotSearch *)hot;



@end
