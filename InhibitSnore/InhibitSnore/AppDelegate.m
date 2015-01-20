//
//  AppDelegate.m
//  InhibitSnore
//
//  Created by FZY on 15/1/13.
//  Copyright (c) 2015年 FZY. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "WWSideslipViewController.h"
#import "HeadViewController.h"
#import "NMainViewController.h"
#import "MainViewController.h"

//ShareSDK
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <QQConnection/QQConnection.h>


@interface AppDelegate (){
    BOOL isFirst;
}

@end

@implementation AppDelegate

-(void)createDatabase{
    
    FMDatabase *data= [self FMdata];
    [data open];
    
    //创建原始数据
    NSString *sql=@"create table SynData (_id INTEGER PRIMARY KEY,Year int,Month int,Day int,Minute int,Flag int,actionIndex int, dateTime date)";
    
    //创建分区数据
    NSString *sql2=@"create table Resolve(starYear int,endYear int,starMonth int,endMonth int,starDay int,endDay int,starMinute int,endMinute int,flag int,actionIndex int,actionMinute int)";
    
    //个人注册信息表
    NSString *sql3=@"create table PersonalInfo(userName text,password text,nikeName text,image text,sex text,height text,weight text,heightUnit text,weightUnit text,birthday text,walk text,jogg text,calorie text,sleepTime text,sleeplong text,PerUUID text,DeviceUUID text)";
    
    //设备信息4o
    NSString *sql4=@"create table DeviceInfo(userName text,UUID text,DeviceUUID text,DeviceName text)";
    [data executeUpdate:sql];
    [data executeUpdate:sql2];
    [data executeUpdate:sql3];
    [data executeUpdate:sql4];
    
    NSString *selectsql=@"where flag = -1 ";
    NSArray *arr=[self retunsynForDay:selectsql];
    if (arr.count<=0) {
        NSString *year=[NSString stringWithFormat:@"%d",[self getnowYear]];
        NSString *month=[NSString stringWithFormat:@"%d",[self getnowMonth]];
        NSString *day=[NSString stringWithFormat:@"%d",[self getnowDay]];
        NSString *minute=[NSString stringWithFormat:@"%d",[self getnowHour]*60+[self getnowMinute]];
        [data executeUpdate:@"insert into SynData (Year,Month,Day,Minute,Flag,actionIndex) VALUES (?,?,?,?,?,?)",year,month,day,minute,@"-1",@"0"];
        //[data executeUpdate:@"insert into SynData (Year,Month,Day,Minute,Flag,actionIndex) VALUES (14,5,2,800,-1,0)"];
    }
    [data close];
    
}

- (void)createShareSDK
{
    [ShareSDK registerApp:@"55a8600e9d70"];
    //QQ
    [ShareSDK connectQQWithQZoneAppKey:@"100371282"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    [ShareSDK connectWeChatWithAppId:@"wx4868b35061f87885"
                           wechatCls:[WXApi class]];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    NSString * str = [NSString stringWithFormat:@"%d",[self getnowYear]];
//    int year = [[str substringWithRange:NSMakeRange(2, 2)] intValue];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self createShareSDK];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"ISFIRSTSTART"]) {
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc]init]];
        isFirst = YES;
        [[NSUserDefaults standardUserDefaults] setBool:isFirst forKey:@"ISFIRSTSTART"];
    } else {
        HeadViewController * hvc = [[HeadViewController alloc] init];
//        NMainViewController *nmvc = [[NMainViewController alloc] init];
        //    UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:nmvc];
        MainViewController * mvc = [[MainViewController alloc] init];
        WWSideslipViewController * wwvc = [[WWSideslipViewController alloc]initWithLeftView:hvc andMainView:mvc];
        [wwvc setSpeedf:0.5];
        wwvc.sideslipTapGes.enabled = YES;
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:wwvc];
    }
    
    
    
    
    
//    [tabBarController setViewControllers:[NSArray arrayWithObjects:nvc1,nvc2, nil]];
//    self.window.rootViewController = tabBarController;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
