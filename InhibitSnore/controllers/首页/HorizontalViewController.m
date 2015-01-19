//
//  HorizontalViewController.m
//  InhibitSnore
//
//  Created by FZY on 15/1/19.
//  Copyright (c) 2015年 FZY. All rights reserved.
//

#import "HorizontalViewController.h"

@interface HorizontalViewController ()

@end

@implementation HorizontalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.transform = CGAffineTransformMakeRotation(M_PI/2);
}








- (IBAction)lastPage:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES; //返回NO表示要显示，返回YES将hiden
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
