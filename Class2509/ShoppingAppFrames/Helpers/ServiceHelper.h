//
//  NetworkHelper.h
//  Class2509
//
//  Created by laouhn on 15/7/9.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetworkHelperDelegate <NSObject>

- (void)networkDataIsSuccessful:(id)obj;

- (void)networkDataIsFail:(NSError *)error;


@end


@interface ServiceHelper : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic, assign) id<NetworkHelperDelegate>delegate;


- (void)downloadDataWithUrlString:(NSString *)urlString;
- (void)connectionCancel;

@end
