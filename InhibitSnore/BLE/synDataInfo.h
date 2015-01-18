
#import <Foundation/Foundation.h>

@interface synDataInfo : NSObject

@property(nonatomic,retain)NSString *year;
@property(nonatomic,retain)NSString *month;
@property(nonatomic,retain)NSString *day;
@property(nonatomic,retain)NSString *minute;
@property(nonatomic,retain)NSString *flag;
@property(nonatomic,retain)NSString *actionIndex;//运动指数  1，如果是睡眠就是表示 每分钟 睡眠的活动量     2 ， 如果运动就是表示每分钟走的步数
@end
//改动………………………………