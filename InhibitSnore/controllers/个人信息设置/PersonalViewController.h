//
//  PersonalViewController.h
//  InhibitSnore
//
//  Created by FZY on 15/1/13.
//  Copyright (c) 2015年 FZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelLabel;
@property (weak, nonatomic) IBOutlet UIButton *doneLabel;
@property (weak, nonatomic) IBOutlet UITableView *detailTableView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *sexButton;
@property (weak, nonatomic) IBOutlet UIImageView *manImageView;
@property (weak, nonatomic) IBOutlet UIImageView *womanImageView;
@property (weak, nonatomic) IBOutlet UIImageView *cameraImageView;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property BOOL isMan;
@property (copy, nonatomic) NSString * ageStr;
@property (copy, nonatomic) NSString * heightStr;
@property (copy, nonatomic) NSString * weightStr;


@end
