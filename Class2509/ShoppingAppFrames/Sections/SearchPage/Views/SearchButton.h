//
//  SearchButton.h
//  Class2509
//
//  Created by 张祥 on 15/7/10.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchList.h"


@interface SearchButton : UIButton


@property (nonatomic, retain) SearchList *list;

@property (nonatomic, assign) int number;


@end
