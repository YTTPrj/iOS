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
    BOOL bottomLeftButton;
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
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(enlargePage:)];
//    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
////    UITapGestureRecognizer * tap = [[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(enlargePage)];
////    [_swipeImageView addGestureRecognizer:tap];
    [_swipeImageView addGestureRecognizer:pan];
    
}

- (void)enlargePage:(UIPanGestureRecognizer *)pan
{
    if (pan.view.frame.origin.x>0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ENLARGEPAGE" object:nil];
    }
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
        case 100:
            [[NSNotificationCenter defaultCenter]postNotificationName:@"SHOWLEFT" object:nil];
            break;
        case 101:
            myView = [[MyCustomView alloc] initWithFrame:[UIScreen mainScreen].bounds height:250 title:@"选择查询日期"];
            [self createDatePickerView];
            [myView addSubview:datePickerView];
            [myView.doneButton addTarget:self action:@selector(doneOnClick) forControlEvents:UIControlEventTouchUpInside];
            [myView.cancelButton addTarget:self action:@selector(cancelOnClick) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:myView];
            break;
        case 102:
//            shareView = [[ShareView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//            [shareView.weiXinButton addTarget:self action:@selector(shareButtons:) forControlEvents:UIControlEventTouchUpInside];
//            [shareView.weiXinFriendCirCleButton addTarget:self action:@selector(shareButtons:) forControlEvents:UIControlEventTouchUpInside];
//            [shareView.QQButton addTarget:self action:@selector(shareButtons:) forControlEvents:UIControlEventTouchUpInside];
//            [shareView.xButton addTarget:self action:@selector(shareButtons:) forControlEvents:UIControlEventTouchUpInside];
//            [self.view addSubview:shareView];
            {
                NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"icon" ofType:@"png"];
                id<ISSContent> publishContent = [ShareSDK content:@"回家睡觉"
                                                   defaultContent:@"测试一下"
                                                            image:[ShareSDK imageWithPath:imagePath]
                                                            title:@"ShareSDK"
                                                              url:@"http://www.mob.com"
                                                      description:@"这是一条测试信息"
                                                        mediaType:SSPublishContentMediaTypeNews];
                //创建弹出菜单容器
                id<ISSContainer> container = [ShareSDK container];
                [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
                
               
                [publishContent addWeixinSessionUnitWithType:INHERIT_VALUE
                                                     content:INHERIT_VALUE
                                                       title: @"Hello 微信好友!"
                                                         url:INHERIT_VALUE
                                                  thumbImage:[ShareSDK imageWithUrl:@"http://img1.bdstatic.com/img/image/67037d3d539b6003af38f5c4c4f372ac65c1038b63f.jpg"]
                                                       image:INHERIT_VALUE
                                                musicFileUrl:nil
                                                     extInfo:nil
                                                    fileData:nil
                                                emoticonData:nil];
                //定制微信朋友圈信息
                [publishContent addWeixinTimelineUnitWithType:[NSNumber numberWithInteger:SSPublishContentMediaTypeMusic]
                                                      content:INHERIT_VALUE
                                                        title:NSLocalizedString(@"TEXT_HELLO_WECHAT_TIMELINE", @"Hello 微信朋友圈!")
                                                          url:@"http://y.qq.com/i/song.html#p=7B22736F6E675F4E616D65223A22E4BDA0E4B88DE698AFE79C9FE6ADA3E79A84E5BFABE4B990222C22736F6E675F5761704C69766555524C223A22687474703A2F2F74736D7573696332342E74632E71712E636F6D2F586B303051563558484A645574315070536F4B7458796931667443755A68646C2F316F5A4465637734356375386355672B474B304964794E6A3770633447524A574C48795333383D2F3634363232332E6D34613F7569643D32333230303738313038266469723D423226663D312663743D3026636869643D222C22736F6E675F5769666955524C223A22687474703A2F2F73747265616D31382E71716D757369632E71712E636F6D2F33303634363232332E6D7033222C226E657454797065223A2277696669222C22736F6E675F416C62756D223A22E5889BE980A0EFBC9AE5B08FE5B7A8E89B8B444E414C495645EFBC81E6BC94E594B1E4BC9AE5889BE7BAAAE5BD95E99FB3222C22736F6E675F4944223A3634363232332C22736F6E675F54797065223A312C22736F6E675F53696E676572223A22E4BA94E69C88E5A4A9222C22736F6E675F576170446F776E4C6F616455524C223A22687474703A2F2F74736D757369633132382E74632E71712E636F6D2F586C464E4D31354C5569396961495674593739786D436534456B5275696879366A702F674B65356E4D6E684178494C73484D6C6A307849634A454B394568572F4E3978464B316368316F37636848323568413D3D2F33303634363232332E6D70333F7569643D32333230303738313038266469723D423226663D302663743D3026636869643D2673747265616D5F706F733D38227D"
                                                   thumbImage:[ShareSDK imageWithUrl:@"http://img1.bdstatic.com/img/image/67037d3d539b6003af38f5c4c4f372ac65c1038b63f.jpg"]
                                                        image:INHERIT_VALUE
                                                 musicFileUrl:@"http://mp3.mwap8.com/destdir/Music/2009/20090601/ZuiXuanMinZuFeng20090601119.mp3"
                                                      extInfo:nil
                                                     fileData:nil
                                                 emoticonData:nil];
                //定制QQ分享信息
                [publishContent addQQUnitWithType:INHERIT_VALUE
                                          content:INHERIT_VALUE
                                            title:@"Hello QQ!"
                                              url:INHERIT_VALUE
                                            image:INHERIT_VALUE];
                
                //结束定制信息
                
                
                //弹出分享菜单
                [ShareSDK showShareActionSheet:container
                                     shareList:nil
                                       content:publishContent
                                 statusBarTips:YES
                                   authOptions:nil
                                  shareOptions:nil
                                        result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                            
                                            if (state == SSResponseStateSuccess)
                                            {
                                                NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                            }
                                            else if (state == SSResponseStateFail)
                                            {
                                                NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                            }
                                        }];
            }
            break;
        case 200:
            [self BLPlusButton];
            break;
        case 201:
            [self BLDeviceButton];
            break;
        case 202:
            [self BLConnectState];
            break;
        default:
            break;
    }
}


//左下角按钮
- (void)BLPlusButton
{
    if (bottomLeftButton) {
        [_plusButton setImage:[UIImage imageNamed:@"增加图标"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3 animations:^{
            _deviceButton.center = _plusButton.center;
            _connectStateButton.center = _plusButton.center;
        }];
        bottomLeftButton=NO;
    } else {
        [_plusButton setImage:[UIImage imageNamed:@"增加图标点击效果"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3 animations:^{
            _deviceButton.center = CGPointMake(_plusButton.center.x+THREEBUTTONOFFSET*0.7071067812, _plusButton.center.y-THREEBUTTONOFFSET*0.7071067812);
            _connectStateButton.center = CGPointMake(_plusButton.center.x+THREEBUTTONOFFSET*0.96592582628907,  _plusButton.center.y+THREEBUTTONOFFSET*0.25881904510252);
        }];
        bottomLeftButton=YES;
    }
}

- (void)BLDeviceButton
{
    [_plusButton setImage:[UIImage imageNamed:@"增加图标"] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
        _deviceButton.center = _plusButton.center;
        _connectStateButton.center = _plusButton.center;
    }];
    bottomLeftButton=NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GOTOMONITOR" object:nil];
}

- (void)BLConnectState
{
    [_plusButton setImage:[UIImage imageNamed:@"增加图标"] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
        _deviceButton.center = _plusButton.center;
        _connectStateButton.center = _plusButton.center;
    }];
    bottomLeftButton=NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GOTOCONNECT" object:nil];
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


#pragma mark - 切换视图控制器
- (void)cutViewController:(NSInteger)number
{

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
    detailMemberArray = @[@"睡觉时间",@"打鼾次数",@"止鼾成功",@"止鼾失效"];
    
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
