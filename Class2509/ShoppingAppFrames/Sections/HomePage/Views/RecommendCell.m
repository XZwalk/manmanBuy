//
//  RecommendCell.m
//  Class2509
//
//  Created by laouhn on 15/7/15.
//  Copyright (c) 2015年 张祥. All rights reserved.
//
#define kSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define kSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#import "RecommendCell.h"
#import "NSString+MyString.h"
#import "UIImageView+WebCache.h"
@interface RecommendCell ()

@property (nonatomic, retain) UILabel *rightSeparaLabel;
@property (nonatomic, retain) UILabel *downSeparaLabel;
@property (nonatomic, retain) UIImageView *imgView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *mallLabel;
@end
@implementation RecommendCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllViews];
    }
    return self;
}


- (void)addAllViews
{
    
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.mallLabel];
    [self.contentView addSubview:self.rightSeparaLabel];
    [self.contentView addSubview:self.downSeparaLabel];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    self.rightSeparaLabel.backgroundColor = [UIColor grayColor];
    self.downSeparaLabel.backgroundColor = [UIColor grayColor];
    self.mallLabel.font = [UIFont systemFontOfSize:10];
    
    [self.imgView release];
    [self.titleLabel release];
    [self.mallLabel release];
    [self.rightSeparaLabel release];
    [self.downSeparaLabel release];
}


- (void)setItemModel:(ItemModel *)itemModel
{
    if (_itemModel != itemModel) {
        [_itemModel release];
        _itemModel = [itemModel retain];
    }
    
    if (_itemModel) {
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:[_itemModel.thumbURLstring separateString]]];
        NSString *string = [NSString stringWithFormat:@"%@   %@", _itemModel.title, _itemModel.subTitle];
//        self.titleLabel.textColor = [UIColor grayColor];
        NSMutableAttributedString *allString = [[[NSMutableAttributedString alloc] initWithString:string] autorelease];
        NSRange secondRange = NSMakeRange([[allString string] rangeOfString:_itemModel.subTitle].location, [[allString string] rangeOfString:_itemModel.subTitle].length);
        [allString addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:secondRange];
        [self.titleLabel setAttributedText:allString];
        self.mallLabel.text = _itemModel.mall;
        CGFloat height = [RecommendCell returnHeight:_itemModel];
        
        self.titleLabel.frame = CGRectMake(10, 140, kSCREEN_WIDTH / 2 - 25, height);
        self.mallLabel.frame = CGRectMake(10, self.titleLabel.frame.origin.y + height, kSCREEN_WIDTH / 2 - 15, 20);
        self.mallLabel.textColor = [UIColor grayColor];
        self.rightSeparaLabel.frame = CGRectMake(kSCREEN_WIDTH / 2 - 0.5, 0, 0.5f, height + 160);
        self.downSeparaLabel.frame = CGRectMake(0, height + 160 - 0.5, kSCREEN_WIDTH / 2, 0.5f);

    }
    
}

#pragma mark - 自适应
+ (CGFloat)returnHeight:(ItemModel *)itemModel
{
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:12]};
    NSString *str = [NSString stringWithFormat:@"%@   %@", itemModel.title, itemModel.subTitle];
    CGRect rect = [str boundingRectWithSize:CGSizeMake(kSCREEN_WIDTH / 2 - 25, 0)
                                    options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                 attributes:dic
                                    context:nil];
    return rect.size.height;
}

+ (CGFloat)returnHeightForCell:(ItemModel *)itemModel
{
    return [RecommendCell returnHeight:itemModel] + 160;
}


#pragma makr - 懒加载
- (UIImageView *)imgView
{
    if (!_imgView) {
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 5, kSCREEN_WIDTH / 2 - 30,  130)];
    }
    return [[_imgView retain] autorelease];
}


- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        self.titleLabel = [UILabel new];
    }
    
    return [[_titleLabel retain] autorelease];
}


- (UILabel *)mallLabel
{
    if (!_mallLabel) {
        self.mallLabel = [UILabel new];
    }
    return [[_mallLabel retain] autorelease];
}

- (UILabel *)downSeparaLabel
{
    if (!_downSeparaLabel) {
        self.downSeparaLabel = [UILabel new];
    }
    
    return [[_downSeparaLabel retain] autorelease];
}
- (UILabel *)rightSeparaLabel
{
    if (!_rightSeparaLabel) {
        self.rightSeparaLabel = [UILabel new];
    }
    
    return [[_rightSeparaLabel retain] autorelease];
}
#pragma mark - 

- (void)dealloc
{
    self.rightSeparaLabel = nil;
    self.downSeparaLabel = nil;
    self.itemModel = nil;
    self.imgView = nil;
    self.titleLabel = nil;
    self.mallLabel = nil;
    [super dealloc];
}
@end
