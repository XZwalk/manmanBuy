//
//  WebView.m
//  Class2509
//
//  Created by laouhn on 15/7/10.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "MyWebView.h"
#import "UIViewAdditions.h"

#define kWIDTH  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kINTERVAL  45
@interface MyWebView ()

@end
@implementation MyWebView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllViews];
    }
    return self;
}


- (void)addAllViews
{
    self.webView  = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self addSubview:self.webView];
    [self.webView release];
    
    self.webView.backgroundColor = [UIColor whiteColor];
    
    UIToolbar *tool = [[[UIToolbar alloc] initWithFrame:CGRectMake(0, kHeight - 50, kWIDTH, 50)] autorelease];
    
    [self addSubview:tool];
    
    [tool release];
    tool.backgroundColor = [UIColor orangeColor];
    
    
    self.webView.scalesPageToFit = YES;
    
    
    self.but1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.but2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.but3 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.but4 = [UIButton buttonWithType:UIButtonTypeCustom];

    
    self.but1.frame = CGRectMake(kINTERVAL, 10, (kWIDTH - 5 * kINTERVAL) / 4, tool.height - 25);
    self.but2.frame = CGRectMake(self.but1.right + kINTERVAL, 10, (kWIDTH - 5 * kINTERVAL) / 4, tool.height - 25);
    
    self.but3.frame = CGRectMake(self.but2.right + kINTERVAL, 10, (kWIDTH - 5 * kINTERVAL) / 4, tool.height - 25);
    self.but4.frame = CGRectMake(self.but3.right + kINTERVAL, 10, (kWIDTH - 5 * kINTERVAL) / 4, tool.height - 25);
    
    self.but1.tag = 1000;
    self.but2.tag = 1001;
    self.but3.tag = 1002;
    self.but4.tag = 1003;

    [tool addSubview:self.but1];
    [tool addSubview:self.but2];
    [tool addSubview:self.but3];
    [tool addSubview:self.but4];

    
    
//    self.but1.backgroundColor = [UIColor blueColor];
//    self.but2.backgroundColor = [UIColor purpleColor];
//    self.but3.backgroundColor = [UIColor orangeColor];
//    self.but4.backgroundColor = [UIColor redColor];
 
    
    
    
    [self.but1 setBackgroundImage:[UIImage imageNamed:@"wap_back_btn_enable"] forState:UIControlStateNormal];
    [self.but2 setBackgroundImage:[UIImage imageNamed:@"wap_forward_btn_enable"] forState:UIControlStateNormal];
    [self.but3 setBackgroundImage:[UIImage imageNamed:@"wap_refresh_btn"] forState:UIControlStateNormal];
    [self.but4 setBackgroundImage:[UIImage imageNamed:@"wapStop"] forState:UIControlStateNormal];

    self.but1.showsTouchWhenHighlighted = YES;
    self.but2.showsTouchWhenHighlighted = YES;
    self.but3.showsTouchWhenHighlighted = YES;
    self.but4.showsTouchWhenHighlighted = YES;


    
    
    
    
    
}



- (void)dealloc
{
    self.webView = nil;
    self.but1 = nil;
    self.but2 = nil;
    self.but3 = nil;
    self.but4 = nil;
    [super dealloc];
}

@end
