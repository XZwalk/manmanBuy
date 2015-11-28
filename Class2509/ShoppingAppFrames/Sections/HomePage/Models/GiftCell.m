//
//  GiftCell.m
//  Class2509
//
//  Created by laouhn on 15/7/13.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "GiftCell.h"
#import "UIImageView+WebCache.h"
#define kSCREEN_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)


@interface GiftCell ()


@property (nonatomic, retain) UIImageView *imgView;
@property (nonatomic, retain) UILabel *label;
@end


@implementation GiftCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews
{
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, kSCREEN_WIDTH - 6, 120)];
    self.imgView.layer.masksToBounds = YES;
    self.imgView.layer.cornerRadius = 5.0;
    [self.contentView addSubview:self.imgView];
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 100, kSCREEN_WIDTH, 20)];
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, kSCREEN_WIDTH, 20)];
    [self.contentView addSubview:self.label];
//    view.backgroundColor = [UIColor blackColor];
//    [self.contentView addSubview:view];
//    view.alpha = 0.05;
    self.label.textColor = [UIColor whiteColor];
    self.label.alpha = 1;
    self.label.highlightedTextColor = [UIColor whiteColor];
    [self.label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    [self bringSubviewToFront:self.label];
    [self.imgView release];
    [self.label release];
    
}


- (void)setGift:(GiftList *)gift
{
    if (_gift != gift) {
        [_gift release];
        _gift = [gift retain];
    }
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:_gift.cover_image_url]];
    
    
    self.label.text = _gift.title;
    
    
    
    
}
- (void)dealloc
{
    self.imgView = nil;
    self.label = nil;
    self.gift = nil;
    [super dealloc];
}

@end
