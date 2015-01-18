//
//  ManageViewController.m
//  InhibitSnore
//
//  Created by FZY on 15/1/15.
//  Copyright (c) 2015年 FZY. All rights reserved.
//

#import "ManageViewController.h"
#import "SearchViewController.h"
#import "FirstSearchViewController.h"
#import "NMainViewController.h"
#import "WWSideslipViewController.h"

@interface ManageViewController (){
    UITextField * _tf;
}

@end

@implementation ManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (((NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"DEVICENAME"]).length>0) {
        self.deviceName.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"DEVICENAME"];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)nextPage:(UIButton *)sender {
    //是否绑定  判断在这里
    //已绑定的
    UIAlertView * alt = [[UIAlertView alloc] initWithTitle:@"解除绑定" message:@"如果你想重新连接到另一个设备，你首先需要解除当前设备的绑定" delegate:self cancelButtonTitle:@"不解除" otherButtonTitles:@"解除", nil];
    
    alt.alertViewStyle = UIAlertViewStylePlainTextInput;
    _tf = [alt textFieldAtIndex:0];
    _tf.delegate = self;
    _tf.textAlignment = NSTextAlignmentCenter;
    _tf.placeholder = @"您可以在此给设备重新命名";
    [alt show];
    
    
    //为绑定跳入搜索 FirstSearchViewController界面
//    [self.navigationController pushViewController:[[FirstSearchViewController alloc]init] animated:YES];
}

#pragma mark - textField代理
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length>0) {
        [[NSUserDefaults standardUserDefaults]setObject:textField.text forKey:@"DEVICENAME"];
    }
    
    if (((NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"DEVICENAME"]).length>0) {
        self.deviceName.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"DEVICENAME"];
    }
}

//解除绑定
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}


- (IBAction)lastPage:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
