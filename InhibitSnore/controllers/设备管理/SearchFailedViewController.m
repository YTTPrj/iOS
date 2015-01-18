//
//  SearchFailedViewController.m
//  InhibitSnore
//
//  Created by FZY on 15/1/16.
//  Copyright (c) 2015年 FZY. All rights reserved.
//

#import "SearchFailedViewController.h"
#import "FirstSearchViewController.h"
#import "SearchViewController.h"
#import "ManageViewController.h"

@interface SearchFailedViewController ()

@end

@implementation SearchFailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_reSearchButton setImage:[UIImage imageNamed:@"未发现设备_重新搜索点击效果"] forState:UIControlStateHighlighted];
    
}


//重搜
- (IBAction)reSearch:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//先不绑定了
- (IBAction)cancel:(UIButton *)sender {

//    [self.navigationController popToViewController:[[SearchViewController alloc]init]  animated:YES];
    [self.navigationController pushViewController:[[SearchViewController alloc]init] animated:YES];
//    [self.navigationController popToViewController:[[ManageViewController alloc]init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
