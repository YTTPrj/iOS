//
//  ShareView.m
//  InhibitSnore
//
//  Created by FZY on 15/1/17.
//  Copyright (c) 2015年 FZY. All rights reserved.
//

#import "ShareView.h"

#define HSCOLOR [UIColor colorWithRed:118.0/255 green:75.0/255 blue:80.0/255 alpha:1]

@implementation ShareView{
    UIImageView * partImageView;
    UILabel * shareLabel;
    UILabel * weiXinLabel;
    UILabel * weiXinFCLabel;
    UILabel * QQLabel;
    UIImageView * xImageView;
    UIImageView * lineImageView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView
{
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.62];
    
    partImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2-120, SCREENHEIGHT/2-75, 240,150)];
    partImageView.image = [UIImage imageNamed:@"弹窗背景"];
    partImageView.userInteractionEnabled = YES;
    
    shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 12, 202, 21)];
    shareLabel.textColor = HSCOLOR;
    shareLabel.font = [UIFont systemFontOfSize:15];
    shareLabel.textAlignment = NSTextAlignmentCenter;
    shareLabel.text = @"分享到";
    
    xImageView = [[UIImageView alloc] initWithFrame:CGRectMake(215, 8, 13, 13)];
    xImageView.image = [UIImage imageNamed:@"关闭图标"];
    _xButton = [[UIButton alloc] initWithFrame:CGRectMake(190, 0, 50, 40)];
    _xButton.backgroundColor = [UIColor clearColor];
    
    lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 39, 210, 2)];
    lineImageView.backgroundColor = HSCOLOR;
    
    weiXinLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 116, 68, 21)];
    weiXinLabel.text = @"微信好友";
    weiXinLabel.font = [UIFont systemFontOfSize:13];
    weiXinLabel.textAlignment = NSTextAlignmentCenter;
    weiXinLabel.textColor = [UIColor lightGrayColor];
    
    weiXinFCLabel = [[UILabel alloc] initWithFrame:CGRectMake(81, 116, 68, 21)];
    weiXinFCLabel.text = @"微信朋友圈";
    weiXinFCLabel.font = [UIFont systemFontOfSize:13];
    weiXinFCLabel.textAlignment = NSTextAlignmentCenter;
    weiXinFCLabel.textColor = [UIColor lightGrayColor];
    
    QQLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 116, 68, 21)];
    QQLabel.text = @"QQ好友";
    QQLabel.font = [UIFont systemFontOfSize:13];
    QQLabel.textAlignment = NSTextAlignmentCenter;
    QQLabel.textColor = [UIColor lightGrayColor];
    
    _weiXinButton = [[UIButton alloc] initWithFrame:CGRectMake(18, 64, 45, 45)];
    [_weiXinButton setImage:[UIImage imageNamed:@"微信好友"] forState:UIControlStateNormal];
    
    _weiXinFriendCirCleButton = [[UIButton alloc] initWithFrame:CGRectMake(93, 64, 45, 45)];
    [_weiXinFriendCirCleButton setImage:[UIImage imageNamed:@"微信朋友圈图标"] forState:UIControlStateNormal];
    
    _QQButton = [[UIButton alloc] initWithFrame:CGRectMake(172, 64, 45, 45)];
    [_QQButton setImage:[UIImage imageNamed:@"QQ好友"] forState:UIControlStateNormal];
    
//    UIImageView * partImageView;
//    UILabel * shareLabel;
//    UILabel * weiXinLabel;
//    UILabel * weiXinFCLabel;
//    UILabel * QQLabel;
//    UIImageView * xImageView;
//    UIImageView * lineImageView;
    [partImageView addSubview:shareLabel];
    [partImageView addSubview:lineImageView];
    [partImageView addSubview:xImageView];
    [partImageView addSubview:_xButton];
    [partImageView addSubview:weiXinLabel];
    [partImageView addSubview:_weiXinButton];
    [partImageView addSubview:weiXinFCLabel];
    [partImageView addSubview:_weiXinFriendCirCleButton];
    [partImageView addSubview:QQLabel];
    [partImageView addSubview:_QQButton];
    
    [self addSubview:partImageView];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
