//
//  HotSearchViewCell.m
//  Class2509
//
//  Created by 张祥 on 15/7/10.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "HotSearchViewCell.h"
#import "UIViewAdditions.h"

@interface HotSearchViewCell ()

@property (nonatomic, retain) UILabel *nameLabel;

@end

@implementation HotSearchViewCell

- (void)dealloc
{
    self.hot = nil;
    self.nameLabel = nil;
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        self.nameLabel = [[UILabel alloc] initWithFrame:rect];
        
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        
        //设置label的圆角
        self.nameLabel.layer.cornerRadius = 5;
        self.nameLabel.layer.borderColor = [UIColor grayColor].CGColor;
        self.nameLabel.layer.borderWidth = .3;
        
//        //设置label的阴影
//        self.nameLabel.layer.shadowColor = [UIColor blackColor].CGColor;
//        self.nameLabel.layer.shadowOpacity = 1.0;
//        self.nameLabel.layer.shadowRadius = 5.0;
//        self.nameLabel.layer.shadowOffset = CGSizeMake(0, 3);
//        self.nameLabel.clipsToBounds = NO;
//        
        
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        
        //在这里更改cell的背景色无用, 需要在cellForItemAtIndexPath:方法里更改cell的背景色
        //self.backgroundColor = [UIColor redColor];
        [self addSubview:self.nameLabel];
        [self.nameLabel release];

    }
    return self;
}


- (void)setHot:(HotSearch *)hot
{
    if (_hot != hot) {
        [_hot release];
        _hot = [hot retain];
    }
    
    self.nameLabel.text = _hot.searchName;
    
    CGFloat width = [HotSearchViewCell returnLabelHeight:hot];
    
    self.nameLabel.frame = CGRectMake(self.nameLabel.left, self.nameLabel.top, width + ([UIScreen mainScreen].bounds.size.width / 320) * 30, self.nameLabel.height);
    
}


+ (CGFloat)returnLabelHeight:(HotSearch *)hotSearch
{
    NSDictionary *dic= @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
    CGRect rect = [hotSearch.searchName boundingRectWithSize:CGSizeMake(0, 40)
                                                     options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:dic
                                                     context:nil];
    
    
    return rect.size.width;
    
}





+ (CGFloat)callWidth:(HotSearch *)hot
{
    
    return [self returnLabelHeight:hot];
    
}


















@end
