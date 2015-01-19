//
//  AboutTableViewCell.m
//  InhibitSnore
//
//  Created by FZY on 15/1/19.
//  Copyright (c) 2015年 FZY. All rights reserved.
//

#import "AboutTableViewCell.h"

@implementation AboutTableViewCell

- (void)awakeFromNib {
    // Initialization code
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.backgroundColor = [UIColor whiteColor];
    self.selectedBackgroundView = imageView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
