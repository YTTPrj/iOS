//
//  NMainViewController.m
//  InhibitSnore
//
//  Created by FZY on 15/1/15.
//  Copyright (c) 2015年 FZY. All rights reserved.
//

#import "NMainViewController.h"
#import "MainTableViewCell.h"
#import "MonitorViewController.h"
#import "ManageViewController.h"
#import "SysSettingViewController.h"
#import "AboutViewController.h"
#import "MyDataViewController.h"
#import "MyCustomView.h"
#import "ShareView.h"

@interface NMainViewController (){
    NSArray * detailMemberArray;
    UIPickerView * datePickerView;
    NSMutableArray * dateArray;
    MyCustomView * myView;
    ShareView * shareView;
}

@end

@implementation NMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationBarHidden = NO;
    [self layout];
    [self createAnimationButton];
}


#pragma mark - 布局
- (void)layout
{
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imageView.image = [UIImage imageNamed:@"首页背景"];
    imageView.userInteractionEnabled = YES;
    _menuImageView = [[UIImageView alloc] initWithFrame:CGRectMake(11, 32, 18, 15)];
    _menuImageView.image = [UIImage imageNamed:@"菜单图标"];
    _menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 19, 40, 40)];
    _menuButton.backgroundColor = [UIColor clearColor];
    [_menuButton setImage:[UIImage imageNamed:@"菜单点击效果"] forState:UIControlStateHighlighted];
    [_menuButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView * titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2-55, 31, 110, 17)];
    titleImageView.image = [UIImage imageNamed:@"首页标题"];
    
    _batteryLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH-40, 29, 37, 21)];
    _batteryLabel.text = @"85%";
    _batteryLabel.textAlignment = NSTextAlignmentCenter;
    _batteryLabel.textColor = [UIColor whiteColor];
    _batteryLabel.font = [UIFont systemFontOfSize:8];
    UIImageView * bImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH-36, 32, 28, 15)];
    bImageView.image = [UIImage imageNamed:@"电池图标"];
    
    _connectStateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH-61, 32, 16, 15)];
    _connectStateImageView.image = [UIImage imageNamed:@"未链接"];
    
    _partImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 58, SCREENWIDTH, 40)];
    _partImageView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    
    _dateButton = [[UIButton alloc] initWithFrame:CGRectMake(12, 58, 40, 40)];
    _dateButton.backgroundColor = [UIColor clearColor];
    [_dateButton setImage:[UIImage imageNamed:@"日历点击背景"] forState:UIControlStateHighlighted];
    [_dateButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    _dateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(24, 70, 16, 16)];
    _dateImageView.image = [UIImage imageNamed:@"日历图标"];
    
    _shareButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH-52, 58, 40, 40)];
    [_shareButton setImage:[UIImage imageNamed:@"日历点击背景"] forState:UIControlStateHighlighted];
    _shareButton.backgroundColor = [UIColor clearColor];
    [_shareButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    _shareImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH-40, 70, 16, 16)];
    _shareImageView.image = [UIImage imageNamed:@"分享图标"];

    _lastButton = [[UIButton alloc] initWithFrame:CGRectMake(70, 58, 30, 40)];
    _lastButton.backgroundColor = [UIColor clearColor];
    [_lastButton setImage:[UIImage imageNamed:@"日历点击背景"] forState:UIControlStateHighlighted];
    [_lastButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    _lastImageView = [[UIImageView alloc] initWithFrame:CGRectMake(81, 73, 8, 10)];
    _lastImageView.image = [UIImage imageNamed:@"向前图标"];
    
    _nextButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH-98, 58, 30, 40)];
    _nextButton.backgroundColor = [UIColor clearColor];
    [_nextButton setImage:[UIImage imageNamed:@"日历点击背景"] forState:UIControlStateHighlighted];
    [_nextButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    _nextImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENWIDTH-87, 73, 8, 10)];
    _nextImageView.image = [UIImage imageNamed:@"向后图标"];
    
    _dateDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2-60, 68, 120, 20)];
    _dateDetailLabel.font = [UIFont systemFontOfSize:13];
    _dateDetailLabel.textColor = [UIColor whiteColor];
    _dateDetailLabel.text = @"12月 12-13 星期五";
    _dateDetailLabel.textAlignment = NSTextAlignmentCenter;
    _detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 300, SCREENWIDTH, 180)];
    if (SCREENHEIGHT<=480) {
        _detailTableView.frame = CGRectMake(0, 230, SCREENWIDTH, 180);
    }
    _detailTableView.backgroundColor = [UIColor clearColor];
    _detailTableView.delegate = self;
    _detailTableView.dataSource = self;
    detailMemberArray = @[@"睡觉/起床",@"床上时间",@"打鼾次数",@"睡眠指数"];
    _detailTableView.bounces = NO;
    
    _reloadButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH-47, SCREENHEIGHT-47, 30, 30)];
    [_reloadButton setImage:[UIImage imageNamed:@"刷新图标"] forState:UIControlStateNormal];
    [_reloadButton setImage:[UIImage imageNamed:@"刷新图标点击效果"] forState:UIControlStateHighlighted];
    [_reloadButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [imageView addSubview:_menuButton];
    [imageView addSubview:_menuImageView];
    [imageView addSubview:titleImageView];
    [imageView addSubview:_connectStateImageView];
    [imageView addSubview:bImageView];
    [imageView addSubview:_batteryLabel];
    [imageView addSubview:_partImageView];
    [imageView addSubview:_dateImageView];
    [imageView addSubview:_dateButton];
    [imageView addSubview:_lastImageView];
    [imageView addSubview:_lastButton];
    [imageView addSubview:_dateDetailLabel];
    [imageView addSubview:_nextImageView];
    [imageView addSubview:_nextButton];
    [imageView addSubview:_shareImageView];
    [imageView addSubview:_shareButton];
    [imageView addSubview:_detailTableView];
    [imageView addSubview:_reloadButton];
    [self.view addSubview:imageView];
    
}

- (void)onClick:(UIButton *)bt
{
    if (bt==_menuButton) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"SHOWLEFT" object:nil];
    }
    if (bt==_dateButton) {
        myView = [[MyCustomView alloc] initWithFrame:[UIScreen mainScreen].bounds height:250 title:@"选择查询日期"];
        [self createDatePickerView];
        [myView addSubview:datePickerView];
        [myView.doneButton addTarget:self action:@selector(doneOnClick) forControlEvents:UIControlEventTouchUpInside];
        [myView.cancelButton addTarget:self action:@selector(cancelOnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:myView];
    }
    if (bt==_shareButton) {
        shareView = [[ShareView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [shareView.weiXinButton addTarget:self action:@selector(shareButtons:) forControlEvents:UIControlEventTouchUpInside];
        [shareView.weiXinFriendCirCleButton addTarget:self action:@selector(shareButtons:) forControlEvents:UIControlEventTouchUpInside];
        [shareView.QQButton addTarget:self action:@selector(shareButtons:) forControlEvents:UIControlEventTouchUpInside];
        [shareView.xButton addTarget:self action:@selector(shareButtons:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:shareView];
    }
}

//分享 微信 微信朋友圈 QQ好友
- (void)shareButtons:(UIButton *)bt
{
    [shareView removeFromSuperview];
}

//选择日期 确定 取消
- (void)doneOnClick
{
    [myView removeFromSuperview];
}

- (void)cancelOnClick
{
    [myView removeFromSuperview];
}

- (void)createDatePickerView
{
    datePickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2-90, SCREENHEIGHT/2-81, 180, 100)];
    datePickerView.delegate = self;
    datePickerView.dataSource = self;
    
    dateArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 3; i++) {
        NSMutableArray * array = [NSMutableArray array];
        if (i == 0) {
            for (NSInteger i = 2014; i <= 2020; i++) {
                [array addObject:[NSString stringWithFormat:@"%ld年", i]];
            }
        } else if (i == 1) {
            for (NSInteger i = 1; i <= 12; i++){
                [array addObject:[NSString stringWithFormat:@"%ld月", i]];
            }
        } else if (i == 2) {
            for (NSInteger i = 1; i <= 31; i++) {
                [array addObject:[NSString stringWithFormat:@"%ld日", i]];
            }
        }
        [dateArray addObject:array];
    }
}

#pragma mark - pickerView代理
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    //返回pickerView的列数
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //返回每一列的行数
    return [dateArray[component] count];
}

//返回每一行的标题，一般没用
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return dateArray[component][row];
}

//返回自定义视图
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel * label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12];
    
    //设置文字
    label.text = dateArray[component][row];
    
    return label;
}

//返回某一列的宽度，凡是没设宽度的会被挤压
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component == 0) {
        return 70;
    }
    return 40;
}

//返回高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 25;
}

//选中了某一个行 滚动停止
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"日期:%@", dateArray[component][row]);
}

#pragma mark - tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return detailMemberArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"MainTableViewCell" owner:self options:nil][0];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.detailNameLabel.text = detailMemberArray[indexPath.row];
    
    return cell;
}






#pragma mark - 坐下角button
- (void)createAnimationButton
{
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end































