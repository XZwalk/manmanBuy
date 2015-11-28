//
//  CabBageView.m
//  Class2509
//
//  Created by laouhn on 15/7/10.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "CabBageView.h"

@interface CabBageView ()
@property (nonatomic, retain)UICollectionViewFlowLayout *layout;
@end

@implementation CabBageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addCollectionView];
    }
    return self;
}

- (void)addCollectionView
{
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.layout.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width - 30) / 2, [UIScreen mainScreen].bounds.size.height / 3 + 20);
    self.layout.minimumLineSpacing = 10;
    self.layout.minimumInteritemSpacing = 10;
    self.layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.cabBageView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 100)  collectionViewLayout:self.layout];
    self.cabBageView.backgroundColor = [UIColor whiteColor];
    self.cabBageView.alwaysBounceVertical = YES;

    [self addSubview:self.cabBageView];
    
    [self.cabBageView release];
}

- (void)dealloc
{
    self.layout = nil;
    [super dealloc];
}

@end
