//
//  SearchHeadView.m
//  Class2509
//
//  Created by 张祥 on 15/7/9.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "SearchHeadView.h"
#import "UIViewAdditions.h"





@interface SearchHeadView ()

@property (nonatomic, retain) UILabel *titleLabel;



@end


@implementation SearchHeadView

- (void)dealloc
{
    self.button1 = nil;
    self.button2 = nil;
    self.button4 = nil;
    self.button3 = nil;
    self.titleLabel = nil;
    [super dealloc];
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        CGRect rect1 = CGRectMake(0, 0.5, [UIScreen mainScreen].bounds.size.width / 4 - 0.5, 109);
        self.button1 = [[SearchButton alloc] initWithFrame:rect1];
        
        CGRect rect2 = CGRectMake(self.button1.right + 0.5, 0.5, [UIScreen mainScreen].bounds.size.width / 4 - 0.5, 109);
        self.button2 = [[SearchButton alloc] initWithFrame:rect2];
        
        CGRect rect3 = CGRectMake(self.button2.right + 0.5, 0.5, [UIScreen mainScreen].bounds.size.width / 4 - 0.5, 109);
        self.button3 = [[SearchButton alloc] initWithFrame:rect3];
        
        
         CGRect rect4 = CGRectMake(self.button3.right + 0.5, 0.5, [UIScreen mainScreen].bounds.size.width / 4, 109);
        self.button4 = [[SearchButton alloc] initWithFrame:rect4];
       

        [self addSubview:self.button1];
        [self addSubview:self.button2];
        [self addSubview:self.button3];
        [self addSubview:self.button4];
        
        [self.button1 release];
        [self.button2 release];
        [self.button3 release];
        [self.button4 release];
        
        
        
        self.backgroundColor = [UIColor darkGrayColor];
        
    }
    return self;
}






@end
