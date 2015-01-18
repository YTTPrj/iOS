//
//  SearchViewController.m
//  InhibitSnore
//
//  Created by FZY on 15/1/15.
//  Copyright (c) 2015年 FZY. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchTableViewCell.h"
#import "FirstSearchViewController.h"
#import "ManageViewController.h"
#import "NMainViewController.h"
#import "WWSideslipViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    
    
    [_searchButton setImage:[UIImage imageNamed:@"发现设备_重新搜索点击效果"] forState:UIControlStateHighlighted];
}


- (IBAction)research:(UIButton *)sender {
//    [self presentViewController:[[FirstSearchViewController alloc] init] animated:NO completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"SearchTableViewCell" owner:self options:nil][0];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self presentViewController:[[WWSideslipViewController alloc]init] animated:NO completion:nil];
//    [self.navigationController popToViewController:[[WWSideslipViewController alloc] init] animated:YES];
//    [self.navigationController pushViewController:[[WWSideslipViewController alloc] init] animated:YES];
//    [self.navigationController popToViewController:[[ManageViewController alloc]init] animated:NO];
//    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
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
