//
//  RecommendCell.h
//  Class2509
//
//  Created by laouhn on 15/7/15.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemModel.h"
@interface RecommendCell : UICollectionViewCell
@property (nonatomic, retain) ItemModel *itemModel;


+ (CGFloat)returnHeightForCell:(ItemModel *)itemModel;
@end
