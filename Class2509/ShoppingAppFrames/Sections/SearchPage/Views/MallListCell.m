//
//  MallListCell.m
//  Class2509
//
//  Created by 张祥 on 15/7/16.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "MallListCell.h"
#import "UIViewAdditions.h"

#define kHEIGHT self.frame.size.height
#define kWIDTH  self.frame.size.width

@interface MallListCell ()

@property (nonatomic, retain) UIImageView *imgView;


@property (nonatomic, retain) UILabel *mallLabel, *sellLabel, *priceLabel;



@end


@implementation MallListCell

- (void)dealloc
{
    self.imgView = nil;
    self.mallLabel = nil;
    self.sellLabel = nil;
    self.priceLabel = nil;
    self.mallList = nil;
    [super dealloc];
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (kHEIGHT - 16) / 2, 16, 16)];
        self.mallLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.imgView.right + 4, 0, 70, kHEIGHT)];
        self.sellLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.mallLabel.right + 5, 0, (kWIDTH - 16) / 3 + 10, kHEIGHT)];
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.sellLabel.right, 0, (kWIDTH - 16) / 3, kHEIGHT - 4)];
        
        self.mallLabel.font = [UIFont systemFontOfSize:14];
        self.sellLabel.font = [UIFont systemFontOfSize:14];
        self.priceLabel.font = [UIFont systemFontOfSize:14];
        
        
        self.mallLabel.textColor = [UIColor darkGrayColor];
        self.sellLabel.textColor = [UIColor darkGrayColor];
        self.priceLabel.textColor = [UIColor darkGrayColor];

        
        
        
        self.sellLabel.lineBreakMode = NSLineBreakByClipping;
        
        
        
        [self addSubview:self.imgView];
        [self addSubview:self.mallLabel];
        [self addSubview:self.sellLabel];
        [self addSubview:self.priceLabel];
        
        [self.imgView release];
        [self.mallLabel release];
        [self.sellLabel release];
        [self.priceLabel release];

        
//        
//        self.imgView.backgroundColor = [UIColor redColor];
//        self.mallLabel.backgroundColor = [UIColor blueColor];
//        self.sellLabel.backgroundColor = [UIColor redColor];
//        self.priceLabel.backgroundColor = [UIColor purpleColor];
        
        
        
    }
    
    return self;
    
}

- (void)setMallList:(MallList *)mallList
{
    if (_mallList != mallList) {
        
        [_mallList release];
        
        _mallList = [mallList retain];
        
    }
    
    NSString *str = _mallList.mall_img;
    
    NSURLRequest *request = [NSURLRequest  requestWithURL:[NSURL URLWithString:str]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        
        self.imgView.image = [UIImage imageWithData:data];
        
    }];
    
    
    self.mallLabel.text = _mallList.mall_name;
    
    if ([_mallList.mall_sales isEqualToString:@"0"]) {
        self.sellLabel.text = @"";
    }else{
        
        self.sellLabel.text = [NSString stringWithFormat:@"月销量%@件", _mallList.mall_sales];

    }
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@", _mallList.mall_price];
    
    
}







@end
