//
//  NMainViewController.h
//  InhibitSnore
//
//  Created by FZY on 15/1/15.
//  Copyright (c) 2015年 FZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NMainViewController : UINavigationController<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property (copy, nonatomic) UIButton *menuButton;
@property (copy, nonatomic) UIImageView *menuImageView;
@property (copy, nonatomic) UIButton *dateButton;
@property (copy, nonatomic) UIImageView *dateImageView;
@property (copy, nonatomic) UILabel *batteryLabel;
@property (copy, nonatomic) UIButton *shareButton;
@property (copy, nonatomic) UIImageView *shareImageView;
@property (copy, nonatomic) UILabel *dateDetailLabel;
@property (copy, nonatomic) UIImageView *trendImageView;
@property (copy, nonatomic) UITableView *detailTableView;
@property (copy, nonatomic) UIButton *lastButton;
@property (copy, nonatomic) UIImageView *lastImageView;
@property (copy, nonatomic) UIButton *nextButton;
@property (copy, nonatomic) UIImageView *nextImageView;
@property (copy, nonatomic) UIButton *reloadButton;

@property (copy, nonatomic) UIImageView *partImageView;
@property (copy, nonatomic) UIImageView *connectStateImageView;

@end
