//
//  HeadViewController.h
//  InhibitSnore
//
//  Created by FZY on 15/1/13.
//  Copyright (c) 2015年 FZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeadViewControllerDelegate <NSObject>

@optional
- (void)cutViewController:(NSInteger)number;

@optional
- (void)correctMainViewController;

@end

@interface HeadViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, copy) UIImageView * headImageView;
@property (nonatomic, copy) UILabel * nameLabel;
@property (nonatomic, copy) UITableView * menuTableView;
@property (nonatomic, copy) UIImageView * menuBackgroundImageView;
@property (nonatomic, copy) UIImageView * outerImageView;
@property (nonatomic, copy) UIButton * headButton;


@property (nonatomic, copy) UIScrollView * scrollView;

@property id<HeadViewControllerDelegate>headDelegate;

@end