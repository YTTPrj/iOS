//
//  AboutViewController.m
//  InhibitSnore
//
//  Created by FZY on 15/1/16.
//  Copyright (c) 2015年 FZY. All rights reserved.
//

#import "AboutViewController.h"
#import "AboutTableViewCell.h"

@interface AboutViewController (){
    NSArray * titleArray;
    UIImageView * backImageView;
    UIImageView * weixinImageView;
    UIButton * cancelButton;
    UILabel * label1;
    UILabel * label2;
    UILabel * label3;
    UIButton * copyButton;
    UILabel * copyLabel;
}

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    [self layout];
    titleArray = @[@"检查新版本",@"访问官网",@"关注微信\"云中飞\""];
    // Do any additional setup after loading the view from its nib.
}


- (void)createTableView
{
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
}

- (void)layout
{
    backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, 260)];
    backImageView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    backImageView.userInteractionEnabled=YES;
    weixinImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2-100, 57, 200, 30)];
    weixinImageView.image = [UIImage imageNamed:@"搜索微信按钮.png"];
    
    label1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2-90, 100, 180, 20)];
    label2 = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2-90, 122, 200, 20)];
    label3 = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2-90, 144, 200, 20)];
    label1.text = @"1、打开微信";
    label2.text = @"2、复制下方公众号";
    label3.text = @"3、点击查找微信号，关注我们";
    label1.textColor = [UIColor whiteColor];
    label1.font = [UIFont systemFontOfSize:13];
    label2.textColor = [UIColor whiteColor];
    label2.font = [UIFont systemFontOfSize:13];
    label3.textColor = [UIColor whiteColor];
    label3.font = [UIFont systemFontOfSize:13];
    copyButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH/2-85, 180, 170, 35)];
    [copyButton setImage:[UIImage imageNamed:@"复制公众号按钮"] forState:UIControlStateNormal];
    [copyButton setImage:[UIImage imageNamed:@"复制公众号按钮点击效果"] forState:UIControlStateHighlighted];
    copyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2-50, 187, 100, 20)];
    copyLabel.textAlignment = NSTextAlignmentCenter;
    copyLabel.textColor = [UIColor whiteColor];
    copyLabel.text = @"复制公众号";
    copyLabel.font = [UIFont systemFontOfSize:15];
    cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH-45, 13, 30, 30)];
    [cancelButton setImage:[UIImage imageNamed:@"关闭按钮"] forState:UIControlStateNormal];
    [cancelButton setImage:[UIImage imageNamed:@"关闭按钮点击效果"] forState:UIControlStateHighlighted];
    [cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    
    [backImageView addSubview:weixinImageView];
    [backImageView addSubview:label1];
    [backImageView addSubview:label2];
    [backImageView addSubview:label3];
    [backImageView addSubview:copyButton];
    [backImageView addSubview:copyLabel];
    [backImageView addSubview:cancelButton];
    [self.view addSubview:backImageView];
}

- (void)cancel
{
    [UIView animateWithDuration:0.3 animations:^{
        backImageView.center = CGPointMake(SCREENWIDTH/2, SCREENHEIGHT+130);
    }];
}

#pragma mark - tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 52;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 52;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AboutTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"AboutTableViewCell" owner:self options:nil][0];
    }
    cell.titleLabel.text = titleArray[indexPath.row];
    if (indexPath.row!=0) {
        [cell.editionLabel removeFromSuperview];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        UIAlertView * alt = [[UIAlertView alloc] initWithTitle:@"检测新版本" message:@"当前已是最新版本" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alt show];
    }if (indexPath.row==1) {
        
    }if (indexPath.row==2) {
        [UIView animateWithDuration:0.3 animations:^{
            backImageView.center = CGPointMake(SCREENWIDTH/2, SCREENHEIGHT-130);
        }];
    }
    [tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
