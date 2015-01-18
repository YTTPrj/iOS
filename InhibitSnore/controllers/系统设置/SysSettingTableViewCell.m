//
//  SysSettingTableViewCell.m
//  InhibitSnore
//
//  Created by FZY on 15/1/15.
//  Copyright (c) 2015年 FZY. All rights reserved.
//

#import "SysSettingTableViewCell.h"

@implementation SysSettingTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:246.0/255 green:246.0/255 blue:246.0/255 alpha:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
