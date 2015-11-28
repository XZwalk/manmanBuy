//
//  SearchListTableViewCell.m
//  Class2509
//
//  Created by 张祥 on 15/7/11.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "SearchListTableViewCell.h"
#import "UIViewAdditions.h"


@interface SearchListTableViewCell ()

@property (nonatomic, retain) UIImageView *img;

@end


@implementation SearchListTableViewCell

- (void)dealloc
{
    self.nameLabel = nil;
    self.img = nil;
    [super dealloc];
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        
        self.img = [[UIImageView alloc] init];
        [self addSubview:self.img];
        [self.img release];
        [self.img setFrame:CGRectMake(10, 10, self.frame.size.height - 20, self.frame.size.height - 20)];
        
        
        self.img.image = [UIImage imageNamed:@"searchList"];
        
        
        CGRect rect = CGRectMake(self.img.right + 2, 7, self.frame.size.width - self.img.width, self.frame.size.height - 10);
        self.nameLabel = [[UILabel alloc] initWithFrame:rect];
        
        [self addSubview:self.nameLabel];
        
        
//        self.imgLabel.backgroundColor = [UIColor redColor];
//        self.nameLabel.backgroundColor = [UIColor purpleColor];
        
        [self.nameLabel release];
        
        
    }
    
    return self;
    
}







- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
