

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
//3 -----NOTIFY     2 -----WRITE
#define ServicesUUIDs [NSArray arrayWithObjects:[CBUUID UUIDWithString:@"6E400001-B5A3-F393-E0A9-E50E24DCCA9E"], nil]
#define charUUIDs [NSArray arrayWithObjects:[CBUUID UUIDWithString:@"6E400002-B5A3-F393-E0A9-E50E24DCCA9E"],[CBUUID UUIDWithString:@"6E400003-B5A3-F393-E0A9-E50E24DCCA9E"],nil]


@protocol perDelegate;
@interface BluetoothFramework : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate,UIAlertViewDelegate>{
    
    NSTimer * timerRssi;
    NSTimer *timer;
    NSTimer *readTimer;
    BOOL boolReading;
    NSTimer * timerdisconn;
    
}

@property(nonatomic,strong) NSData *imageversion;

@property(nonatomic,assign)id<perDelegate>delegate;

@property(nonatomic,retain)CBCentralManager *centralManager;//中央服务
@property(nonatomic,retain)NSMutableArray *discoverPerArrays;//连接外围设备数组
@property(nonatomic,retain)NSMutableArray *characteristicArrays;//外围设备特性数组

//心跳读取System ID 数值
@property(nonatomic,retain)CBPeripheral *myperipheral;
@property(nonatomic,retain)CBCharacteristic *mycharacteristic;

//写人数据
@property(nonatomic,retain)CBPeripheral *writePeripheral;
@property(nonatomic,retain)CBCharacteristic *writeCharacteristic;

//读取数据
@property(nonatomic,retain)CBPeripheral *readPeripheral;
@property(nonatomic,retain)CBCharacteristic *readCharacteristic;

@property(nonatomic,retain)NSString *strUUID;

@property BOOL connectState;

-(void)readSystemUUID;
-(void)stopReadSystemUUID;
-(void)writeValueForFFF3:(NSMutableData *)writevalue;

-(void)mySynUpgrade:(int)synID;

+(BluetoothFramework *)Singleton;//单例事例化类
-(void)scanForPer;
-(void)stopScanForPer;
-(void)didConnection:(NSArray *)pers;
-(void)didDisconnection:(NSString *)persUUID;


-(void)didReconnUsePer:(CBPeripheral *)peripheral;//手动链接
@end

//=================================================

#pragma mark Protocol TableBarDelegate
@protocol perDelegate <NSObject>
@optional//选择实现方法 //@required必须实现方法


//获取deviceid
-(void)didConnectPeripheral:(NSDictionary *)perInfo values:(NSData *) datavalue;
//发现设备
-(void)didDiscoverPeripheral:(NSDictionary *)perInfo;

//连接设备
-(void)didConnectPeripheral:(NSDictionary *)perInfo;

//取消连接设备
-(void)didDisconnectPeripheral:(NSDictionary *)perInfo;

//中断连接设备
-(void)didFailToConnectPeripheral:(NSDictionary *)perInfo;

//返回监听数值
-(void)returnValueForNotify:(NSData *)value;
@end
