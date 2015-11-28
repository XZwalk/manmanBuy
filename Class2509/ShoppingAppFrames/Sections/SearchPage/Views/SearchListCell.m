//
//  SearchListCell.m
//  Class2509
//
//  Created by laouhn on 15/7/13.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#define KSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#import "SearchListCell.h"
#import "UIImageView+WebCache.h"
@interface SearchListCell ()
@property (nonatomic, retain)UIImageView *imgView;
@property (nonatomic, retain)UILabel *titleLable;
@property (nonatomic, retain)UILabel *priceLable;
@property (nonatomic, retain)UILabel *mallLable;
@end

@implementation SearchListCell

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
        self.imgView = [[[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 50 , 50)] autorelease];
    }
    return [[_imgView retain] autorelease];
}

- (UILabel *)titleLable
{
    if (_titleLable == nil) {
        self.titleLable = [[[UILabel alloc] initWithFrame:CGRectMake(70, 10, KSCREEN_WIDTH - 70, 40)] autorelease];
        self.titleLable.numberOfLines = 0;
        self.titleLable.font = [UIFont systemFontOfSize:13];
        self.titleLable.lineBreakMode = NSLineBreakByClipping;
        
    }
    return [[_titleLable retain] autorelease];
}

- (UILabel *)priceLable
{
    if (_priceLable == nil) {
        self.priceLable = [[[UILabel alloc] initWithFrame:CGRectMake(70, 50, 100, 20)] autorelease];
        self.priceLable.font = [UIFont systemFontOfSize:14];
        self.priceLable.textColor = [UIColor orangeColor];
    }
    return [[_priceLable retain] autorelease];
}

- (UILabel *)mallLable
{
    if (_mallLable == nil) {
        self.mallLable = [[[UILabel alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH - 60, 50, 80, 20)] autorelease];
        self.mallLable.font = [UIFont systemFontOfSize:13];
        self.mallLable.textColor = [UIColor darkGrayColor];
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
    self.priceLable.text = _searchSingle.price;
    self.mallLable.text = _searchSingle.mall;
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
