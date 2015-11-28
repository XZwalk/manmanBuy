//
//  DetailCollectionViewCell.m
//  Class2509
//
//  Created by 张祥 on 15/7/9.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "DetailCollectionViewCell.h"



@interface DetailCollectionViewCell ()


@property (nonatomic, retain) UILabel *detailLabel;



@end


@implementation DetailCollectionViewCell

- (void)dealloc
{
    self.detail = nil;
    self.detailLabel = nil;
    [super dealloc];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        CGRect rect = CGRectMake(0, 0, self.frame.size.width - 0.5, self.frame.size.height - 0.5);
        self.detailLabel = [[UILabel alloc] initWithFrame:rect];
        self.detailLabel.font = [UIFont systemFontOfSize:14];

        self.detailLabel.numberOfLines = 0;
        
        self.detailLabel.textAlignment = NSTextAlignmentCenter;
        
        self.detailLabel.backgroundColor = [UIColor whiteColor];
        
        //这里如果不加contentView上的话, 相当于label被contentView遮挡了, 无法通过设置背景色显示边框
        [self.contentView addSubview:self.detailLabel];
        self.backgroundColor = [UIColor darkGrayColor];
        [self.detailLabel release];

    }
    
    return self;
    
}


- (void)setDetail:(SearchDetail *)detail
{
    if (_detail != detail) {
        [_detail release];
        
        _detail = [detail retain];
    }
    
    
    self.detailLabel.text = detail.detailName;
    
    
    
    
}


@end
