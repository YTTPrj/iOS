//
//  MyCustomView.h
//  InhibitSnore
//
//  Created by FZY on 15/1/16.
//  Copyright (c) 2015年 FZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCustomView : UIView

- (id)initWithFrame:(CGRect)frame height:(NSInteger)height title:(NSString *)title;

@property (nonatomic ,copy) UIButton * doneButton;
@property (nonatomic, copy) UIButton * cancelButton;


@end
