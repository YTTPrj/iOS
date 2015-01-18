//
//  ResolveDataInfo.h
//  Bracelet
//
//  Created by wu.xiong on 14-4-11.
//  Copyright (c) 2014年 wu.xiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResolveDataInfo : NSObject


@property(nonatomic,retain)NSString *staryear;
@property(nonatomic,retain)NSString *starmonth;
@property(nonatomic,retain)NSString *starday;
@property(nonatomic,retain)NSString *starminute;

@property(nonatomic,retain)NSString *endyear;
@property(nonatomic,retain)NSString *endmonth;
@property(nonatomic,retain)NSString *endday;
@property(nonatomic,retain)NSString *endminute;

@property(nonatomic,retain)NSString *flag;
@property(nonatomic,retain)NSString *actionIndex;
@property(nonatomic,retain)NSString *actionMinute;

@end
