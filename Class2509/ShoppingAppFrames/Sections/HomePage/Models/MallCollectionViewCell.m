//
//  MallCollectionViewCell.m
//  Class2509
//
//  Created by laouhn on 15/7/10.
//  Copyright (c) 2015年 张祥. All rights reserved.
//


#import "MallCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@interface MallCollectionViewCell ()

@property (nonatomic, retain)UIImageView *imgView;
@property (nonatomic, retain)UILabel *mallLable;

@end

@implementation MallCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.imgView];
        [self addSubview:self.mallLable];
        [self.mallLable release];
        [self.mallNavigation release];
        [self addBlackLabel];
    }
    return self;
}


- (void)addBlackLabel
{
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 0.5, 0, 0.5, self.frame.size.height)];
    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.5)];
    rightLabel.backgroundColor = [UIColor darkGrayColor];
    bottomLabel.backgroundColor = [UIColor darkGrayColor];
    [self addSubview:rightLabel];
    [self addSubview:bottomLabel];
    [rightLabel release];
    [bottomLabel release];
    
}


- (UIImageView *)imgView
{
    if (_imgView == nil) {
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width / 3 -20, 35)];
    }
    return [[_imgView retain] autorelease];
}

- (UILabel *)mallLable
{
    if (_mallLable == nil) {
        self.mallLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 45, [UIScreen mainScreen].bounds.size.width / 3 -20, 20)];
        self.mallLable.font = [UIFont systemFontOfSize:13];
        self.mallLable.textAlignment = NSTextAlignmentCenter;
    }
    return [[_mallLable retain] autorelease];
}

- (void)setMallNavigation:(MallNavigation *)mallNavigation
{
    if (_mallNavigation != mallNavigation) {
        [_mallNavigation release];
        _mallNavigation = [mallNavigation retain];
    }
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:_mallNavigation.img]];
    self.mallLable.text = _mallNavigation.name;
}

- (void)dealloc
{
    self.imgView = nil;
    self.mallLable = nil;
    [super dealloc];
}


@end
