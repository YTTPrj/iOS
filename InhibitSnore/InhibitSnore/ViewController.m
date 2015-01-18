//
//  ViewController.m
//  InhibitSnore
//
//  Created by FZY on 15/1/13.
//  Copyright (c) 2015年 FZY. All rights reserved.
//

#import "ViewController.h"
#import "PersonalViewController.h"
#import "HeadViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    self.navigationController.navigationBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self alterXIB];
    [self createAnimaton];
}


- (void)alterXIB
{
    [_goButton setImage:[UIImage imageNamed:@"按钮背景点击效果"] forState:UIControlStateHighlighted];
}

- (void)createAnimaton
{
    NSMutableArray * tmpArray = [[NSMutableArray alloc]init];
    for (int i=1; i<=7; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"0%d",i]];
        [tmpArray addObject:image];
    }
    _animationIV.animationDuration = 3;
    _animationIV.animationImages = tmpArray;
    _animationIV.animationRepeatCount = 0;
    [_animationIV startAnimating];
}

- (IBAction)goNextPage:(UIButton *)sender {
    PersonalViewController * pvc = [[PersonalViewController alloc] init];
    [self.view.superview setTransitionAnimationType:PSBTransitionAnimationTypeReveal toward:PSBTransitionAnimationTowardFromRight duration:0.5];
    [self.navigationController pushViewController:pvc animated:YES];
//    [self.navigationController presentViewController:pvc animated:YES completion:nil];
//    [self presentViewController:pvc animated:YES completion:nil];
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
