//
//  MyDataViewController.h
//  InhibitSnore
//
//  Created by FZY on 15/1/15.
//  Copyright (c) 2015年 FZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyDataViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (copy, nonatomic) NSString * userName;
@property (copy, nonatomic) NSString * sex;
@property (copy, nonatomic) NSString * ageStr;
@property (copy, nonatomic) NSString * heightStr;
@property (copy, nonatomic) NSString * weightStr;

@end
