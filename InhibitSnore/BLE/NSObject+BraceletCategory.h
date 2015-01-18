#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "PersonalInfo.h"
@interface NSObject (BaseControllerViewEx)
#pragma mark - 发送外射消息
//手机连接确认命令
-(NSMutableData *)connSuccess;
//手机下发固件升级命令
-(NSMutableData *)fwUpdate;
//设备信息查询/设置命令
-(NSMutableData *)selectfwVersion;
//厂商信息查询
-(NSMutableData *)selectfactoryMsg;
//设备蓝牙信息查询、设置
-(NSMutableData *)selectBLEMsg;
//设备灵敏度信息查询、设置  灵敏度 123  制鼾 123
-(NSMutableData *)selectBLEKeenandSettinglingmingdu:(int)linmingdu zhihanqiangdu:(int)zhihanqiangdu;
//电量查询命令
-(NSMutableData *)selectBLEBattery;
//时间设置
-(NSMutableData *)setTime;
//指示灯开关设置 0/1 kaiguan
-(NSMutableData *)setLightOnOff:(int) onoff;
//实时监测命令
-(NSMutableData *)writeMonitorCMD;
//同步命令
-(NSMutableData *)writeSynCMD;
#pragma mark - 获取当前时间的 年，月，日，时，分，秒
-(NSDateComponents *)getnowTime;
-(NSString *)getNextDate:(NSString *)timeStr;
-(NSString *)getFrontDate:(NSString *)timeStr;

-(int)getnextYear:(NSString *)strDate;
-(int)getnextMonth:(NSString *)strDate;
-(int)getnextDay:(NSString *)strDate;

-(NSString * )getStringDate:(NSDate *) date;
-(int)getnowYear;
-(int)getnowMonth;
-(int)getnowDay;
-(int)getnowHour;
-(int)getnowMinute;
-(int)getnowSecond;
-(int)getweek;
#pragma mark - 十六进制转换成十进制 一个字节
-(NSString *)stringForData1:(NSData *)data;
//两个字节
-(NSString *)stringForData2:(NSData *)data;

#pragma mark - CRC16计算方法(注意是16位)
uint16_t com_crc(uint8_t *msg,uint8_t length);
uint16_t Alarm(Byte hour, Byte minute, Byte isSmart);

#pragma mark -  获取开始同步所需的时间
-(NSArray *)starSynData;

#pragma mark - sqlite meth

-(FMDatabase *)FMdata;
-(NSMutableData *)synNowDate;
-(NSMutableArray *)retunPersonalInfo;
-(void)savePersonalInfo:(PersonalInfo *)info;
-(NSMutableData *)writebufaSetting:(float) shengao;
-(int)getdangqiangMonthdays;//获取当前月份返回的天数
-(float)getKm:(int) sportStep sportminute :(int) sportminute shengao:(float) shenggao;//获取运动距离
-(NSMutableArray *)getDatefromweek:(int) week;//获取当前日前的 前面的星期天数
-(NSMutableArray *)getDateforMonth:(int) day;//获取截止到当前的当月的前面的日期


-(NSMutableArray *)retunDeviceInfo:(NSString *)where;
-(NSMutableArray *)retunsynForDay:(NSString *)where;
-(NSMutableArray *)retunResolveForDay:(NSString *)where;
-(NSMutableArray *)retunPersonalInfoytt:(NSString *)where;
-(NSMutableArray *)retunsynForZuihouyitiao;//返回数据库中最后一条



//返回每天的原始数据 软后计算所有的 步数  km  kll
-(NSMutableArray *)retunSomeDayCountStep:(int) date ;

@end
