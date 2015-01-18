//
//  HeadViewController.m
//  InhibitSnore
//
//  Created by FZY on 15/1/13.
//  Copyright (c) 2015年 FZY. All rights reserved.
//

#import "HeadViewController.h"
#import "HeadTableViewCell.h"
#import "MainViewController.h"
#import "WWSideslipViewController.h"
#import "ManageViewController.h"

@interface HeadViewController (){
    NSArray * iconImageArray;
    NSArray * titleNameArray;
    NSData * data;
}

@end

@implementation HeadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    iconImageArray = @[@"首页图标",@"菜单实时监测",@"菜单设备管理",@"系统设置",@"关于图标"];
    titleNameArray = @[@"首页",@"实时监测",@"设备管理",@"系统设置",@"关于云中飞"];
    // Do any additional setup after loading the view from its nib.
    
    [self createMenuView];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ALTERNAME" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ALTERPHOTO" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createMenuView
{
    _menuBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    _menuBackgroundImageView.image = [UIImage imageNamed:@"菜单背景"];
    _menuBackgroundImageView.userInteractionEnabled = YES;
    
    _outerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(72*(SCREENWIDTH/320), 53, 90, 90)];
    _outerImageView.image = [UIImage imageNamed:@"菜单头像外圆.png"];
    
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(79*(SCREENWIDTH/320), 60, 76, 76)];
    data = [[NSUserDefaults standardUserDefaults] objectForKey:@"IMAGEDATA"];
    _headImageView.image = [UIImage imageWithData:data];
    if (_headImageView.image==nil) {
        _headImageView.image = [UIImage imageNamed:@"默认头像"];
    }
    _headImageView.layer.cornerRadius = 38;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.userInteractionEnabled = YES;
    _headButton = [[UIButton alloc] initWithFrame:CGRectMake(79*(SCREENWIDTH/320), 60, 76, 76)];
    _headButton.backgroundColor = [UIColor clearColor];
    [_headButton addTarget:self action:@selector(personalSet) forControlEvents:UIControlEventTouchUpInside];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(57*(SCREENWIDTH/320), 151, 121, 26)];
    _nameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERNAME"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alterName) name:@"ALTERNAME" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alterPhoto) name:@"ALTERPHOTO" object:nil];
    _menuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 205, SCREENWIDTH, 284)];
    _menuTableView.backgroundColor = [UIColor clearColor];
    _menuTableView.delegate = self;
    _menuTableView.dataSource = self;
    _menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_menuBackgroundImageView addSubview:_outerImageView];
    [_menuBackgroundImageView addSubview:_headImageView];
    [_menuBackgroundImageView addSubview:_headButton];
    [_menuBackgroundImageView addSubview:_nameLabel];
    [_menuBackgroundImageView addSubview:_menuTableView];
    [self.view addSubview:_menuBackgroundImageView];
    
}

- (void)alterName
{
    _nameLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERNAME"];
}

- (void)alterPhoto
{
    data = [[NSUserDefaults standardUserDefaults] objectForKey:@"IMAGEDATA"];
    _headImageView.image = [UIImage imageWithData:data];
    if (_headImageView.image==nil) {
        _headImageView.image = [UIImage imageNamed:@"默认头像"];
    }
}

- (void)personalSet
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GO0" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CORRECT" object:nil];
    NSLog(@"点了^^^^^");
}



#pragma mark - tableView-delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 37;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 37;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HeadTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"HeadTableViewCell" owner:self options:nil][0];
    }
//    cell.selectionStyle =UITableViewCellSelectionStyleBlue;
    cell.backgroundColor = [UIColor clearColor];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:cell.bounds];
    imageView.backgroundColor = [UIColor colorWithRed:97.0/255 green:87.0/255 blue:76.0/255 alpha:1];
    cell.selectedBackgroundView = imageView;
//    cell.backgroundView.backgroundColor = [UIColor clearColor];
    cell.iconImageView.image = [UIImage imageNamed:iconImageArray[indexPath.row]];
    cell.titleLabel.text = titleNameArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CORRECT" object:nil];
    switch (indexPath.row) {
        case 0:
            break;
        case 1:
//            [self.headDelegate cutViewController:1];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"GO1" object:nil];
            break;
        case 2:
//            [self.headDelegate cutViewController:2];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"GO2" object:nil];
            break;
        case 3:
//            [self.headDelegate cutViewController:3];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"GO3" object:nil];
            break;
        case 4:
//            [self.headDelegate cutViewController:4];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"GO4" object:nil];
            break;
        default:
            break;
    }
    [tableView reloadData];
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
