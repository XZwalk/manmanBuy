//
//  NetworkHelper.m
//  TuDou_QiuBai
//
//  Created by 张祥 on 15/6/26.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "NetworkHelper.h"
#import "UIWindow+YzdHUD.h"


@interface NetworkHelper ()<NSURLConnectionDataDelegate, NSURLConnectionDelegate>


//此私有属性, 用于保存从服务器获取到的数据
@property (nonatomic, retain)NSMutableData *data;

@property (nonatomic, retain) NSURLConnection *connection;



@end


@implementation NetworkHelper

- (void)dealloc
{
    self.data = nil;
    
    self.delegate = nil;
    
    [super dealloc];
}



- (void)getDataWithUrlString:(NSString *)urlString
{
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.connection = [NSURLConnection  connectionWithRequest:request delegate:self];

    [self.connection start];
    
    //开启系统状态栏小菊花
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [[(UIViewController *)self.delegate view].window showHUDWithText:@"加载中" Type:ShowLoading Enabled:YES];
    
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
        
    
    [self.data appendData:data];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{

    [[(UIViewController *)self.delegate view].window showHUDWithText:nil Type:ShowDismiss Enabled:YES];

    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

    if (_delegate && [_delegate respondsToSelector:@selector(networkDataIsSuccessful:)]) {
        [_delegate networkDataIsSuccessful:self.data];
    }
    
    
    
}

//当一个网络连接请求错误后, 执行此方法
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    [[(UIViewController *)self.delegate view].window showHUDWithText:@"加载失败" Type:ShowPhotoNo Enabled:YES];

    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

    //如果代理存在, 而且能响应方法
    if (_delegate && [_delegate respondsToSelector:@selector(networkDataIsFail:)])
    {
        [_delegate networkDataIsFail:error];
    }
}

- (NSMutableData *)data
{
    if (!_data)
    {
        self.data = [NSMutableData data];
    }
    return [[_data retain] autorelease];
}


- (void)connectionCancel
{
    [self.connection cancel];
    
}


@end
