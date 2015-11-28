//
//  SearchList.h
//  Class2509
//
//  Created by 张祥 on 15/7/9.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchDetail.h"
@interface SearchList : NSObject

@property (nonatomic, copy) NSString *listID;
@property (nonatomic, copy) NSString *listName;
@property (nonatomic, copy) NSArray *detailList;





- (id)initWithListDIc:(NSDictionary *)dic;



@end
