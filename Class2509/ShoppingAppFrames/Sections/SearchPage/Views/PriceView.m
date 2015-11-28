//
//  PriceView.m
//  Class2509
//
//  Created by 张祥 on 15/7/15.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "PriceView.h"
#import "UIViewAdditions.h"

@interface PriceView ()





@end

@implementation PriceView


- (void)dealloc
{
    self.chooseBut = nil;
    self.minField = nil;
    self.maxField = nil;
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        
        self.minField = [[UITextField alloc] initWithFrame:CGRectMake(20, 30, ([UIScreen mainScreen].bounds.size.width - 70) / 2, 30)];
        self.maxField = [[UITextField alloc] initWithFrame:CGRectMake(self.minField.right + 30, 30, ([UIScreen mainScreen].bounds.size.width - 70) / 2, 30)];
        
        self.minField.borderStyle = UITextBorderStyleRoundedRect;
        self.maxField.borderStyle = UITextBorderStyleRoundedRect;

        self.minField.placeholder = @"请输入最低价格";
        self.maxField.placeholder = @"请输入最高价格";
        self.minField.font = [UIFont systemFontOfSize:14];
        self.maxField.font = [UIFont systemFontOfSize:14];

        
        
        self.chooseBut = [UIButton buttonWithType:UIButtonTypeCustom];
        self.chooseBut.frame = CGRectMake(10, self.maxField.bottom + 30, [UIScreen mainScreen].bounds.size.width - 20, 30);
        self.chooseBut.backgroundColor = [UIColor orangeColor];
        [self.chooseBut setTitle:@"确认筛选" forState:UIControlStateNormal];
        

        
//        
//        _minField.translatesAutoresizingMaskIntoConstraints = NO;
//        _maxField.translatesAutoresizingMaskIntoConstraints = NO;
//        
//        
//        
//        NSDictionary *viewsDict = NSDictionaryOfVariableBindings(self, _minField, _maxField, _chooseBut);
//
//        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[_minField(==_maxField)]-30-[_maxField]-20-|" options:0 metrics:0 views:viewsDict]];
//        
//        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[_minField(==_maxField)]-30-[_chooseBut]" options:0 metrics:0 views:viewsDict]];
//        
        
        
        [self addSubview:self.chooseBut];
        [self addSubview:self.minField];
        [self addSubview:self.maxField];
        
        [self.minField release];
        [self.maxField release];
        
    }
    return self;
}






@end
