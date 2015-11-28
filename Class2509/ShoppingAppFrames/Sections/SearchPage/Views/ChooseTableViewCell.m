//
//  ChooseTableViewCell.m
//  Class2509
//
//  Created by 张祥 on 15/7/15.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "ChooseTableViewCell.h"

@implementation ChooseTableViewCell


- (void)dealloc
{
    self.label = nil;
    self.cat = nil;
    self.mall = nil;
    self.brend = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        
        
        
        self.label = [[UILabel alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:self.label];
        
        [self.label release];
        
        
    }
    
    
    return self;
    
}
@end
