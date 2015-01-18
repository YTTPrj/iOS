

#import "BluetoothFramework.h"
#import "AppDelegate.h"
@implementation BluetoothFramework
@synthesize centralManager;
@synthesize discoverPerArrays;
@synthesize characteristicArrays;
@synthesize delegate;
@synthesize myperipheral;
@synthesize mycharacteristic;
@synthesize strUUID;
@synthesize imageversion=_imageversion;

id CTTelephonyCenterGetDefault(void);
void CTTelephonyCenterAddObserver(id,id,CFNotificationCallback,NSString*,void*,int);


static BluetoothFramework *bluetooth=nil;
+(BluetoothFramework *)Singleton{
    @synchronized(bluetooth){
        if (!bluetooth) {
            bluetooth=[[BluetoothFramework alloc]initWithcentralManager];
        }
        return bluetooth;
    }
}

#pragma mark - 实例化中央服务
- (id)initWithcentralManager{
    
    self = [super init];
    if (self){
        
        if (!self.centralManager){
            self.centralManager=[[CBCentralManager alloc]initWithDelegate:self queue:dispatch_get_main_queue()];
        }
        if (!self.discoverPerArrays) {
            self.discoverPerArrays=[[NSMutableArray alloc]init];
        }
        if (!self.characteristicArrays){
            self.characteristicArrays=[[NSMutableArray alloc]init];
        }
        
        self.strUUID=@"";
        NSArray *deviceArr = [self retunDeviceInfo:@" where 1=1"];
        if (deviceArr && deviceArr.count>0) {
            //DeviceInfo *deviceInfo=[deviceArr objectAtIndex:0];
            //self.strUUID=deviceInfo.UUID;
        }
        //拦截短信通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(SMSMessageReceived)
                                                     name:@"SMSMessageReceived" object:nil];
    }
    
    return self;
}

-(void)SMSMessageReceived{
    
    //NSLog(@"[短信监听事件]");
    //[[BluetoothFramework Singleton]writeValueForFFF3:[self writeNotifyvalue:1]];
}



//开始扫瞄
-(void)scanForPer{
    
    NSDictionary *options = [NSDictionary
                             dictionaryWithObject:[NSNumber numberWithBool:NO]
                             forKey:CBCentralManagerScanOptionAllowDuplicatesKey];
    //NSLog(@"开始扫瞄外围设备");
	[self.centralManager scanForPeripheralsWithServices:ServicesUUIDs options:options];
}

//停止扫瞄
-(void)stopScanForPer{
    //NSLog(@"停止扫瞄");
    [self.centralManager stopScan];
}

-(void)didReconnUsePer:(CBPeripheral *)peripheral{
    
    [self.centralManager connectPeripheral:peripheral options:nil];
    
}


//连接
-(void)didConnection:(NSArray *)pers{
    
    if (pers && [pers count]>0){
        
        for (NSString *perID in pers) {
            for (CBPeripheral *p in self.discoverPerArrays) {
                if ([/*[self getUUID:p.UUID]*/
                     [p.identifier UUIDString]  isEqualToString:perID]) {
//                    if (!p.isConnected){
//                        [self.centralManager connectPeripheral:p options:nil];
//                    }
                    if (p.state ==0){
                        [self.centralManager connectPeripheral:p options:nil];
                    }
                }
            }
        }
    }
}

-(void)didDisconnection:(NSString *)persUUID{
    
    for (CBPeripheral *p in self.discoverPerArrays) {
        if ([/*[self getUUID:p.UUID]*/ [p.identifier UUIDString] isEqualToString:persUUID]) {
            if (p.state !=0){
//                [self.centralManager connectPeripheral:p options:nil];
                [self.centralManager cancelPeripheralConnection:p];
            }
        }
    }
}

//写入数值
-(void)writeValueForFFF3:(NSMutableData *)writevalue{
    
    
    [self.writePeripheral writeValue:writevalue
                   forCharacteristic:self.writeCharacteristic
                                type:CBCharacteristicWriteWithResponse];
    
}

#pragma mark - ====== centralManager methods and delegate ======


//发现外围设备
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    
        NSString *perName=@"Cyberlink";
        if ([perName isEqualToString:peripheral.name]) {
            
            if (![self.discoverPerArrays containsObject:peripheral]) {
                
                [self.discoverPerArrays addObject:peripheral];
                if (self.delegate &&[self.delegate respondsToSelector:@selector(didDiscoverPeripheral:)]){
                    
                    [self.delegate didDiscoverPeripheral:[self getperInfo:peripheral]];
                    
                }
            }
        }
}
- (void) peripheralDidUpdateRSSI:(CBPeripheral *)peripheral error:(NSError *)error
{
    
    NSLog(@"Rssi-------Rssi-------------%f", [[peripheral RSSI] floatValue]);
    
}



//连接外围设备
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    boolReading=YES;
    NSLog(@"已连接设备UUID :%@",[peripheral.identifier UUIDString]);
    AppDelegate * app = (AppDelegate *)[[UIApplication sharedApplication ] delegate];
    app.conntcedPER = peripheral;
    
    if (self.strUUID.length<2) {
        self.strUUID =[peripheral.identifier UUIDString];
    }
    if (timer) {
        [timer invalidate];
    }
    [timerRssi invalidate];
    timerRssi = [NSTimer timerWithTimeInterval:0.5 target:peripheral selector:@selector(readRSSI)    userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timerRssi forMode:NSRunLoopCommonModes];
    
    //绑定
    if ([self.delegate conformsToProtocol:@protocol(perDelegate)]){
        
        [self.delegate didConnectPeripheral:[self getperInfo:peripheral]];
    
    }
    peripheral.delegate=self;
    [peripheral discoverServices:nil];//这个方法调用发现服务协议
 
}

//检查本机设备的蓝牙状态
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
    switch (central.state) {
        case CBCentralManagerStatePoweredOff:
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getPerStatu" object:@"no"];
            NSLog(@"CoreBluetooth BLE hardware is powered off");
            break;
        case CBCentralManagerStatePoweredOn:
            [self scanForPer];
            NSLog(@"CoreBluetooth BLE hardware is powered on and ready");
            break;
        case CBCentralManagerStateResetting:
            NSLog(@"CoreBluetooth BLE hardware is resetting");
            break;
        case CBCentralManagerStateUnauthorized:
            NSLog(@"CoreBluetooth BLE state is unauthorized");
            break;
        case CBCentralManagerStateUnknown:
            NSLog(@"CoreBluetooth BLE state is unknown");
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@"CoreBluetooth BLE hardware is unsupported on this platform");
            break;
        default:
            break;
            
    }
    
}
//断开连接
-(void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    

    if ([self.delegate conformsToProtocol:@protocol(perDelegate)]){
        [self.delegate didDisconnectPeripheral:[self getperInfo:peripheral]];
    }
    
    if (timerdisconn) {
        [timerdisconn invalidate];
    }
    timerdisconn = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(connn)    userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timerdisconn forMode:NSRunLoopCommonModes];
    
  
    [[NSNotificationCenter defaultCenter] postNotificationName:@"getPerStatu" object:@"no"];
    
}

//连接失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    
    boolReading=NO;
    if ([self.delegate conformsToProtocol:@protocol(perDelegate)]){
        [self.delegate didFailToConnectPeripheral:[self getperInfo:peripheral]];
    }
}

#pragma mark - ====== peripheral methods and delegate ======
//发现服务
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    
    for (CBService *service in [peripheral services]){
        [peripheral discoverCharacteristics:charUUIDs forService:service];
    }
    
}

//发现特性
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    
    for (CBCharacteristic *ch in [service characteristics]) {
        
        if ([ch.UUID isEqual:[CBUUID UUIDWithString:@"6E400003-B5A3-F393-E0A9-E50E24DCCA9E"]]){//返回数据
            self.readPeripheral=peripheral;
            self.readCharacteristic=ch;
            //监听事件
            [self.readPeripheral setNotifyValue:YES forCharacteristic:self.readCharacteristic];
        }
        if ([ch.UUID isEqual:[CBUUID UUIDWithString:@"6E400002-B5A3-F393-E0A9-E50E24DCCA9E"]]){//写入数据
            self.writePeripheral=peripheral;
            self.writeCharacteristic=ch;
            NSLog(@"-----------002----发现写入通道--发送读取devieid指令---并且发送同步时间指令");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getPerStatu" object:@"yes"];
        }
        
    }
}

//读取指定特性的数据
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"6E400003-B5A3-F393-E0A9-E50E24DCCA9E"]]){//返回数据

        if (self.delegate &&[self.delegate respondsToSelector:@selector(didConnectPeripheral:values:)]){
            //获取 数据 type
            NSRange range=NSMakeRange(2, 1);
            NSData *data=[characteristic.value subdataWithRange:range];
            int type=[[self stringForData1:data]intValue];
            if (type == 7) {
                //返回deviceID 上传服务器并绑定
                [self.delegate didConnectPeripheral:[self getperInfo:peripheral] values:characteristic.value];
            }
            [self.delegate returnValueForNotify:characteristic.value];

            if (type==21) {//手环固件版本
                
                self.imageversion = nil;
                range=NSMakeRange(4, 4);
                data=[characteristic.value subdataWithRange:range];
                self.imageversion = data;
                Byte * bytes = (Byte*)[data bytes];
                int intfours =bytes[3];
                int inttheres =bytes[2];
                int inttwos =bytes[1];
                int intones =bytes[0];
                if (intfours>200 || inttheres>200||inttwos>200 || intones>200) {
                    
                    UIAlertView * alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"检测到版本异常，请立即去设置界面修复升级." delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                    alt.tag = 10000;
                    [alt show];
                    
                }else{
                    //获取到手环的版本号 后从服务器请求获取版本号
                    //[self getimagevsersion];
                }
                
            }
        }
    }
    
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A26"]]){//返回数据
            NSUserDefaults * us  =  [NSUserDefaults standardUserDefaults];
            NSString * str = [NSString stringWithFormat:@"%s",characteristic.value.bytes];
            //保存蓝牙版本号
            [us setObject:str forKey:@"BTversion"];
    }
}


//对蓝牙设备写入数据
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
}


-(NSDictionary *)getperInfo:(CBPeripheral *)per{
    
    NSString *uuID=[per.identifier UUIDString];//[self getUUID:per.UUID];
    NSString *name=per.name;
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:name,@"name",uuID,@"UUID",@"per",per, nil];
    return dic;
}

#pragma mark - 转化UUID格式
-(const char *) UUIDToString:(CFUUIDRef)UUID{
    
    if (!UUID) return "NULL";
    CFStringRef s = CFUUIDCreateString(NULL, UUID);
    return CFStringGetCStringPtr(s, 0);
    
}
-(NSString *)getUUID:(CFUUIDRef)UUID{
    
    NSString *uuid=[NSString stringWithCString:[self UUIDToString:UUID]
                                      encoding:NSUTF8StringEncoding];
    return uuid;
}

@end
