
#import "NSObject+BraceletCategory.h"
#import "PersonalInfo.h"
#import "synDataInfo.h"
#import "DeviceInfo.h"
#import "ResolveDataInfo.h"
@implementation NSObject (BaseControllerViewEx)

#pragma mark - 发送外射消息
//手机连接确认命令
-(NSMutableData *)connSuccess{
    //手机连接确认命令
    Byte byte[5]={0x0A,0x12,0x00,0x5a,0x5a};
    NSMutableData *notifyData=[[NSMutableData alloc]initWithBytes:&byte length:5];
    return notifyData;
}
//手机下发固件升级命令
-(NSMutableData *)fwUpdate{
    Byte byte[3]={0x0A,0x11,0x00};
    NSMutableData *notifyData=[[NSMutableData alloc]initWithBytes:&byte length:3];
    return notifyData;
}
//设备信息查询/设置命令
-(NSMutableData *)selectfwVersion{
    Byte byte[3]={0x0A,0x13,0x00};
    NSMutableData *notifyData=[[NSMutableData alloc]initWithBytes:&byte length:3];
    return notifyData;
}
//厂商信息查询
-(NSMutableData *)selectfactoryMsg{
    Byte byte[3]={0x0A,0x14,0x00};
    NSMutableData *notifyData=[[NSMutableData alloc]initWithBytes:&byte length:3];
    return notifyData;
}
//设备蓝牙信息查询、设置
-(NSMutableData *)selectBLEMsg{
    
    Byte byte[3]={0x0A,0x15,0x00};
    NSMutableData *notifyData=[[NSMutableData alloc]initWithBytes:&byte length:3];
    return notifyData;
    
}
//设备灵敏度信息查询、设置  灵敏度 123  制鼾 123
-(NSMutableData *)selectBLEKeenandSettinglingmingdu:(int)linmingdu zhihanqiangdu:(int)zhihanqiangdu{
    
    Byte byte[5]={0x0A,0x16,0x00,linmingdu,zhihanqiangdu};
    NSMutableData *notifyData=[[NSMutableData alloc]initWithBytes:&byte length:5];
    return notifyData;
}
//电量查询命令
-(NSMutableData *)selectBLEBattery{
    Byte byte[3]={0x0A,0x17,0x00};
    NSMutableData *notifyData=[[NSMutableData alloc]initWithBytes:&byte length:3];
    return notifyData;
}
//时间设置
-(NSMutableData *)setTime{
    NSString * str = [NSString stringWithFormat:@"%d",[self getnowYear]];
    int year = [[str substringWithRange:NSMakeRange(2, 2)] intValue];
    Byte byte[9]={
        0x0A,
        0x18,
        0x00,
        year,
        [self getnowMonth],
        [self getnowDay],
        [self getnowHour],
        [self getnowMinute],
        [self getnowSecond]
    };
    NSMutableData *notifyData=[[NSMutableData alloc]initWithBytes:&byte length:9];
    return notifyData;

}
//指示灯开关设置 0/1 kaiguan   guan/kai
-(NSMutableData *)setLightOnOff:(int) onoff{
    Byte byte[3]={0x0A,0x19,onoff};
    NSMutableData *notifyData=[[NSMutableData alloc]initWithBytes:&byte length:3];
    return notifyData;
}
//实时监测命令 cmd  0/1
-(NSMutableData *)writeMonitorCMD:(int) cmd{
    Byte byte[3]={0x0A,0x21,cmd};
    NSMutableData *notifyData=[[NSMutableData alloc]initWithBytes:&byte length:3];
    return notifyData;
}
//同步命令
-(NSMutableData *)writeSynCMD:(int) cmd {
    Byte byte[3]={0x0A,0x22,cmd};
    NSMutableData *notifyData=[[NSMutableData alloc]initWithBytes:&byte length:3];
    return notifyData;
    
}


#pragma mark - 十六进制转换成十进制 一个字节
-(NSString *)stringForData1:(NSData *)data{
    uint8_t* a = (uint8_t*) [data bytes];
    NSString *str=[NSString stringWithFormat:@"%d",*a];
    return str;
}
//两个字节
-(NSString *)stringForData2:(NSData *)data{
    
    uint8_t bytesa[2] = {0};
    uint8_t* p_a = (uint8_t*) [data bytes];
    bytesa[0] = *(p_a + 1);
    bytesa[1] = *p_a;
    
    uint16_t *a=(uint16_t *)bytesa;
    NSString *timestr=[NSString stringWithFormat:@"%d",*a];
    return timestr;
}

#pragma mark - 获取当前时间的 年，月，日，时，分，秒
-(NSDateComponents *)getnowTime{
    
    //获取当前时间
    NSDate * startDate = [[NSDate alloc] init];
    NSCalendar * chineseCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit |
    NSSecondCalendarUnit | NSDayCalendarUnit  |
    NSMonthCalendarUnit | NSYearCalendarUnit|NSWeekdayCalendarUnit;
    NSDateComponents * cps = [chineseCalendar components:unitFlags fromDate:startDate];
    return cps;
    
}

-(NSString *)getNextDate:(NSString *)timeStr{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YY-M-d"]; //-设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    [formatter setTimeZone:GTMzone];
    NSDate* showDate = [formatter dateFromString:timeStr]; //-将字符串按formatter转成nsdate
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps;
    comps = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:[[NSDate alloc] init]];
    
    [comps setHour:+24]; //+24表示获取下一天的date，-24表示获取前一天的date；
    
    //showDate表示某天的date，nowDate表示showDate的前一天或下一天的date
    NSDate *nowDate = [calendar dateByAddingComponents:comps toDate:showDate options:0];
    
    NSString *strdate=[formatter stringFromDate:nowDate];
    
    return strdate;
}


-(NSString *)getFrontDate:(NSString *)timeStr{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YY-M-d"]; //-设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    [formatter setTimeZone:GTMzone];
    
    NSDate* showDate = [formatter dateFromString:timeStr]; //-将字符串按formatter转成nsdate
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps;
    comps = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:[[NSDate alloc] init]];
    
    [comps setHour:-24]; //+24表示获取下一天的date，-24表示获取前一天的date；
    
    //showDate表示某天的date，nowDate表示showDate的前一天或下一天的date
    NSDate *nowDate = [calendar dateByAddingComponents:comps toDate:showDate options:0];
    
    NSString *strdate=[formatter stringFromDate:nowDate];
    
    return strdate;
}
-(NSString * )getStringDate:(NSDate *) date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
   
    return destDateString;

}

//获取当前的月份的天数
-(int)getdangqiangMonthdays{
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSRange range = [calender rangeOfUnit:NSDayCalendarUnit inUnit: NSMonthCalendarUnit
                                  forDate: [NSDate date]];

    return range.length;
}


-(float)getKm:(int) sportStep sportminute :(int) sportminute shengao:(float) shenggao{
    
    float km = 0;
    int  avg =sportStep/sportminute;
    if (avg>0 && avg<=60) {
        
        km=(shenggao*0.3*sportStep)/1000.0;
    }
    if (avg>60 && avg<=90) {
        km=(shenggao*0.3*sportStep)/1000.0;
        
    }if (avg>90 && avg<=120) {
        km=(shenggao*0.4*sportStep)/1000.0;
        
    }if (avg>120 && avg<=150) {
        km=(shenggao*0.55*sportStep)/1000.0;
        
    }if (avg>150 && avg<=180) {
        km=(shenggao*0.78*sportStep)/1000.0;
        
    }if (avg>180 && avg<=240) {
        km=(shenggao*0.78*sportStep)/1000.0;
        
    }if (avg>240) {
        km=(shenggao*0.78*sportStep)/1000.0;
    }
    return  km;
}



-(NSMutableArray *)getDatefromweek:(int) week{
    
    NSMutableArray * arrdates= [[NSMutableArray alloc] init];
    int p = 0;
    
    p=(week-1+7)%7;
    if (p == 0)
    {
        p = 7;
    }
    for (int i = p; i>0; i--) {
        NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow: -(24*60*60)*(i-1) ];
        [arrdates addObject:[self getStringDate:yesterday]];
    }
    
    return arrdates;
    
}

-(NSMutableArray *)getDateforMonth:(int) day{
    
    NSMutableArray * arreveryDay = [[NSMutableArray alloc] init];
    for (int i = day; i>0; i--) {//从前一天开始
        
        
        NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow: -(24*60*60)*(i-1) ];
        
        [arreveryDay addObject:[self getStringDate:yesterday]];
    }
    return arreveryDay;
}


-(int)getnextYear:(NSString *)strDate{
    
    NSArray *arrdate = [strDate componentsSeparatedByString:@"-"];
    return [[arrdate objectAtIndex:0]intValue];
}

-(int)getnextMonth:(NSString *)strDate{
    
    NSArray *arrdate = [strDate componentsSeparatedByString:@"-"];
    return [[arrdate objectAtIndex:1]intValue];
}

-(int)getnextDay:(NSString *)strDate{
    
    NSArray *arrdate = [strDate componentsSeparatedByString:@"-"];
    return [[arrdate objectAtIndex:2]intValue];
}



-(int)getnowYear{
    
    NSString *str=[[NSString stringWithFormat:@"%d",(int)[[self getnowTime] year]]substringFromIndex:2];
    return [str intValue];
}
-(int)getnowMonth{
    return (int)[[self getnowTime]month];
}
-(int)getnowDay{
    return (int)[[self getnowTime]day];
}
-(int)getnowHour{
    return (int)[[self getnowTime]hour];
}
-(int)getnowMinute{
    return (int)[[self getnowTime]minute];
}
-(int)getnowSecond{
    return (int)[[self getnowTime]second];
}

-(int)getweek{
    
    return (int)([[self getnowTime] weekday]);
}

#pragma mark -  获取开始同步所需的时间
-(NSArray *)starSynData{
    
    NSMutableArray *synArrs=[[NSMutableArray alloc]init];
    NSString *sql=@" order by _id desc limit 1";
    
    NSArray *synArr=[self retunsynForDay:sql];
    
    if (synArr.count>0) {
        synDataInfo *info=[synArr objectAtIndex:0];
        [synArrs addObjectsFromArray:[self syningData:info]];
    }
    return synArrs;
}

-(NSArray *)syningData:(synDataInfo *)info{
    
    int lastyear=[info.year intValue];
    int lastmonth=[info.month intValue];
    int lastday=[info.day intValue];
    int lastminute=[info.minute intValue]+1;
    
    if (lastminute >=1440) {//进行下一天处理
        NSString* timeStr =[NSString stringWithFormat:@"%d-%d-%d",lastyear,lastmonth,lastday];
        NSString *strdate=[self getNextDate:timeStr];
        lastyear=[self getnextYear:strdate];
        lastmonth=[self getnextMonth:strdate];
        lastday=[self getnextDay:strdate];
        lastminute=0;
    }
    
    NSArray *arrs=[NSArray arrayWithObjects:[NSNumber numberWithInt:lastyear],
                   [NSNumber numberWithInt:lastmonth],
                   [NSNumber numberWithInt:lastday],
                   [NSNumber numberWithInt:lastminute], nil];
    
    return arrs;
}

#pragma mark - CRC16计算方法(注意是16位)
uint16_t CRCTALBES[] ={
    
    0x0000, 0xCC01, 0xD801, 0x1400,
    0xF001, 0x3C00, 0x2800, 0xE401,
    0xA001, 0x6C00, 0x7800, 0xB401,
    0x5000, 0x9C01, 0x8801, 0x4400
};

uint16_t com_crc(uint8_t *msg,uint8_t length){
    
    uint16_t crc = 0xFFFF;
    uint8_t i;
    uint8_t chChar;
    
    for (i = 0; i < length; i++){
        chChar = *msg++;
        crc  = CRCTALBES[(chChar ^ crc) & 15] ^ (crc >> 4);
        //NSLog(@"crc %hu",crc);
        crc = CRCTALBES[((chChar >> 4) ^ crc) & 15] ^ (crc >> 4);
    }
    return NSSwapBigShortToHost(crc);
}

uint16_t Alarm(Byte hour, Byte minute, Byte isSmart) {
    
    uint16_t result = ((uint16_t)hour << 10) & 0xFC00;
    result |= ((uint16_t)minute << 4) & 0x03f0;
    result |= isSmart & 0x000f;
    return result;
    
    
}



#pragma mark - sqlite meth
-(FMDatabase *)FMdata{
    
    FMDatabase *data=[FMDatabase databaseWithPath:SqlitePath];
    return data;
}

-(NSMutableArray *)saveSynData{
    
    return nil;
}

-(void)savePersonalInfo:(PersonalInfo *)info{
    
    FMDatabase *data= [self FMdata];
    [data open];
    
    [data executeUpdate:@"delete from PersonalInfo"];
    [data executeUpdate:@"insert into PersonalInfo (userName,password,nikeName,image,height,weight,walk)values (?,?,?,?,?,?,?)",info.userName,info.password,info.nikeName,info.image,info.height,info.weight,info.walk];
    [data close];
    
    
}

-(NSMutableArray *)retunPersonalInfo{
    
    FMDatabase *data= [self FMdata];
    [data open];
    
    NSMutableArray *arr=[[NSMutableArray alloc]initWithCapacity:1440];
    NSString *sql=@"select userName,password,nikeName,image,sex,height,weight,heightUnit,weightUnit,birthday,walk,jogg,calorie,sleepTime,sleeplong,PerUUID,DeviceUUID from PersonalInfo";
    
    FMResultSet *rs=[data executeQuery:sql];
    
    while ([rs next]) {
        
        PersonalInfo *per=[[PersonalInfo alloc]init];
        per.userName=[rs stringForColumn:@"userName"];
        per.password=[rs stringForColumn:@"password"];
        per.nikeName=[rs stringForColumn:@"nikeName"];
        per.image=[rs stringForColumn:@"image"];
        per.sex=[rs stringForColumn:@"sex"];
        per.height=[rs stringForColumn:@"height"];
        per.weight=[rs stringForColumn:@"weight"];
        per.heightUnit=[rs stringForColumn:@"heightUnit"];
        per.weightUnit=[rs stringForColumn:@"weightUnit"];
        per.birthday=[rs stringForColumn:@"birthday"];
        per.walk=[rs stringForColumn:@"walk"];
        per.jogg=[rs stringForColumn:@"jogg"];
        per.calorie=[rs stringForColumn:@"calorie"];
        per.sleepTime=[rs stringForColumn:@"sleepTime"];
        per.sleeplong=[rs stringForColumn:@"sleeplong"];
        per.PerUUID=[rs stringForColumn:@"PerUUID"];
        per.DeviceUUID=[rs stringForColumn:@"DeviceUUID"];
        
        [arr addObject:per];
    }
    [rs close];
    [data close];
    return  arr;
}

-(NSMutableArray *)retunPersonalInfoytt:(NSString *)where{
    
    FMDatabase *data= [self FMdata];
    [data open];
    NSMutableArray *arr=[[NSMutableArray alloc]initWithCapacity:1440];
    NSString *sql=@"select userName,password,nikeName,image,sex,height,weight,heightUnit,weightUnit,birthday,walk,jogg,calorie,sleepTime,sleeplong,PerUUID,DeviceUUID from PersonalInfo";
    
    NSString *wheres=[NSString stringWithFormat:@"%@ %@",sql,where];
    FMResultSet *rs=[data executeQuery:wheres];
    while ([rs next]) {
        
        PersonalInfo *per=[[PersonalInfo alloc]init];
        per.userName=[rs stringForColumn:@"userName"];
        per.password=[rs stringForColumn:@"password"];
        per.nikeName=[rs stringForColumn:@"nikeName"];
        per.image=[rs stringForColumn:@"image"];
        per.sex=[rs stringForColumn:@"sex"];
        per.height=[rs stringForColumn:@"height"];
        per.weight=[rs stringForColumn:@"weight"];
        per.heightUnit=[rs stringForColumn:@"heightUnit"];
        per.weightUnit=[rs stringForColumn:@"weightUnit"];
        per.birthday=[rs stringForColumn:@"birthday"];
        per.walk=[rs stringForColumn:@"walk"];
        per.jogg=[rs stringForColumn:@"jogg"];
        per.calorie=[rs stringForColumn:@"calorie"];
        per.sleepTime=[rs stringForColumn:@"sleepTime"];
        per.sleeplong=[rs stringForColumn:@"sleeplong"];
        per.PerUUID=[rs stringForColumn:@"PerUUID"];
        per.DeviceUUID=[rs stringForColumn:@"DeviceUUID"];
        
        [arr addObject:per];
    }
    [rs close];
    [data close];
    return  arr;
}

-(NSMutableArray *)retunDeviceInfo:(NSString *)where{
    
    FMDatabase *data= [self FMdata];
    [data open];
    
    NSMutableArray *arr=[[NSMutableArray alloc]initWithCapacity:1440];
    
    NSString *sql=@"select userName,UUID,DeviceUUID,DeviceName from DeviceInfo ";
    NSString *wheres=[NSString stringWithFormat:@"%@ %@",sql,where];
    
    FMResultSet *rs=[data executeQuery:wheres];
    
    while ([rs next]) {
        
        DeviceInfo *device=[[DeviceInfo alloc]init];
        
        device.userName=[rs stringForColumn:@"userName"];
        device.UUID=[rs stringForColumn:@"UUID"];
        device.DeviceUUID=[rs stringForColumn:@"DeviceUUID"];
        device.DeviceName=[rs stringForColumn:@"DeviceName"];
        [arr addObject:device];
    }
    [rs close];
    [data close];
    return  arr;
}

-(NSMutableArray *)retunResolveForDay:(NSString *)where{
    
    FMDatabase *data= [self FMdata];
    [data open];
    
    NSMutableArray *arr=[[NSMutableArray alloc]initWithCapacity:1440];
    NSString *sql=@"select distinct starYear,endYear,starMonth,endMonth,starDay,endDay,starMinute,endMinute,flag,actionIndex,actionMinute from Resolve";
    NSString *wheres=[NSString stringWithFormat:@"%@ %@",sql,where];
    //NSLog(@"NsobjectBracele---------单天的---------------%@",wheres);
    FMResultSet *rs=[data executeQuery:wheres];
    
    while ([rs next]) {
        
        ResolveDataInfo *resolve=[[ResolveDataInfo alloc]init];
        resolve.staryear=[rs stringForColumn:@"starYear"];
        resolve.endyear=[rs stringForColumn:@"endYear"];
        resolve.starmonth=[rs stringForColumn:@"starMonth"];
        resolve.endmonth=[rs stringForColumn:@"endMonth"];
        resolve.starday=[rs stringForColumn:@"starDay"];
        resolve.endday=[rs stringForColumn:@"endDay"];
        resolve.starminute=[rs stringForColumn:@"starMinute"];
        resolve.endminute=[rs stringForColumn:@"endMinute"];
        resolve.flag=[rs stringForColumn:@"flag"];
        resolve.actionIndex=[rs stringForColumn:@"actionIndex"];
        resolve.actionMinute=[rs stringForColumn:@"actionMinute"];
        
        [arr addObject:resolve];
    }
    [rs close];
    [data close];
    //NSLog(@"Nsobject+tracelet-----------arr--------%@",arr);
    return  arr;
}



-(NSMutableArray *)retunsynForDay:(NSString *)where{

    
    FMDatabase *data= [self FMdata];
    [data open];
    NSMutableArray *arr=[[NSMutableArray alloc]initWithCapacity:1440];
    NSString *sql=[NSString stringWithFormat:@"SELECT Year,Month,Day,Minute,Flag,actionIndex FROM SynData %@ ",where];/*and Flag =1*/
    //NSLog(@"----------------------sql----------%@",sql);
    FMResultSet *rs=[data executeQuery:sql];
    while ([rs next]){
        synDataInfo *info=[[synDataInfo alloc]init];
        info.year=[rs stringForColumn:@"Year"];
        info.month=[rs stringForColumn:@"Month"];
        info.day=[rs stringForColumn:@"Day"];
        info.minute=[rs stringForColumn:@"Minute"];
        info.flag=[rs stringForColumn:@"Flag"];
        info.actionIndex=[rs stringForColumn:@"actionIndex"];
        [arr addObject:info];
    }
    [rs close];
    [data close];
    return  arr;

}

//返回每天实际的 数据
-(NSMutableArray *)retunSomeDayCountStep:(int) date {
    
    FMDatabase *data= [self FMdata];
    [data open];
    
    NSMutableArray *arr=[[NSMutableArray alloc]initWithCapacity:1440];
    NSString *sql=[NSString stringWithFormat:@"select * from SynData where  dateTime = %d ",date];
    FMResultSet *rs=[data executeQuery:sql];
    while ([rs next]){
        synDataInfo *info=[[synDataInfo alloc]init];
        info.year=[rs stringForColumn:@"Year"];
        info.month=[rs stringForColumn:@"Month"];
        info.day=[rs stringForColumn:@"Day"];
        info.minute=[rs stringForColumn:@"Minute"];
        info.flag=[rs stringForColumn:@"Flag"];
        info.actionIndex=[rs stringForColumn:@"actionIndex"];
        [arr addObject:info];
    }
    [rs close];
    [data close];
    
    return  arr;

}



/*-------------------*/

//邮箱
-(BOOL) validateEmail:(NSString *)email
{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
    
}

 
@end
