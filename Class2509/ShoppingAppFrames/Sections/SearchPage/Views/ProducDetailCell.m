//
//  ProducDetailCell.m
//  Class2509
//
//  Created by laouhn on 15/7/15.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#define KSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#import "ProducDetailCell.h"
#import "UIImageView+WebCache.h"
@interface ProducDetailCell ()

@property (nonatomic, retain)UIImageView *imgView;
@property (nonatomic, retain)UILabel *titleLable;
@property (nonatomic, retain)UILabel *mallLable;
@property (nonatomic, retain)UILabel *priceLable;

@end

@implementation ProducDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.imgView];
        [self addSubview:self.titleLable];
        [self addSubview:self.priceLable];
        [self addSubview:self.mallLable];
        
        
        
        
    }
    return self;
}

- (UIImageView *)imgView
{
    if (_imgView == nil) {
        self.imgView = [[[UIImageView alloc] initWithFrame:CGRectMake(90, 3, 160, 120)] autorelease];
    }
    return [[_imgView retain] autorelease];
}

- (UILabel *)titleLable
{
    if (_titleLable == nil) {
        self.titleLable = [[[UILabel alloc] initWithFrame:CGRectMake(20, 130, KSCREEN_WIDTH - 40, 50)] autorelease];
        self.titleLable.numberOfLines = 0;
        self.titleLable.font = [UIFont systemFontOfSize:15];
    }
    return [[_titleLable retain] autorelease];
}

- (UILabel *)priceLable
{
    if (_priceLable == nil) {
        self.priceLable = [[[UILabel alloc] initWithFrame:CGRectMake(20, 180, KSCREEN_WIDTH / 2, 20)] autorelease];
        self.priceLable.font = [UIFont systemFontOfSize:13];
        self.priceLable.textColor = [UIColor orangeColor];
        self.priceLable.numberOfLines = 0;
    }
    return [[_priceLable retain] autorelease];
}

- (UILabel *)mallLable
{
    if (_mallLable == nil) {
        self.mallLable = [[[UILabel alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH / 2 + 10, 180, KSCREEN_WIDTH / 2, 20)]autorelease];
        self.mallLable.font = [UIFont systemFontOfSize:13];
        self.mallLable.numberOfLines = 0;
    }
    return [[_mallLable retain] autorelease];
}

- (void)setSearchSingle:(SearchListSingle *)searchSingle
{
    if (_searchSingle != searchSingle) {
        [_searchSingle release];
        _searchSingle = [searchSingle retain];
    }
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[self separateString:_searchSingle.img]]];
    self.titleLable.text = _searchSingle.title;
    
    self.mallLable.text = [NSString stringWithFormat:@"来源商城:%@", _searchSingle.mall];
    
    
    NSMutableAttributedString *str = [[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"最低价格:%@", _searchSingle.price]] autorelease];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5,[_searchSingle.price length])];

    self.priceLable.attributedText = str;
    
    
    
    
}

- (NSString *)separateString:(NSString *)str
{
    return  [str componentsSeparatedByString:@"'"][1];
}

- (void)dealloc
{
    self.imgView = nil;
    self.titleLable = nil;
    self.priceLable = nil;
    self.mallLable = nil;
    self.searchSingle = nil;
    [super dealloc];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
