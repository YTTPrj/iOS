//
//  ManageViewController.h
//  InhibitSnore
//
//  Created by FZY on 15/1/15.
//  Copyright (c) 2015年 FZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManageViewController : UIViewController<UIAlertViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *bindingStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceName;

@end
