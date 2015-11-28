//
//  SearchListHeaderView.m
//  Class2509
//
//  Created by laouhn on 15/7/13.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#define kWIDTH ([UIScreen mainScreen].bounds.size.width - 240) / 4

#import "SearchListHeaderView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIViewAdditions.h"

@implementation SearchListHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        //加边框
//        CGRect frameRect = CGRectMake(5, 0, self.window.frame.size.width-5, 44);
//        self.frame = frameRect;
//        self.layer.borderWidth = .3;
//        self.layer.borderColor = [UIColor darkGrayColor].CGColor;
        
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSegment];
        
    }
    return self;
}

- (void)addSegment
{
    
    self.allBut = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.allBut setFrame:CGRectMake(kWIDTH, 10, 80, 30)];
    [self.allBut setTitle:@"综合" forState:UIControlStateNormal];
    self.allBut.layer.cornerRadius = 10.0;
    [self.allBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.allBut.titleLabel.font = [UIFont systemFontOfSize:17];
    
    self.priceBut = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.priceBut setFrame:CGRectMake(self.allBut.right + kWIDTH, 10, 80, 30)];
    [self.priceBut setTitle:@"价格" forState:UIControlStateNormal];
    self.priceBut.layer.cornerRadius = 10.0;
    [self.priceBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.priceBut.titleLabel.font = [UIFont systemFontOfSize:17];
    
    
    self.scoreBut = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.scoreBut setFrame:CGRectMake(self.priceBut.right + kWIDTH, 10, 80, 30)];
    [self.scoreBut setTitle:@"评分" forState:UIControlStateNormal];
    self.scoreBut.layer.cornerRadius = 10;
    [self.scoreBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.scoreBut.titleLabel.font = [UIFont systemFontOfSize:17];
    
    
    
    self.allBut.tag = 100;
    self.scoreBut.tag = 101;
    [self addSubview:self.allBut];
    [self addSubview:self.priceBut];
    [self addSubview:self.scoreBut];
}

- (void)dealloc
{
    self.allBut = nil;
    self.priceBut = nil;
    self.scoreBut = nil;
    [super dealloc];
}

@end
