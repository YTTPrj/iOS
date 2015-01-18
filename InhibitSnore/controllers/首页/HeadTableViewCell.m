//
//  HeadTableViewCell.m
//  InhibitSnore
//
//  Created by FZY on 15/1/13.
//  Copyright (c) 2015年 FZY. All rights reserved.
//

#import "HeadTableViewCell.h"

@implementation HeadTableViewCell

- (void)awakeFromNib {
    // Initialization code
//    self.backgroundColor = [UIColor clearColor];
    self.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:97.0/255 green:87.0/255 blue:76.0/255 alpha:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
