//
//  WWSideslipViewController.m
//  WWSideslipViewControllerSample
//
//  Created by 王维 on 14-8-26.
//  Copyright (c) 2014年 wangwei. All rights reserved.
//

#import "WWSideslipViewController.h"
#import "ManageViewController.h"
#import "MyDataViewController.h"
#import "SysSettingViewController.h"
#import "AboutViewController.h"
#import "MonitorViewController.h"
#import "HorizontalViewController.h"

@interface WWSideslipViewController ()

@end

@implementation WWSideslipViewController
@synthesize speedf,sideslipTapGes,pan;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    self.view.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(correctMainViewController) name:@"CORRECT" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLeft) name:@"SHOWLEFT" object:nil];
    [self notifacationManage];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)correctMainViewController
{
    [mainControl.view addGestureRecognizer:pan];
    [self showMainView];
}

- (void)showLeft
{
    leftControl.view.hidden = NO;
    [self showLeftView];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CORRECT" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SHOWLEFT" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(instancetype)initWithLeftView:(UIViewController *)LeftView
                    andMainView:(UIViewController *)MainView;
{
    if(self){
        speedf = 0.5;
        
        leftControl = LeftView;
        mainControl = MainView;
        
        //滑动手势
        pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        [mainControl.view addGestureRecognizer:pan];
        
        //单击手势
        sideslipTapGes= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handeTap:)];
        [sideslipTapGes setNumberOfTapsRequired:1];
        [mainControl.view addGestureRecognizer:sideslipTapGes];
        leftControl.view.hidden = YES;
        righControl.view.hidden = YES;
        [self.view addSubview:leftControl.view];
        [self.view addSubview:mainControl.view];
    }
    mainControl.view.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    return self;
}

#pragma mark - 滑动手势

//滑动手势
- (void) handlePan: (UIPanGestureRecognizer *)rec{
    CGPoint point = [rec translationInView:self.view];
    scalef = (point.x*speedf+scalef);
    leftControl.view.hidden = NO;
    //根据视图位置判断是左滑还是右边滑动
    if (rec.view.frame.origin.x>0){
        rec.view.center = CGPointMake(rec.view.center.x + point.x*speedf,rec.view.center.y);
        rec.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1-scalef/1000,1-scalef/1000);
        [rec setTranslation:CGPointMake(0, 0) inView:self.view];
    }
    //手势结束后修正位置
    if (rec.state == UIGestureRecognizerStateEnded) {
        if (scalef>140*speedf){
            [self showLeftView];
        }
        else{
            [self showMainView];
            scalef = 0;
        }
    }
}


#pragma mark - 单击手势
-(void)handeTap:(UITapGestureRecognizer *)tap{
    [mainControl.view addGestureRecognizer:pan];
    if (tap.state == UIGestureRecognizerStateEnded) {
        [UIView beginAnimations:nil context:nil];
        mainControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
        mainControl.view.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
        [UIView commitAnimations];
        scalef = 0;
    }
}

#pragma mark - 修改视图位置
//恢复位置
-(void)showMainView{
    [UIView beginAnimations:nil context:nil];
    mainControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    mainControl.view.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    [UIView commitAnimations];
    
}

//显示左视图
-(void)showLeftView{
    [mainControl.view removeGestureRecognizer:pan];
    [UIView beginAnimations:nil context:nil];
    if (SCREENWIDTH>=375){
        mainControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.345,0.7);
    } else if (SCREENWIDTH==320){
        mainControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.7,0.7);
    }
    mainControl.view.center = CGPointMake(340,[UIScreen mainScreen].bounds.size.height/2);
    [UIView commitAnimations];
}

#pragma mark - 切换视图

- (void)notifacationManage
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cutViewController1) name:@"GO1" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cutViewController2) name:@"GO2" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cutViewController3) name:@"GO3" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cutViewController4) name:@"GO4" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cutViewController0) name:@"GO0" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enlargePage) name:@"ENLARGEPAGE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoMonitor) name:@"GOTOMONITOR" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoConnect) name:@"GOTOCONNECT" object:nil];
}

- (void)enlargePage
{
    [self.navigationController pushViewController:[[HorizontalViewController alloc] init] animated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ENLARGEPAGE" object:nil];
}
- (void)cutViewController1{
    [self.navigationController pushViewController:[[MonitorViewController alloc] init]animated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GO1" object:nil];
}
- (void)cutViewController2{
    [self.navigationController pushViewController:[[ManageViewController alloc] init]animated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GO2" object:nil];
}
- (void)cutViewController3{
    [self.navigationController pushViewController:[[SysSettingViewController alloc] init]animated:YES];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GO3" object:nil];
}
- (void)cutViewController4{
    [self.navigationController pushViewController:[[AboutViewController alloc] init]animated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GO4" object:nil];
}
- (void)cutViewController0{
    [self.navigationController pushViewController:[[MyDataViewController alloc]init] animated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GO0" object:nil];
}
- (void)gotoMonitor{
    [self.navigationController pushViewController:[[MonitorViewController alloc] init] animated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GOTOMONITOR" object:nil];
}
- (void)gotoConnect
{
    [self.navigationController pushViewController:[[ManageViewController alloc]init] animated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GOTOCONNECT" object:nil];
}

@end
