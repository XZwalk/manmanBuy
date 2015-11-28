//
//  PageControllCell.m
//  Class2509
//
//  Created by laouhn on 15/7/13.
//  Copyright (c) 2015年 张祥. All rights reserved.
//
#define kSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#import "PageControllCell.h"


@interface PageControllCell ()

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *label;
@end
@implementation PageControllCell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllViews];
    }
    return self;
}


- (void)addAllViews
{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, (kSCREEN_WIDTH - 80) / 5 - 5, 40)];
    [self addSubview:self.imageView];
    [self.imageView release];
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(5, 45, (kSCREEN_WIDTH - 80) / 5, 20)];
    [self addSubview:self.label];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont systemFontOfSize:12];
    [self.label release];
}


- (void)setModel:(HomeModel *)model
{
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    
    self.imageView.image = [UIImage imageNamed:_model.image];
    self.label.text = _model.labelText;
    
}


- (void)dealloc
{
    self.model = nil;
    self.imageView = nil;
    self.label = nil;
    [super dealloc];
}
@end
