//
//  DeviceInfo.h
//  Bracelet
//
//  Created by wu.xiong on 14-4-13.
//  Copyright (c) 2014年 wu.xiong. All rights reserved.
//

#import <Foundation/Foundation.h>
//改动
@interface DeviceInfo : NSObject

@property(nonatomic,retain)NSString *userName;
@property(nonatomic,retain)NSString *UUID;
@property(nonatomic,retain)NSString *DeviceUUID;
@property(nonatomic,retain)NSString *DeviceName;

@end
