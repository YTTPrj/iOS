//
//  MainViewController.m
//  InhibitSnore
//
//  Created by FZY on 15/1/14.
//  Copyright (c) 2015年 FZY. All rights reserved.
//

#import "MainViewController.h"
#import "MainTableViewCell.h"
#import "MonitorViewController.h"
#import "ManageViewController.h"
#import "SysSettingViewController.h"
#import "AboutViewController.h"
#import "MyDataViewController.h"

#import "MyCustomView.h"
#import "ShareView.h"

@interface MainViewController (){
    NSArray * detailMemberArray;
    UIPickerView * datePickerView;
    NSMutableArray * dateArray;
    MyCustomView * myView;
    ShareView * shareView;
}

@end

@implementation MainViewController

//- (void)viewWillAppear:(BOOL)animated
//{
//    [self createAnimationButton];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self notifacationManage];
    [self alterXIB];
    [self customTableView];
//    [self createAnimationButton];
}

- (void)notifacationManage
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cutViewController1) name:@"GO1" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cutViewController2) name:@"GO2" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cutViewController3) name:@"GO3" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cutViewController4) name:@"GO4" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GO1" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GO2" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GO3" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GO4" object:nil];
}

- (void)alterXIB
{
    NSMutableArray * tmpArray = [[NSMutableArray alloc] init];
    [tmpArray addObject:_dateButton];
    [tmpArray addObject:_shareButton];
    [tmpArray addObject:_lastButton];
    [tmpArray addObject:_nextButton];
    for (int i=0; i<4; i++) {
        [tmpArray[i] setImage:[UIImage imageNamed:@"日历点击背景"] forState:UIControlStateHighlighted];
    }
    [_menuButton setImage:[UIImage imageNamed:@"菜单点击效果"] forState:UIControlStateHighlighted];
    
    
}


- (IBAction)onClick:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
            [[NSNotificationCenter defaultCenter]postNotificationName:@"SHOWLEFT" object:nil];
            break;
        case 1:
            myView = [[MyCustomView alloc] initWithFrame:[UIScreen mainScreen].bounds height:250 title:@"选择查询日期"];
            [self createDatePickerView];
            [myView addSubview:datePickerView];
            [myView.doneButton addTarget:self action:@selector(doneOnClick) forControlEvents:UIControlEventTouchUpInside];
            [myView.cancelButton addTarget:self action:@selector(cancelOnClick) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:myView];
            break;
        case 2:
            shareView = [[ShareView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            [shareView.weiXinButton addTarget:self action:@selector(shareButtons:) forControlEvents:UIControlEventTouchUpInside];
            [shareView.weiXinFriendCirCleButton addTarget:self action:@selector(shareButtons:) forControlEvents:UIControlEventTouchUpInside];
            [shareView.QQButton addTarget:self action:@selector(shareButtons:) forControlEvents:UIControlEventTouchUpInside];
            [shareView.xButton addTarget:self action:@selector(shareButtons:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:shareView];
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        default:
            break;
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


- (void)createAnimationButton
{
    UIImage *storyMenuItemImage = [UIImage imageNamed:@"实时监测"];
    UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"实时监测点击效果"];
    
    UIImage *equipmentManagementImage = [UIImage imageNamed:@"设备管理"];
    UIImage *equipmentManagementImagePressed = [UIImage imageNamed:@"设备管理点击效果"];
    
    // Camera MenuItem.
    QuadCurveMenuItem *cameraMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                                highlightedImage:storyMenuItemImagePressed
                                                                    ContentImage:[UIImage imageNamed:@""]
                                                         highlightedContentImage:nil];
    // People MenuItem.
    QuadCurveMenuItem *peopleMenuItem = [[QuadCurveMenuItem alloc] initWithImage:equipmentManagementImage
                                                                highlightedImage:equipmentManagementImagePressed
                                                                    ContentImage:[UIImage imageNamed:@""]
                                                         highlightedContentImage:nil];
    
    NSArray *menus = [NSArray arrayWithObjects:cameraMenuItem, peopleMenuItem,nil];
    QuadCurveMenu *menu = [[QuadCurveMenu alloc] initWithFrame:[UIScreen mainScreen].bounds menus:menus];
    menu.delegate = self;
    [self.view addSubview:menu];
}

- (void)quadCurveMenu:(QuadCurveMenu *)menu didSelectIndex:(NSInteger)idx
{
    NSLog(@"Select the index : %d",idx);
}


#pragma mark - 切换视图控制器
- (void)cutViewController:(NSInteger)number
{
//    switch (number) {
//        case 0:
//            break;
//        case 1:
//            [self.navigationController pushViewController:[[MonitorViewController alloc] init] animated:NO];
//            break;
//        case 2:
//            [self.navigationController pushViewController:[[ManageViewController alloc] init] animated:NO];
//            break;
//        case 3:
//            [self.navigationController pushViewController:[[SysSettingViewController alloc] init] animated:NO];
//            break;
//        case 4:
//            [self.navigationController pushViewController:[[AboutViewController alloc] init] animated:NO];
//            break;
//        default:
//            break;
//    }
}

- (void)cutViewController1{
    [self.navigationController pushViewController:[[MonitorViewController alloc] init]animated:NO];
}
- (void)cutViewController2{
    [self.navigationController pushViewController:[[ManageViewController alloc] init]animated:NO];
}
- (void)cutViewController3{
    [self.navigationController pushViewController:[[SysSettingViewController alloc] init]animated:NO];
}
- (void)cutViewController4{
    [self.navigationController pushViewController:[[AboutViewController alloc] init]animated:NO];
}
/*我的资料*/
- (void)cutViewController5{
    
}

#pragma mark - tableView-delegate
- (void)customTableView
{
    _detailTableView.backgroundColor = [UIColor clearColor];
    _detailTableView.delegate = self;
    _detailTableView.dataSource = self;
    _detailTableView.bounces = NO;
    detailMemberArray = @[@"睡觉/起床",@"床上时间",@"打鼾次数",@"睡眠指数"];
    
}

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
