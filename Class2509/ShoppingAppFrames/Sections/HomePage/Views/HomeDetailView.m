//
//  HomeDetailView.m
//  Class2509
//
//  Created by laouhn on 15/7/9.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "HomeDetailView.h"
#define kSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface HomeDetailView ()

@property (nonatomic, retain) UILabel *titleLabel;

@property (nonatomic, retain) UILabel *subTitleLabel;

@property (nonatomic, retain) UILabel *authorLabel;


@end
@implementation HomeDetailView

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
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 10, kSCREEN_WIDTH, 30)];
    self.subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, self.titleLabel.frame.size.height + 15, kSCREEN_WIDTH, 10)];
    self.authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, self.subTitleLabel.frame.origin.y + 15, kSCREEN_WIDTH, 10)];

    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(5, self.authorLabel.frame.origin.y + 30, kSCREEN_WIDTH - 10,[UIScreen mainScreen].bounds.size.height - 100)];
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.subTitleLabel];
    [self addSubview:self.authorLabel];
    [self addSubview:self.webView];


    [self.webView sizeToFit];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.subTitleLabel.font = [UIFont systemFontOfSize:10];
    self.subTitleLabel.textColor = [UIColor orangeColor];
    self.authorLabel.font = [UIFont systemFontOfSize:8];
    [self.webView sizeToFit];
    [self.webView release];
    [self.titleLabel release];
    [self.subTitleLabel release];
    [self.authorLabel release];

}
- (void)setDetailConten:(DetailCommodity *)detailConten
{
    if (_detailConten != detailConten) {
        [_detailConten release];
        _detailConten = [detailConten retain];
    }
    self.titleLabel.text = _detailConten.title;
    self.subTitleLabel.text = _detailConten.subTitle;
    self.authorLabel.text = [NSString stringWithFormat:@"%@ | %@ | %@", _detailConten.author, _detailConten.mall, _detailConten.addtime];
    [self.webView loadHTMLString:_detailConten.content baseURL:nil];
    
}

- (void)dealloc
{
    self.titleLabel = nil;
    self.subTitleLabel = nil;
    self.authorLabel = nil;
    self.tableView = nil;
    self.detailConten = nil;
    self.webView = nil;
    [super dealloc];
}

@end
