//
//  SearchCollectionView.m
//  Class2509
//
//  Created by 张祥 on 15/7/9.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "SearchCollectionView.h"



@implementation SearchCollectionView

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        
        
        self.backgroundColor = [UIColor whiteColor];
        
        //当数据内容小于一屏时仍能滚动
        self.alwaysBounceVertical = YES;
        
    }
    
    return self;
    
}

@end
