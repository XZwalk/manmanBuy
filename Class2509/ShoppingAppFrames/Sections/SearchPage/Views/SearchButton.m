//
//  SearchButton.m
//  Class2509
//
//  Created by 张祥 on 15/7/10.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "SearchButton.h"
#import "UIViewAdditions.h"

@interface SearchButton ()



@property (nonatomic, retain) UIImageView *imgView;

@property (nonatomic, retain) UILabel *title;


@end

@implementation SearchButton


- (void)dealloc
{
    self.list = nil;
    self.imgView = nil;
    self.title = nil;
    [super dealloc];
}




- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        
        
        CGRect imgRect = CGRectMake(10, 0, self.frame.size.width - 20, self.frame.size.width - 20);
        self.imgView = [[[UIImageView alloc] initWithFrame:imgRect] autorelease];
        
        
        self.title = [[[UILabel alloc] initWithFrame:CGRectMake(0, self.imgView.bottom, self.frame.size.width, self.frame.size.height - self.imgView.bottom - 10)] autorelease];
        self.title.textAlignment = NSTextAlignmentCenter;
        
        self.title.textColor = [UIColor orangeColor];
        self.title.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.imgView];
        [self addSubview:self.title];
        
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        
        
    }
    
    return self;
    
}


- (void)setList:(SearchList *)list
{
    if (_list != list)
    {
        [_list release];
        _list = [list retain];
        
    }
    self.imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", _list.listID]];
    
    
    self.title.text = _list.listName;
    
    
}








@end
