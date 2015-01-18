//
//  PersonalInfo.h
//  Bracelet
//
//  Created by wu.xiong on 14-4-13.
//  Copyright (c) 2014年 wu.xiong. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface PersonalInfo : NSObject

@property(nonatomic,retain)NSString *userName;
@property(nonatomic,retain)NSString *password;
@property(nonatomic,retain)NSString *nikeName;
@property(nonatomic,retain)NSString *image;

@property(nonatomic,retain)NSString *sex;
@property(nonatomic,retain)NSString *height;
@property(nonatomic,retain)NSString *weight;
@property(nonatomic,retain)NSString *heightUnit;

@property(nonatomic,retain)NSString *weightUnit;
@property(nonatomic,retain)NSString *birthday;
@property(nonatomic,retain)NSString *walk;

@property(nonatomic,retain)NSString *jogg;
@property(nonatomic,retain)NSString *calorie;
@property(nonatomic,retain)NSString *sleepTime;
@property(nonatomic,retain)NSString *sleeplong;
@property(nonatomic,retain)NSString *PerUUID;
@property(nonatomic,retain)NSString *DeviceUUID;

@end
