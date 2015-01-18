//
//  SysSettingViewController.m
//  InhibitSnore
//
//  Created by FZY on 15/1/15.
//  Copyright (c) 2015年 FZY. All rights reserved.
//

#import "SysSettingViewController.h"
#import "SysSettingTableViewCell.h"
#import "LanguageChangeViewController.h"
#import "MoreSettingViewController.h"
#import "InformationViewController.h"
#import "ExplainViewController.h"
#import "UpdataViewController.h"

@interface SysSettingViewController (){
    NSArray * headArray;
    NSArray * nameArray;
}

@end

@implementation SysSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    headArray = @[@"指示灯_IOS",@"语言环境图标",@"更多设置",@"设备信息",@"帮助图标",@"设备更新"];
    nameArray = @[@"鼾器指示灯",@"语言环境",@"更多设置",@"设备信息",@"帮助说明",@"设备固件更新"];
    
    [self customTableView];
    // Do any additional setup after loading the view from its nib.
}

//鼾器指示灯开关
- (void)flashSwitch
{
    
}

- (void)customTableView
{
    
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SysSettingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"SysSettingTableViewCell" owner:self options:nil][0];
    }
    if (indexPath.row==0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UISwitch * sw = [[UISwitch alloc] initWithFrame:CGRectMake(SCREENWIDTH-60, cell.bounds.size.height/2-15.5, 49, 31)];
        [sw addTarget:self action:@selector(flashSwitch) forControlEvents:UIControlEventValueChanged];
        [cell.arrowImageView removeFromSuperview];
        [cell addSubview:sw];
    }
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:246.0/255 green:246.0/255 blue:246.0/255 alpha:1];
    cell.nameLabel.text = nameArray[indexPath.row];
    cell.headImageView.image = [UIImage imageNamed:headArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==1) {
        [self.navigationController pushViewController:[[LanguageChangeViewController alloc] init] animated:YES];
    } else if (indexPath.row==2){
        [self.navigationController pushViewController:[[MoreSettingViewController alloc] init] animated:YES];
    } else if (indexPath.row==3){
        [self.navigationController pushViewController:[[InformationViewController alloc] init] animated:YES];
    } else if (indexPath.row==4){
        [self.navigationController pushViewController:[[ExplainViewController alloc] init] animated:YES];
    } else if (indexPath.row==5){
        //若无新版本
        UIAlertView * alt = [[UIAlertView alloc] initWithTitle:@"设备固件更新提示" message:@"当前已是最新版本" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alt show];
        //若有新版本
//        [self.navigationController pushViewController:[[UpdataViewController alloc] init] animated:YES];
    }
    [tableView reloadData];
}

- (IBAction)lastPage:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
//    [self.navigationController popToRootViewControllerAnimated:YES];
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
