//
//  MallNavigationView.m
//  Class2509
//
//  Created by laouhn on 15/7/10.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "MallNavigationView.h"

@interface MallNavigationView ()

@property (nonatomic, retain)UICollectionViewFlowLayout *layout;

@end

@implementation MallNavigationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addCollectionView];
        self.mallView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addCollectionView
{
    self.layout = [[[UICollectionViewFlowLayout alloc] init] autorelease];
    self.layout.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width - 2) / 3, 70);
    self.layout.minimumLineSpacing = 1;
    self.layout.minimumInteritemSpacing = 1;
    self.backgroundColor = [UIColor grayColor];
    self.mallView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)  collectionViewLayout:self.layout];
    
    [self addSubview:self.mallView];
    
    [self.layout release];
    [self.mallView release];
}


- (void)dealloc
{
    self.mallView = nil;
    self.layout = nil;
    [super dealloc];
}
@end
