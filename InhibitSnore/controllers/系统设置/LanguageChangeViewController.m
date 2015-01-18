//
//  LanguageChangeViewController.m
//  InhibitSnore
//
//  Created by FZY on 15/1/15.
//  Copyright (c) 2015年 FZY. All rights reserved.
//

#import "LanguageChangeViewController.h"
#import "LanguageChangeTableViewCell.h"

@interface LanguageChangeViewController (){
    NSArray * tmpArray;
    UIImageView * hookImageView;
}


@end

@implementation LanguageChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    tmpArray = @[@"跟随系统",@"中文",@"English",@"Deutsch"];
    hookImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_tableView.bounds.size.width-16, 15, 16, 13)];
    hookImageView.image = [UIImage imageNamed:@"选中状态"];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.bounces = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tmpArray.count;
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
    LanguageChangeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"LanguageChangeTableViewCell" owner:self options:nil][0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.label.text = tmpArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
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
