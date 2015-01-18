//
//  UpdataViewController.m
//  InhibitSnore
//
//  Created by FZY on 15/1/15.
//  Copyright (c) 2015年 FZY. All rights reserved.
//

#import "UpdataViewController.h"

@interface UpdataViewController ()

@end

@implementation UpdataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_updataButton setImage:[UIImage imageNamed:@"马上升级按钮点击效果"] forState:UIControlStateHighlighted];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)lastPage:(UIButton *)sender {
   [self.navigationController popViewControllerAnimated:YES];
}

//更新
- (IBAction)updata:(UIButton *)sender {
    
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
