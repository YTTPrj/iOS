//
//  MyCustomView.m
//  InhibitSnore
//
//  Created by FZY on 15/1/16.
//  Copyright (c) 2015年 FZY. All rights reserved.
//

#import "MyCustomView.h"


#define HSCOLOR [UIColor colorWithRed:118.0/255 green:75.0/255 blue:80.0/255 alpha:1]

@implementation MyCustomView{
    UIImageView * backgroundImageView;
    UIImageView * partImageView;
    UILabel * titleLabel;
    UIImageView * topLine;
    UIImageView * bottomLine;
    UIImageView * midLine;
}

- (id)initWithFrame:(CGRect)frame height:(NSInteger)height title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customViewHeight:height title:title];
        
    }
    return self;
}

- (void)customViewHeight:(NSInteger)height title:(NSString *)title
{
    backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    backgroundImageView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.62];
    
    backgroundImageView.userInteractionEnabled = YES;
    
    partImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2-120, SCREENHEIGHT/2-height/2, 240, height)];
    partImageView.image = [UIImage imageNamed:@"弹窗背景"];
    partImageView.userInteractionEnabled = YES;
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 7, 200, 21)];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = HSCOLOR;
    
    topLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 34, 240, 1.3)];
    topLine.backgroundColor = HSCOLOR;
    
    bottomLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, height-35, 240, 1)];
    bottomLine.backgroundColor = [UIColor lightGrayColor];
    
    midLine = [[UIImageView alloc] initWithFrame:CGRectMake(121, height-35, 1, 35)];
    midLine.backgroundColor = [UIColor lightGrayColor];
    
    _doneButton = [[UIButton alloc] initWithFrame:CGRectMake(121, height-35, 119, 35)];
    [_doneButton setTitle:@"确认" forState:UIControlStateNormal];
    _doneButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_doneButton setTitleColor:HSCOLOR forState:UIControlStateHighlighted];
    
    _cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, height-35, 122, 35)];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_cancelButton setTitleColor:HSCOLOR forState:UIControlStateHighlighted];
    
    [partImageView addSubview:titleLabel];
    [partImageView addSubview:topLine];
    [partImageView addSubview:bottomLine];
    [partImageView addSubview:midLine];
    [partImageView addSubview:_doneButton];
    [partImageView addSubview:_cancelButton];
    
    [backgroundImageView addSubview:partImageView];
    [self addSubview:backgroundImageView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
