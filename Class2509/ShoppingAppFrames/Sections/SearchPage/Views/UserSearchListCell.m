//
//  UserSearchListCell.m
//  Class2509
//
//  Created by 张祥 on 15/7/13.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "UserSearchListCell.h"
#import "UIViewAdditions.h"


@interface UserSearchListCell ()

@property (nonatomic, retain) UIImageView *imgView;


@property (nonatomic, retain) UILabel *iszyLabel;

@property (nonatomic, retain) UILabel *nameLabel;

@property (nonatomic, retain) UILabel *nameLabel1;


@property (nonatomic, retain) UILabel *priceLabel;

@property (nonatomic, retain) UILabel *mallLabel;

@property (nonatomic, retain) UILabel *sellLabel;




@end


@implementation UserSearchListCell


- (void)dealloc
{
    self.userSearch = nil;
    self.imgView = nil;
    self.iszyLabel = nil;
    self.nameLabel = nil;
    self.nameLabel1 = nil;
    self.priceLabel = nil;
    self.mallLabel = nil;
    self.sellLabel = nil;
    [super dealloc];
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 90, 90)];
        
        self.iszyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.imgView.right + 10, self.imgView.top- 4, 40, 15)];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.iszyLabel.right, self.imgView.top, [UIScreen mainScreen].bounds.size.width - self.iszyLabel.right - 4, 20)];
        
        self.nameLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(self.imgView.right + 10, self.nameLabel.bottom, [UIScreen mainScreen].bounds.size.width - self.imgView.right - 14, 20)];
        
        self.priceLabel = [[UILabel  alloc] initWithFrame:CGRectMake(self.imgView.right + 10, self.nameLabel1.bottom + 20, 110, 30)];
        
        self.mallLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.priceLabel.right, self.priceLabel.top, [UIScreen mainScreen].bounds.size.width - self.priceLabel.right - 10, 30)];
        
        
        self.sellLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.imgView.right + 10, self.priceLabel.bottom, 150, 15)];
        
        
        
        self.iszyLabel.font = [UIFont systemFontOfSize:12];
        self.iszyLabel.backgroundColor = [UIColor colorWithRed:0.864 green:1.000 blue:0.987 alpha:1.000];
        self.iszyLabel.textAlignment = NSTextAlignmentCenter;
        //显示label边框
        self.iszyLabel.layer.borderColor = [UIColor colorWithRed:0.534 green:0.827 blue:0.931 alpha:1.000].CGColor;
        self.iszyLabel.layer.borderWidth = .3;
        

        
        self.priceLabel.textColor = [UIColor redColor];
        
        self.mallLabel.textAlignment  = NSTextAlignmentRight;
        self.mallLabel.font = [UIFont systemFontOfSize:14];
        self.mallLabel.textColor = [UIColor darkGrayColor];
        
        
        
        
        self.nameLabel.font = [UIFont systemFontOfSize:12];
        self.nameLabel1.font = [UIFont systemFontOfSize:12];
        self.nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.nameLabel1.lineBreakMode = NSLineBreakByWordWrapping;

        
        
        [self addSubview:self.imgView];
        [self addSubview:self.iszyLabel];
        [self addSubview:self.nameLabel];
        [self addSubview:self.nameLabel1];
        [self addSubview:self.priceLabel];
        [self addSubview:self.mallLabel];
        [self addSubview:self.sellLabel];

        
        [self.imgView release];
        [self.iszyLabel release];
        [self.nameLabel release];
        [self.nameLabel1 release];
        [self.priceLabel release];
        [self.mallLabel release];
        [self.sellLabel release];
        
        
        
        
//        
//        self.imgView.backgroundColor = [UIColor redColor];
//        self.iszyLabel.backgroundColor = [UIColor blueColor];
//        self.nameLabel.backgroundColor = [UIColor purpleColor];
//        self.nameLabel1.backgroundColor = [UIColor grayColor];
//        self.mallLabel.backgroundColor = [UIColor redColor];
//        self.sellLabel.backgroundColor = [UIColor blueColor];
//        self.priceLabel.backgroundColor = [UIColor orangeColor];
        
        
    }
    
    return self;
    
}


- (CGFloat)returnLabelWidth:(UserSearchLIst *)userSearch
{
    
    
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:12]};
    
    CGRect rect = [_userSearch.iszy boundingRectWithSize:CGSizeMake(0, 20)
                                                 options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                              attributes:dic
                                                 context:nil];
    
    return rect.size.width;

    
}

- (void)setUserSearch:(UserSearchLIst *)userSearch
{
    if (_userSearch != userSearch) {
        [_userSearch release];
        _userSearch = [userSearch retain];
    }
    
    
    
    CGFloat width = [self returnLabelWidth:_userSearch];
    
    
    //这里根据得到的自适应宽度修改控件的宽度的时候一定不能直接把上面的代码全粘下来, 只更改宽度, 可不能再重新alloc, 重新alloc以后得到的是新的对象, 原来控件全部丢失
    self.iszyLabel.frame = CGRectMake(self.iszyLabel.left, self.iszyLabel.top, width, 20);
    self.nameLabel.frame = CGRectMake(self.iszyLabel.right, self.imgView.top - 5, [UIScreen mainScreen].bounds.size.width - self.iszyLabel.right - 4, 20);
    self.nameLabel1.frame = CGRectMake(self.imgView.right + 10, self.nameLabel.bottom, [UIScreen mainScreen].bounds.size.width - self.imgView.right - 14, 20);
    
    
    
    self.iszyLabel.text = _userSearch.iszy;
    self.mallLabel.text = _userSearch.mall;
    self.priceLabel.text = _userSearch.price;
    
    
    
    self.sellLabel.textColor = [UIColor darkGrayColor];

    //两种颜色字体的设置方法;.
    NSMutableAttributedString *str = [[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"月销量:%@件", _userSearch.sell]] autorelease];
    //改变颜色
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0,4)];
    //改变字号
    //[str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 4)];
    self.sellLabel.attributedText = str;

    self.sellLabel.font = [UIFont systemFontOfSize:14];
    
    
    NSString *titleStr = _userSearch.titleName;
    
    
    //根据label的宽度计算能放多少个字符, 然后进行字符串的截取
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:12]};
    CGRect rect = [titleStr boundingRectWithSize:CGSizeMake(0, self.nameLabel.height)
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:dic
                                         context:nil];
    
    
    NSInteger length = titleStr.length;

    //为防止第一行也出现半个字的情况, 将截取的字符串字数也减1
    NSInteger length1 = (int)self.nameLabel.width  / (rect.size.width / length) - 1;
    
    
    //这里不加判断当文字长度小于一行的时候程序崩溃
    if (length <= length1) {
        length1 = length;
        
        NSString *name1 = [titleStr substringToIndex:length1];
        self.nameLabel.text = name1;

    }else
    {
    
    NSString *name1 = [titleStr substringToIndex:length1];

    
    NSArray *ary1 = [titleStr componentsSeparatedByString:name1];
    
        
        
        
    CGRect rect1 = [ary1[1] boundingRectWithSize:CGSizeMake(0, self.nameLabel1.height)
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:dic
                                         context:nil];

    
    NSInteger length2 = (int)self.nameLabel1.width / (rect1.size.width / [ary1[1] length]);
    
    
    //这里开始的时候错误的把length1写成length, 浪费了很多时间
    //这里要进行判断, 不然当第二行标题进行计算的字数大于实际的字数则在截取字符串的时候会出现问题
    if (titleStr.length - length1 <= length2)
    {//当实际剩余字体的长度比理论计算的值小或者相等的时候就按实际的长度去取字符串
        length2 = titleStr.length - length1;
        
        NSString *name2 = [titleStr substringWithRange:NSMakeRange(length1, length2)];
        self.nameLabel1.text = name2;


    }else{//否则将理论计算的长度减1去取字符串, 是为了不出现半个字符
        NSString *name2 = [titleStr substringWithRange:NSMakeRange(length1, length2 - 1)];
        self.nameLabel1.text = name2;
        
    }
    
    self.nameLabel.text = name1;
    
    }
    
    
    //解析图片
    NSString *str1 = _userSearch.imageUrl;
    NSArray *ary = [str1 componentsSeparatedByString:@"'"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:ary[1]]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        
        self.imgView.image = [UIImage imageWithData:data];
        
    }];
    
    
}





@end
