//
//  FirstSearchViewController.m
//  InhibitSnore
//
//  Created by FZY on 15/1/15.
//  Copyright (c) 2015年 FZY. All rights reserved.
//

#import "FirstSearchViewController.h"
#import "SearchViewController.h"
#import "SearchFailedViewController.h"

@interface FirstSearchViewController (){
    double angle;
    int i;
    NSTimer * timer;
}

@end

@implementation FirstSearchViewController
//
//- (void)viewWillAppear:(BOOL)animated
//{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goFirst) name:@"GOFIRSST" object:nil];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self startAnimation];
//    [self performSelector:@selector(nextPage) withObject:nil afterDelay:3];

//    [self nextPage];
}



- (void)viewDidAppear:(BOOL)animated
{
    [self performSelector:@selector(nextPage) withObject:nil afterDelay:3];
}

- (void)startAnimation
{
    [[BluetoothFramework Singleton]scanForPer];
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(-angle * (M_PI / 180.0f));
    [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        _circleImageView.transform = endAngle;
    } completion:^(BOOL finished) {
        angle += 2;
        [self startAnimation];
    }];
    }

- (void)nextPage
{
//    if () {
//        [self presentViewController:[[SearchViewController alloc] init] animated:NO completion:nil];
//    } else {
//        [self presentViewController:<#(UIViewController *)#> animated:<#(BOOL)#> completion:<#^(void)completion#>];
//    }
    [self.navigationController pushViewController:[[SearchFailedViewController alloc] init] animated:YES];
    [[BluetoothFramework Singleton]stopScanForPer];
}

//- (void)viewDidDisappear:(BOOL)animated
//{
//
//}

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
