//
//  FirstSearchViewController.h
//  InhibitSnore
//
//  Created by FZY on 15/1/15.
//  Copyright (c) 2015年 FZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstSearchViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *circleImageView;
@property (weak, nonatomic) IBOutlet UIImageView *deviceImageView;

@property (copy, nonatomic) UIImageView * searchFailedImageView;

@end
