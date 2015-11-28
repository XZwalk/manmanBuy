//
//  CommodityCell.m
//  Class2509
//
//  Created by laouhn on 15/7/9.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "CommodityCell.h"
#import "UIImageView+WebCache.h"
#define kSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
@interface CommodityCell ()

@property (nonatomic, retain) UIImageView *imgView;
@property (nonatomic, retain) UILabel *titlesLabel;
@property (nonatomic, retain) UILabel *mallLabel;
@end
@implementation CommodityCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addAllViews];
    }
    return self;
}



- (UIButton *)collectionButton
{
    if (!_collectionButton) {
        self.collectionButton = [[UIButton alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH - 50, 65, 38, 38)];
    }
    
    return _collectionButton;
}
- (UIImageView *)imgView
{
    if (!_imgView) {
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 80, 90)];
    }
    
    return _imgView;
}



- (UILabel *)titlesLabel
{
    if (!_titlesLabel) {
        self.titlesLabel = [[UILabel alloc] init];
        self.titlesLabel.font = [UIFont systemFontOfSize:12];
        self.titlesLabel.numberOfLines = 0;
    }
    
    return _titlesLabel;
}


- (UILabel *)mallLabel
{
    if (!_mallLabel) {
        self.mallLabel = [[UILabel alloc] init];
        self.mallLabel.font = [UIFont systemFontOfSize:10];
    }
    return _mallLabel;
}


- (void)addAllViews
{
    [self addSubview:self.imgView];
    [self addSubview:self.titlesLabel];
    [self addSubview:self.mallLabel];
    [self addSubview:self.collectionButton];
    
    [self.imgView release];
    [self.titlesLabel release];
    [self.mallLabel release];
    [self.collectionButton release];
}



#pragma mark - 重写set方法给各控制添加数据 给各view写frame
- (void)setCommodity:(OnSaleCommodity *)commodity
{
    if (_commodity != commodity) {
        [_commodity release];
        _commodity = [commodity retain];
    }

    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[self separateString:_commodity.img]]];
    NSString *string = [NSString stringWithFormat:@"%@%@", _commodity.title, _commodity.subTitle];
    self.titlesLabel.textColor = [UIColor blackColor];
    NSMutableAttributedString *allString = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange secondRange = NSMakeRange([[allString string] rangeOfString:_commodity.subTitle].location, [[allString string] rangeOfString:_commodity.subTitle].length);
    [allString addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:secondRange];
    [self.titlesLabel setAttributedText:allString];
    self.mallLabel.text = _commodity.mall;
    CGFloat height = [self returnHeight:_commodity];
    self.titlesLabel.frame = CGRectMake(110, 30, kSCREEN_WIDTH - 115, height);
    self.mallLabel.frame = CGRectMake(110, 45 + height, kSCREEN_WIDTH - 115, 20);
    self.mallLabel.textColor = [UIColor grayColor];
}




#pragma mark - 自适应
- (CGFloat)returnHeight:(OnSaleCommodity *)commodity
{
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:12]};
    NSString *str = [NSString stringWithFormat:@"%@%@", _commodity.title, _commodity.subTitle];
    CGRect rect = [str boundingRectWithSize:CGSizeMake(kSCREEN_WIDTH - 120, 0)
                                    options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                 attributes:dic
                                    context:nil];
    return rect.size.height;
}

#pragma mark -
- (void)dealloc
{
    
    self.imgView = nil;
    self.titlesLabel = nil;
    self.mallLabel = nil;
    self.collectionButton = nil;
    [super dealloc];
}

#pragma mark - 分割出网址

- (NSString *)separateString:(NSString *)str
{
    return  [str componentsSeparatedByString:@"'"][1];
}



@end
