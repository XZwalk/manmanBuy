//
//  CollectionCell.m
//  Class2509
//
//  Created by laouhn on 15/7/8.
//  Copyright (c) 2015年 张祥. All rights reserved.
//


#define KSREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define KSREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#import "CollectionCell.h"
#import "UIImageView+WebCache.h"

@interface CollectionCell ()

@property (nonatomic, retain)UIImageView *imgView;
@property (nonatomic, retain)UILabel *priceLable;
@property (nonatomic, retain)UILabel *panicBuyLable; //抢购
@property (nonatomic, retain)UILabel *titleLable;

@end

@implementation CollectionCell

- (void)dealloc
{
    [self.imgView release];
    [self.priceLable release];
    [self.panicBuyLable release];
    [self.titleLable release];
    [self.product release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imgView];
        [self addSubview:self.priceLable];
        [self addSubview:self.panicBuyLable];
        [self addSubview:self.titleLable];
    }
    return self;
}

- (UIImageView *)imgView
{
    if (_imgView == nil) {
        self.imgView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (KSREEN_WIDTH - 30) / 2, KSREEN_HEIGHT / 3 - 30)] autorelease];
    }
    return [[_imgView retain] autorelease];
}

- (UILabel *)titleLable
{
    if (_titleLable == nil) {
        self.titleLable = [[[UILabel alloc] initWithFrame:CGRectMake(0,KSREEN_HEIGHT / 3 - 30, (KSREEN_WIDTH - 30) / 2, 30)] autorelease];
        self.titleLable.numberOfLines = 0;
        self.titleLable.font = [UIFont systemFontOfSize:12];
    }
    return [[_titleLable retain] autorelease];
}

- (UILabel *)priceLable
{
    if (_priceLable == nil) {
        self.priceLable = [[[UILabel alloc] initWithFrame:CGRectMake(0, KSREEN_HEIGHT / 3, (KSREEN_WIDTH - 30) / 4, 20)] autorelease];
        self.priceLable.font = [UIFont systemFontOfSize:16];
        self.priceLable.textColor = [UIColor orangeColor];
    }
    return [[_priceLable retain] autorelease];
}

- (UILabel *)panicBuyLable
{
    if (_panicBuyLable == nil) {
        self.panicBuyLable = [[[UILabel alloc] initWithFrame:CGRectMake((KSREEN_WIDTH - 30) / 4, KSREEN_HEIGHT / 3, (KSREEN_WIDTH - 30) / 4, 20)] autorelease];
        self.panicBuyLable.font = [UIFont systemFontOfSize:14];
        self.panicBuyLable.backgroundColor = [UIColor orangeColor];
        self.panicBuyLable.textColor = [UIColor whiteColor];
    }
    return [[_panicBuyLable retain] autorelease];
}

- (void)setProduct:(AllProduct *)product
{
    if (_product != product) {
        [_product release];
        _product = [product retain];
    }
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[self separateString:_product.img]]];
    self.titleLable.text = _product.title;
    self.priceLable.text = [NSString stringWithFormat:@"￥%.2f", _product.price];
    self.panicBuyLable.text = [NSString stringWithFormat:@"去%@抢购", _product.mall];
}


#pragma mark - 分割出网址

- (NSString *)separateString:(NSString *)str
{
    return  [str componentsSeparatedByString:@"'"][1];
}







@end
