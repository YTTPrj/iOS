//
//  MainViewController.h
//  InhibitSnore
//
//  Created by FZY on 15/1/14.
//  Copyright (c) 2015年 FZY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadViewController.h"

@interface MainViewController : UIViewController<HeadViewControllerDelegate,UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;
@property (weak, nonatomic) IBOutlet UILabel *batteryLabel;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UILabel *dateDetailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *trendImageView;
@property (weak, nonatomic) IBOutlet UITableView *detailTableView;
@property (weak, nonatomic) IBOutlet UIButton *lastButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *reloadButton;

@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UIButton *deviceButton;
@property (weak, nonatomic) IBOutlet UIButton *connectStateButton;

@property (weak, nonatomic) IBOutlet UIImageView *swipeImageView;


@end
