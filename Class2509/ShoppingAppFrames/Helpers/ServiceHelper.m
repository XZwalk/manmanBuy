


//
//  NetworkHelper.m
//  Class2509
//
//  Created by laouhn on 15/7/9.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "ServiceHelper.h"
#import "CommodityCell.h"
#import "UIWindow+YzdHUD.h"
@interface ServiceHelper ()
@property (nonatomic, retain) NSMutableData *data;
@property (nonatomic, retain) NSURLConnection *connection;
@end

@implementation ServiceHelper

#pragma mark - 异步get
- (void)downloadDataWithUrlString:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.connection =  [NSURLConnection connectionWithRequest:request delegate:self];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    //[[(UIViewController *)self.delegate view].window showHUDWithText:@"加载中" Type:ShowLoading Enabled:YES];
    [self.connection start];
    
}




#pragma  mark - NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.data = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [[(UIViewController *)self.delegate view].window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(networkDataIsSuccessful:)]) {
        [_delegate networkDataIsSuccessful:self.data];
        }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //[[(UIViewController *)self.delegate view].window showHUDWithText:nil Type:ShowPhotoNo Enabled:YES];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(networkDataIsFail:)]) {
        [_delegate networkDataIsFail:error];
    }

}


- (void)connectionCancel
{
    [self.connection cancel];
    
}
#pragma mark - 


- (void)dealloc
{
    self.data = nil;
//    self.delegate = nil;
    [super dealloc];
}
@end
