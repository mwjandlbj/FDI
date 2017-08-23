//
//  GCDSocketManager.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/24.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "GCDSocketManager.h"
#import "DDLog.h"
#import "Tool.h"

//#define SocketHost @"101.37.86.94"

#define SocketHost @"101.37.86.57"
//#define SocketHost @"192.168.1.4"
//#define SocketHost @"47.52.93.27"
//#define SocketPort 50611
#define SocketPort 50611

#import "SSZipArchive.h"
#import "LFCGzipUtility.h"

#import "Response.h"


@interface GCDSocketManager()<GCDAsyncSocketDelegate,SSZipArchiveDelegate>

@property(nonatomic,strong)NSObject * obj_Socket;


//握手次数
@property(nonatomic,assign) NSInteger pushCount;

//断开重连定时器
@property(nonatomic,strong) NSTimer *timer;

//重连次数
@property(nonatomic,assign) NSInteger reconnectCount;


@property(nonatomic,strong) NSTimer * connectTimer;


@property(nonatomic,strong) NSTimer * heartTimer;



/*
 * 端口号
 */
@property (nonatomic,strong) NSString * port;
@end

@implementation GCDSocketManager

//全局访问点
+ (instancetype)sharedSocketManager {
    static GCDSocketManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

//可以在这里做一些初始化操作
- (instancetype)init
{

    self = [super init];
    _obj_Socket=[NSObject new];
    if (self) {
        
    }
    
    return self;
}

-(void)listenData {
    //    NSString* sp = @"\n";
    //    NSData* sp_data = [sp dataUsingEncoding:NSUTF8StringEncoding];
    [self.socket readDataToData:[GCDAsyncSocket CRLFData] withTimeout:-1 tag:1];
    //    [socket readDataWithTimeout:-1 tag:1];
}
-(BOOL)initS{
        //     每隔30s像服务器发送心跳包
        self.heartTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(longConnectToSocket) userInfo:nil repeats:YES];// 在longConnectToSocket方法中进行长连接需要向服务器发送的讯息
        [self.heartTimer fire];
    
    
    return YES;
    
}
#pragma mark 请求连接
//连接
- (void)connectToServer {
    self.pushCount = 3;
    
    /*
     * 设置socket的代理以及代理的线程
     */
    self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    /*
     * 在设置代理之后，你需要尝试连接到相应的地址来确定你的socket是否能连通了
     */
    //host是主机地址，port是端口号
    NSError *error = nil;
    [self.socket connectToHost:SocketHost onPort:SocketPort error:&error];
    
    if (error) {
//        DLog(@"SocketConnectError:%@",error);
    }
    
    
}


/**
 * 发送
 **/
- (void)udpSocket:(GCDAsyncSocket *)sock didSendDataWithTag:(long)tag{
    NSLog(@"tcp发送时调用的方法");
}

/**
 * 关闭时调用的方法
 **/
- (void)udpSocketDidClose:(GCDAsyncSocket *)sock withError:(NSError  * _Nullable)error{
    NSLog(@"tcp关闭时调用的方法");
}

#pragma mark 连接成功
//连接成功的回调
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    NSLog(@"socket连接成功----------%@-----------%hu",host,port);
    _port=[NSString stringWithFormat:@"%hu",port];
    NSLog(@"----------%hu,,,,",self.socket.localPort);
    NSLog(@"----------%@,,,,",[NSString stringWithFormat:@"%hu",self.socket.localPort]);
    _port=[NSString stringWithFormat:@"%hu",self.socket.localPort];

    
    [self sendDataToServer];
    
}


//连接成功后向服务器发送数据
- (void)sendDataToServer {
    //发送数据代码省略...
    
    //发送
    /*
     * 心跳包
     */
    
    
//    self.connectTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(tcp_longConnectToSocket) userInfo:nil repeats:YES];
//    [self.connectTimer fire];
    
    
    

    //Check "|" 10位时间戳 本地MAC物理地址+“|”+本地端口号
    //Check|1495692739A860B63670A8|50613
    //NSString * check=[NSString stringWithFormat:@"%@ %@ %@ %@%@%@%@",@"Check",@"|",[Tool getCurrentTimestamp],[Tool getMacAddress],@"|",_port,@"\r\n"];
    
    //获取 UUID
    CFUUIDRef  uuid = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef  cfstring = CFUUIDCreateString(kCFAllocatorDefault, uuid);
    
    NSString * check=[NSString stringWithFormat:@"%@ %@ %@ %@%@",@"Check",@"|",[Tool getCurrentTimestamp],cfstring,@"\r\n"];
    
    NSLog(@"check------%@",check);
    
    // | 1500457694 1C3983BE-21BF-4464-AA23-615ACCA3DF59
    
    NSData *check_data=[Tool getData_from_Str:check];
    
    [self.socket writeData:check_data withTimeout:-1 tag:100];
    [self.socket readDataWithTimeout:-1 tag:100];
    
    
    NSString * t1= [@"LoginBeat" stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSString *heart2 = [t1 stringByAppendingString:@" &\r\n"];
    
    
    
    NSData * test2=[Tool getData_from_Str:heart2];
                      
                      
    [self.socket writeData:test2 withTimeout:-1 tag:200];
    
    //[self.socket readDataToData:[GCDAsyncSocket CRLFData] withTimeout:10 maxLength:50000 tag:0];
    
    //读取数据
    [self.socket readDataWithTimeout:-1 tag:200];
    
    
    [self initS];
}

// 心跳连接
-(void)longConnectToSocket{
    
    
    NSString * t1= [@"LoginBeat" stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSString *heart2 = [t1 stringByAppendingString:@" &\r\n"];
    NSData * test2=[Tool getData_from_Str:heart2];
    
    [self.socket writeData:test2 withTimeout:-1 tag:200];
    
    NSLog(@"TCP--LoginBeat---心跳执行一次。。。。TCP--LoginBeat---心跳执行一次。。。。TCP--LoginBeat---心跳执行一次。。。。");
    
    //读取数据
    [self.socket readDataWithTimeout:-1 tag:200];
    
    
    
    
}



//连接成功向服务器发送数据后,服务器会有响应
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
   
    
    NSLog(@"连接成功向服务器发送数据后,服务器会有响应========连接成功向服务器发送数据后,服务器会有响应===");
    
    NSLog(@"data---%@",data);
    
    [self listenData];
    
    
    
    NSLog(@"didReadData read data");
    NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"message-----%@",message);
    
    
    NSString  *receiveStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    

    //NSArray  *arr1 = [receiveStr componentsSeparatedByString:[NSString stringWithFormat:@"\%@",@"\\n"]];
    
    //NSArray  *arr1 = [receiveStr componentsSeparatedByString:@" "];
    
    //for (NSString  *str in arr1) {
        
       // NSLog(@"str--chaifen---%@--\%@\%@",str,@"\\r",@"\\n");
        
        //if (str.length > 0) {
            
            
    //NSString  *str1 = arr1[0];
    NSArray   *arr2 = [receiveStr componentsSeparatedByString:@" "];
    NSString  *string = [NSString stringWithFormat:@"%@ %@",arr2[0],arr2[1]];
    
    NSLog(@"-----收到的内容%@",receiveStr);
    
    NSLog(@"-----string-----%@",string);
    
    
    static   dispatch_once_t check;
    dispatch_once(&check, ^{
        if([string isEqualToString:@"checkrsp SUCCESS"]){
            
            
            NSArray *array1 = [receiveStr componentsSeparatedByString:@" & "]; //从字符 & 中分隔成2个元素的数组
            NSLog(@"checkrsp array:%@",array1);
            NSString * checkrsp=array1[1];
            
            NSArray *checkrspArr = [checkrsp componentsSeparatedByString:@"\r\n"];
            NSString  *check_rsp = checkrspArr[0];
            
            NSString  *test = [NSString stringWithFormat:@"%@%@%@",@"IGet ",check_rsp,@"\r\n"];
            NSData    *check_data = [Tool getData_from_Str:test];
            
            
            [self.socket writeData:check_data withTimeout:-1 tag:300];
            
        }
        
        
    });
    
    
    
    /*
     * 登录成功返回信息-    loginrsp SUCCESS 2 6297be54-972f-493b-8bb2-1e2f1f7c59e1
     @"loginrsp SUCCESS"
     */
    /*
    if([string isEqualToString:@"loginrsp SUCCESS"]){
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"loginrspSUCCESS" object:receiveStr];
        
        NSArray *array3 = [message componentsSeparatedByString:@" "]; //从字符 中分隔成2个元素的数组
        NSLog(@"loginrsp SUCCESS:%@",array3);
        NSString * loginrsp=[array3 lastObject];
        NSLog(@"loginrsp-SUCCESS--%@",loginrsp);
        
        NSArray  *loginrspArr = [loginrsp componentsSeparatedByString:@"\r\n"];
        NSString *login_rsp = loginrspArr[0];
        
        NSData   *dataStream  = [Tool getData_from_Str:[NSString stringWithFormat:@"%@ %@%@",@"IGet ",login_rsp,@"\r\n"]];
        
        
        [self.socket writeData:dataStream withTimeout:-1 tag:501];
    }
     
     */
    
    /*
     *登录成功 loginrsp SUCCESS 2 6297be54-972f-493b-8bb2-1e2f1f7c59e1
     */
    
    if([message rangeOfString:@"loginrsp SUCCESS 2"].location !=NSNotFound){
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"loginrspSUCCESS" object:receiveStr];
        
        NSArray *array2 = [message componentsSeparatedByString:@" "]; //从字符 中分隔成2个元素的数组
        NSLog(@"loginrsp SUCCESS:%@",array2);
        NSString * loginrsp = [array2 lastObject];
        NSLog(@"loginrsp-SUCCESS--%@",loginrsp);
        
        NSArray  *loginrspArr = [loginrsp componentsSeparatedByString:@"\r\n"];
        NSString *login_rsp = loginrspArr[0];
        
        NSData   *dataStream  = [Tool getData_from_Str:[NSString stringWithFormat:@"%@ %@%@",@"IGet ",login_rsp,@"\r\n"]];
        
        
        [self.socket writeData:dataStream withTimeout:-1 tag:501];
        
    }
    
    /*
     *登录失败 loginrsp SUCCESS 1 6297be54-972f-493b-8bb2-1e2f1f7c59e1
     */
    
    if([message rangeOfString:@"loginrsp SUCCESS 1"].location !=NSNotFound){
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"loginrspFAIL" object:receiveStr];
        
        NSArray *array2 = [message componentsSeparatedByString:@" "]; //从字符 中分隔成2个元素的数组
        NSLog(@"loginrsp SUCCESS:%@",array2);
        NSString * loginrsp = [array2 lastObject];
        NSLog(@"loginrsp-SUCCESS--%@",loginrsp);
        
        NSArray  *loginrspArr = [loginrsp componentsSeparatedByString:@"\r\n"];
        NSString *login_rsp = loginrspArr[0];
        
        NSData   *dataStream  = [Tool getData_from_Str:[NSString stringWithFormat:@"%@ %@%@",@"IGet ",login_rsp,@"\r\n"]];
        
        
        [self.socket writeData:dataStream withTimeout:-1 tag:502];
        
    }
    
    /*
     * 登录失败返回信息-    loginrsp FAIL -1 fc7a7717-0610-4cf1-8a30-c6624ac0d1bc
     
     @"loginrsp FAIL"
     */
    if([string isEqualToString:@"loginrsp FAIL"]){
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"loginrspFAIL" object:receiveStr];
        
        
        NSArray *array3 = [message componentsSeparatedByString:@" "]; //从字符 中分隔成2个元素的数组
        NSLog(@"loginrspFAIL array:%@",array3);
        NSString * loginrspFAIL=[array3 lastObject];
        NSLog(@"loginrspFAIL---%@",loginrspFAIL);
        
        NSArray  *loginrspFAILArr = [loginrspFAIL componentsSeparatedByString:@"\r\n"];
        NSString *login_rspFAIL = loginrspFAILArr[0];
        
        NSData   *dataStream  = [Tool getData_from_Str:[NSString stringWithFormat:@"%@ %@%@",@"IGet ",login_rspFAIL,@"\r\n"]];
        
        
        [self.socket writeData:dataStream withTimeout:-1 tag:502];
        
    }
    
    
    /*
     *  心跳链接成功返回信息-    heartbeatrsp SUCCESS $ b69f9adf-fed2-4b2e-b850-d394faf03e31
     @"heartbeatrsp SUCCESS"
     */
    if([string isEqualToString:@"heartbeatrsp SUCCESS"]){
        NSArray *array3 = [message componentsSeparatedByString:@" "]; //从字符 中分隔成2个元素的数组
        NSLog(@"heartbeatrsp array:%@",array3);
        NSString * heartbeatrsp=[array3 lastObject];
        NSLog(@"heartbeatrsp---%@",heartbeatrsp);
        
        NSArray  *heartbeatrspArr = [heartbeatrsp componentsSeparatedByString:@"\r\n"];
        NSString *heartbeat_rsp = heartbeatrspArr[0];
        
        NSData   *dataStream  = [Tool getData_from_Str:[NSString stringWithFormat:@"%@ %@%@",@"IGet ",heartbeat_rsp,@"\r\n"]];
        
        
        [self.socket writeData:dataStream withTimeout:-1 tag:400];
        
        
    }
    
    
    /*
     *  资金信息  @"accountInfoReportrsp SUCCESS"
     */
    if([string isEqualToString:@"accountInfoReportrsp SUCCESS"]){
        
        
        //解析数据 及传递
        NSString *receiveStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        Response  *response = [Response new];
        [response rspMsg:receiveStr];
        
        NSData  *data = [[NSData alloc] initWithBase64EncodedString:response.ResponseBody options:NSISOLatin1StringEncoding];
        
        //解压
        NSData  *uncompress = [LFCGzipUtility uncompressZippedData:data];
        
        NSArray *results = [NSJSONSerialization JSONObjectWithData:uncompress options:NSJSONReadingMutableContainers error:nil];
        
//        NSLog(@"解压-----accountInfoReportrsp SUCCESS----------%@",results);
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"accountInfoReportrsp" object:results];
        
        
        
        
        NSArray *array3 = [message componentsSeparatedByString:@" "]; //从字符 中分隔成2个元素的数组
        NSLog(@"accountInfoReportrsp array:%@",array3);
        NSString * accountInfoReportrsp=[array3 lastObject];
        NSLog(@"accountInfoReportrsp---%@",accountInfoReportrsp);
        
        NSArray  *accountInfoReportrspArr = [accountInfoReportrsp componentsSeparatedByString:@"\r\n"];
        NSString *accountInfoReport_rsp = accountInfoReportrspArr[0];
        
        NSData   *dataStream  = [Tool getData_from_Str:[NSString stringWithFormat:@"%@ %@%@",@"IGet ",accountInfoReport_rsp,@"\r\n"]];
        
        
        [self.socket writeData:dataStream withTimeout:-1 tag:601];
        
    }
    
    
    /*
     * 交易明细  @"bidListrsp SUCCESS"
     */
    
    if([string isEqualToString:@"bidListrsp SUCCESS"]){
        
        //解析数据 及传递
        //NSString *receiveStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        //NSLog(@"bidListrsp SUCCESS--11---%@",receiveStr);
        
        Response  *response = [Response new];
        [response rspMsg:receiveStr];
        
        NSLog(@"response.ResponseBody------%@",response.ResponseBody);
        
        NSData  *data = [[NSData alloc] initWithBase64EncodedString:response.ResponseBody options:NSISOLatin1StringEncoding];
        NSLog(@"bidListrsp SUCCESS--data--%@",data);
        //解压
        if (data != nil) {
            
        NSData  *uncompress = [LFCGzipUtility ungzipData:data];
        
        NSArray *results = [NSJSONSerialization JSONObjectWithData:uncompress options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"解压-----bidListrsp SUCCESS----------%@",results);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"bidListrsp" object:results];

        }
        
        
        NSArray *array = [message componentsSeparatedByString:@" "]; //从字符 中分隔成2个元素的数组
//        NSLog(@"bidListrsp array:%@",array);
        NSString * bidListrsp=[array lastObject];
//        NSLog(@"bidListrsp---%@",bidListrsp);
        
        NSArray  *bidListrspArr = [bidListrsp componentsSeparatedByString:@"\r\n"];
        NSString *bidList_rsp = bidListrspArr[0];
        
        NSData   *dataStream  = [Tool getData_from_Str:[NSString stringWithFormat:@"%@ %@%@",@"IGet ",bidList_rsp,@"\r\n"]];
        
        
        [self.socket writeData:dataStream withTimeout:-1 tag:701];
        
        
    }
    
    
    /*
     * 委托记录
     @"presetBidListrsp SUCCESS"
     */
    
    if([string isEqualToString:@"presetBidListrsp SUCCESS"]){
        
        //解析数据 及传递
        NSString *receiveStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        Response  *response = [Response new];
        [response rspMsg:receiveStr];
        
        NSData  *data = [[NSData alloc] initWithBase64EncodedString:response.ResponseBody options:NSISOLatin1StringEncoding];
        
        //解压
        NSData  *uncompress = [LFCGzipUtility uncompressZippedData:data];
        
        NSArray *results = [NSJSONSerialization JSONObjectWithData:uncompress options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"解压-----presetBidListrsp SUCCESS----------%@",results);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"presetBidListrsp" object:results];
        
        
        
        
        NSArray *array = [message componentsSeparatedByString:@" "]; //从字符 中分隔成2个元素的数组
        //        NSLog(@"bidListrsp array:%@",array);
        NSString * bidListrsp=[array lastObject];
        //        NSLog(@"bidListrsp---%@",bidListrsp);
        
        NSArray  *bidListrspArr = [bidListrsp componentsSeparatedByString:@"\r\n"];
        NSString *bidList_rsp = bidListrspArr[0];
        
        NSData   *dataStream  = [Tool getData_from_Str:[NSString stringWithFormat:@"%@ %@%@",@"IGet ",bidList_rsp,@"\r\n"]];
        
        
        [self.socket writeData:dataStream withTimeout:-1 tag:711];
        
        
    }
    
    /*
     * 止损止盈 @"limitBidListrsp SUCCESS"
     */
    
    if([string isEqualToString:@"limitBidListrsp SUCCESS"]){
        
        //解析数据 及传递
        NSString *receiveStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        Response  *response = [Response new];
        [response rspMsg:receiveStr];
        
        NSData  *data = [[NSData alloc] initWithBase64EncodedString:response.ResponseBody options:NSISOLatin1StringEncoding];
        
        //解压
        NSData  *uncompress = [LFCGzipUtility uncompressZippedData:data];
        
        NSArray *results = [NSJSONSerialization JSONObjectWithData:uncompress options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"解压-----limitBidListrsp SUCCESS----------%@",results);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"limitBidListrsp" object:results];
        
        
        
        
        NSArray *array = [message componentsSeparatedByString:@" "]; //从字符 中分隔成2个元素的数组
        //        NSLog(@"bidListrsp array:%@",array);
        NSString * bidListrsp=[array lastObject];
        //        NSLog(@"bidListrsp---%@",bidListrsp);
        
        NSArray  *bidListrspArr = [bidListrsp componentsSeparatedByString:@"\r\n"];
        NSString *bidList_rsp = bidListrspArr[0];
        
        NSData   *dataStream  = [Tool getData_from_Str:[NSString stringWithFormat:@"%@ %@%@",@"IGet ",bidList_rsp,@"\r\n"]];
        
        
        [self.socket writeData:dataStream withTimeout:-1 tag:721];
        
        
    }
    
    
    /*
     * 成交记录
     */
    
    
    
    if([string isEqualToString:@"closeoutbidListrsp SUCCESS"]){
        
        //解析数据 及传递
        NSString *receiveStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        Response  *response = [Response new];
        [response rspMsg:receiveStr];
        
        NSData  *data = [[NSData alloc] initWithBase64EncodedString:response.ResponseBody options:NSISOLatin1StringEncoding];
        
        if (data != nil) {
            
        
        //解压
        NSData  *uncompress = [LFCGzipUtility uncompressZippedData:data];
        
        NSArray *results = [NSJSONSerialization JSONObjectWithData:uncompress options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"解压-----closeoutbidListrsp SUCCESS----------%@",results);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"closeoutbidListrsp" object:results];
        }
        
        
        
        NSArray *array = [message componentsSeparatedByString:@" "]; //从字符 中分隔成2个元素的数组
        //        NSLog(@"bidListrsp array:%@",array);
        NSString * bidListrsp=[array lastObject];
        //        NSLog(@"bidListrsp---%@",bidListrsp);
        
        NSArray  *bidListrspArr = [bidListrsp componentsSeparatedByString:@"\r\n"];
        NSString *bidList_rsp = bidListrspArr[0];
        
        NSData   *dataStream  = [Tool getData_from_Str:[NSString stringWithFormat:@"%@ %@%@",@"IGet ",bidList_rsp,@"\r\n"]];
        
        
        [self.socket writeData:dataStream withTimeout:-1 tag:731];
        
        
    }
    
    
    /*
     * 通知通告 @"newsMessageListrsp SUCCESS"
     */
    
    if([string isEqualToString:@"newsMessageListrsp SUCCESS"]){
        
        //解析数据 及传递
        NSString *receiveStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        Response  *response = [Response new];
        [response rspMsg:receiveStr];
        
        NSData  *data = [[NSData alloc] initWithBase64EncodedString:response.ResponseBody options:NSISOLatin1StringEncoding];
        
        //解压
        NSData  *uncompress = [LFCGzipUtility uncompressZippedData:data];
        
//        NSArray *results = [NSJSONSerialization JSONObjectWithData:uncompress options:NSJSONReadingMutableContainers error:nil];
        
//        NSLog(@"解压-----newsMessageListrsp SUCCESS----------%@",results);
        
        NSDictionary  *dic = [NSJSONSerialization JSONObjectWithData:uncompress options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"解压-----newsMessageListrsp SUCCESS----------%@",dic);
        
        NSString  *list = [dic objectForKey:@"list"];
        
        NSData  *dataa = [list dataUsingEncoding:NSUTF8StringEncoding];
        
//        NSDictionary  *decc = [NSJSONSerialization JSONObjectWithData:dataa options:NSJSONReadingMutableContainers error:nil];
//        
//        NSLog(@"%@",decc);
        NSArray  *arr = [NSJSONSerialization JSONObjectWithData:dataa options:NSJSONReadingMutableContainers error:nil];
        
//        NSLog(@"%@",arr);
        
        NSMutableArray  *dataArr = @[].mutableCopy;
        
        for (NSDictionary  *dec in arr) {
            NSDictionary  *decc = dec;
//            NSLog(@"%@",decc);
            [dataArr addObject:decc];
        }
        
        
//        NSArray  *arr1 = [list firstObject];
//        NSLog(@"%@",arr1);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"newsMessageListrsp" object:dataArr];
        
        
        
        
        NSArray *array = [message componentsSeparatedByString:@" "]; //从字符 中分隔成2个元素的数组
        //        NSLog(@"bidListrsp array:%@",array);
        NSString * bidListrsp=[array lastObject];
        //        NSLog(@"bidListrsp---%@",bidListrsp);
        
        NSArray  *bidListrspArr = [bidListrsp componentsSeparatedByString:@"\r\n"];
        NSString *bidList_rsp = bidListrspArr[0];
        
        NSData   *dataStream  = [Tool getData_from_Str:[NSString stringWithFormat:@"%@ %@%@",@"IGet ",bidList_rsp,@"\r\n"]];
        
        
        [self.socket writeData:dataStream withTimeout:-1 tag:741];
        
        
    }
    
    
    /*
     * 修改密码---成功 @"changePasswordrsp SUCCESS"
     */
    if([string isEqualToString:@"changePasswordrsp SUCCESS"]){
        NSArray *array3 = [message componentsSeparatedByString:@" "]; //从字符 中分隔成2个元素的数组
        NSLog(@"changePasswordrsp array:%@",array3);
        NSString * changePasswordrsp=[array3 lastObject];
        NSLog(@"changePasswordrsp---%@",changePasswordrsp);
        
        NSArray  *changePasswordrspArr = [changePasswordrsp componentsSeparatedByString:@"\r\n"];
        NSString *changePassword_rsp = changePasswordrspArr[0];
        
        NSData   *dataStream  = [Tool getData_from_Str:[NSString stringWithFormat:@"%@ %@%@",@"IGet ",changePassword_rsp,@"\r\n"]];
        
        
        [self.socket writeData:dataStream withTimeout:-1 tag:751];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"changePasswordrspSUCCESS" object:receiveStr];
    }
    
    /*
     * 修改密码---失败 @"changePasswordrsp FAIL"
     */
    if([string isEqualToString:@"changePasswordrsp FAIL"]){
        NSArray *array3 = [message componentsSeparatedByString:@" "]; //从字符 中分隔成2个元素的数组
        NSLog(@"changePasswordrsp array:%@",array3);
        NSString * changePasswordrsp=[array3 lastObject];
        NSLog(@"changePasswordrsp---%@",changePasswordrsp);
        
        NSArray  *changePasswordrspArr = [changePasswordrsp componentsSeparatedByString:@"\r\n"];
        NSString *changePassword_rsp = changePasswordrspArr[0];
        
        NSData   *dataStream  = [Tool getData_from_Str:[NSString stringWithFormat:@"%@ %@%@",@"IGet ",changePassword_rsp,@"\r\n"]];
        
        
        [self.socket writeData:dataStream withTimeout:-1 tag:752];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"changePasswordrspFAIL" object:receiveStr];
    }
    
    
    /*
     * 持仓合计 @"waitBidReportrsp SUCCESS"
     */
    
    if([string isEqualToString:@"waitBidReportrsp SUCCESS"]){
        
        //解析数据 及传递
        NSString *receiveStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        Response  *response = [Response new];
        [response rspMsg:receiveStr];
        
        NSData  *data = [[NSData alloc] initWithBase64EncodedString:response.ResponseBody options:NSISOLatin1StringEncoding];
        
        //解压
        NSData  *uncompress = [LFCGzipUtility uncompressZippedData:data];
        
        NSArray *results = [NSJSONSerialization JSONObjectWithData:uncompress options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"解压-----waitBidReportrsp SUCCESS----------%@",results);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"waitBidReportrsp" object:results];
        
        
        
        
        NSArray *array = [message componentsSeparatedByString:@" "]; //从字符 中分隔成2个元素的数组
        //        NSLog(@"bidListrsp array:%@",array);
        NSString * bidListrsp=[array lastObject];
        //        NSLog(@"bidListrsp---%@",bidListrsp);
        
        NSArray  *bidListrspArr = [bidListrsp componentsSeparatedByString:@"\r\n"];
        NSString *bidList_rsp = bidListrspArr[0];
        
        NSData   *dataStream  = [Tool getData_from_Str:[NSString stringWithFormat:@"%@ %@%@",@"IGet ",bidList_rsp,@"\r\n"]];
        
        
        [self.socket writeData:dataStream withTimeout:-1 tag:761];
        
        
        
    }
    
    
    /*
     * 买入成功返回信息-    presetBidAddrsp SUCCESS OK 保存预埋单成功！ 9c0be67a-8c89-4942-964a-b648a619e40a
     */
    if([string isEqualToString:@"presetBidAddrsp SUCCESS"]){
        //NSArray *array2 = [message componentsSeparatedByString:@" "]; //从字符 中分隔成2个元素的数组
        //NSLog(@"loginrsp array:%@",array2);
        //NSString * loginrsp=array2[3];
        //NSData   *dataStream  = [Tool getData_from_Str:[NSString stringWithFormat:@"IGet %@\r\n",loginrsp]];
        
        //[self.socket writeData:dataStream withTimeout:-1 tag:102];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"presetBidAddrspSUCCESS" object:receiveStr];
        
        
        NSArray *array3 = [message componentsSeparatedByString:@" "]; //从字符 中分隔成2个元素的数组
        NSLog(@"presetBidAddrsp array:%@",array3);
        NSString * presetBidAddrsp=[array3 lastObject];
        NSLog(@"presetBidAddrsp---%@",presetBidAddrsp);
        
        NSArray  *presetBidAddrspArr = [presetBidAddrsp componentsSeparatedByString:@"\r\n"];
        NSString *presetBidAdd_rsp = presetBidAddrspArr[0];
        
        NSData   *dataStream  = [Tool getData_from_Str:[NSString stringWithFormat:@"%@ %@%@",@"IGet ",presetBidAdd_rsp,@"\r\n"]];
        
        
        [self.socket writeData:dataStream withTimeout:-1 tag:771];
    }
    
    
    /*
     * 买入成功返回信息-    bidTradersp SUCCESS 交易成功！ 84a5b04e-a8e7-43c3-adf0-cec319eee497
     */
    if([string isEqualToString:@"bidTradersp SUCCESS"]){
        //NSArray *array2 = [message componentsSeparatedByString:@" "]; //从字符 中分隔成2个元素的数组
        //NSLog(@"loginrsp array:%@",array2);
        //NSString * loginrsp=array2[3];
        //NSData   *dataStream  = [Tool getData_from_Str:[NSString stringWithFormat:@"IGet %@\r\n",loginrsp]];
        
        //[self.socket writeData:dataStream withTimeout:-1 tag:102];
        
        NSLog(@"bidTradersp SUCCESS-----bidTradersp SUCCESS-----bidTradersp SUCCESS-----------bidTradersp SUCCESS------------bidTradersp SUCCESS-----------bidTradersp SUCCESS-------------bidTradersp SUCCESS------------bidTradersp SUCCESS-------bidTradersp SUCCESS");
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"bidTraderspSUCCESS" object:receiveStr];
        
        NSArray *array3 = [message componentsSeparatedByString:@" "]; //从字符 中分隔成2个元素的数组
        NSLog(@"bidTradersp array:%@",array3);
        NSString * bidTradersp=[array3 lastObject];
        NSLog(@"bidTradersp---%@",bidTradersp);
        
        NSArray  *bidTraderspArr = [bidTradersp componentsSeparatedByString:@"\r\n"];
        NSString *bidTrade_rsp = bidTraderspArr[0];
        
        NSData   *dataStream  = [Tool getData_from_Str:[NSString stringWithFormat:@"%@ %@%@",@"IGet ",bidTrade_rsp,@"\r\n"]];
        
        
        [self.socket writeData:dataStream withTimeout:-1 tag:771];
    }
    
    
    /*
     * 买入失败返回信息-    bidTradersp FAIL 当前合约未开通！禁止交易 704b5c7d-a832-44bd-a122-6c5ad171755d
     */
    if([string isEqualToString:@"bidTradersp FAIL"]){
        //NSArray *array2 = [message componentsSeparatedByString:@" "]; //从字符 中分隔成2个元素的数组
        //NSLog(@"loginrsp array:%@",array2);
        //NSString * loginrsp=array2[3];
        //NSData   *dataStream  = [Tool getData_from_Str:[NSString stringWithFormat:@"IGet %@\r\n",loginrsp]];
        
        //[self.socket writeData:dataStream withTimeout:-1 tag:102];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"bidTraderspFAIL" object:receiveStr];
        
        
        NSArray *array3 = [message componentsSeparatedByString:@" "]; //从字符 中分隔成2个元素的数组
        NSLog(@"bidTradersp array:%@",array3);
        NSString * bidTradersp=[array3 lastObject];
        NSLog(@"bidTradersp---%@",bidTradersp);
        
        NSArray  *bidTraderspArr = [bidTradersp componentsSeparatedByString:@"\r\n"];
        NSString *bidTrade_rsp = bidTraderspArr[0];
        
        NSData   *dataStream  = [Tool getData_from_Str:[NSString stringWithFormat:@"%@ %@%@",@"IGet ",bidTrade_rsp,@"\r\n"]];
        
        
        [self.socket writeData:dataStream withTimeout:-1 tag:772];
    }
    
    
    /*
     * 新增止损止盈失败返回信息-    limitBidAddrsp FAIL FAIL 新增止损止盈出错！请查询合约，用户名是否存在！ b56f885d-23bd-4c9f-b8ed-73a6b569c058
     */
    if([string isEqualToString:@"limitBidAddrsp FAIL"]){
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"limitBidAddrspFAIL" object:receiveStr];
        
        
        NSArray *array3 = [message componentsSeparatedByString:@" "]; //从字符 中分隔成2个元素的数组
        NSLog(@"limitBidAddrspFAIL array:%@",array3);
        NSString * limitBidAddrspFAIL=[array3 lastObject];
        NSLog(@"limitBidAddrspFAIL---%@",limitBidAddrspFAIL);
        
        NSArray  *limitBidAddrspFAILArr = [limitBidAddrspFAIL componentsSeparatedByString:@"\r\n"];
        NSString *limitBidAdd_rspFAIL = limitBidAddrspFAILArr[0];
        
        NSData   *dataStream  = [Tool getData_from_Str:[NSString stringWithFormat:@"%@ %@%@",@"IGet ",limitBidAdd_rspFAIL,@"\r\n"]];
        
        
        [self.socket writeData:dataStream withTimeout:-1 tag:796];
        
    }
    
    /*
     * 新增止损止盈成功返回信息-    limitBidAddrsp SUCCESS OK 新增止损止盈成功！ 5ee987a9-42fd-47e7-9852-963ebc15d14b
     */
    if([string isEqualToString:@"limitBidAddrsp SUCCESS"]){
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"limitBidAddrspSUCCESS" object:receiveStr];
        
        
        NSArray *array3 = [message componentsSeparatedByString:@" "]; //从字符 中分隔成2个元素的数组
        NSLog(@"limitBidAddrspSUCCESS array:%@",array3);
        NSString * limitBidAddrspSUCCESS=[array3 lastObject];
        NSLog(@"limitBidAddrspSUCCESS---%@",limitBidAddrspSUCCESS);
        
        NSArray  *limitBidAddrspSUCCESSArr = [limitBidAddrspSUCCESS componentsSeparatedByString:@"\r\n"];
        NSString *limitBidAdd_rspSUCCESS = limitBidAddrspSUCCESSArr[0];
        
        NSData   *dataStream  = [Tool getData_from_Str:[NSString stringWithFormat:@"%@ %@%@",@"IGet ",limitBidAdd_rspSUCCESS,@"\r\n"]];
        
        
        [self.socket writeData:dataStream withTimeout:-1 tag:797];
        
    }
            
        //}
    //}

//    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
//    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
//    
//    NSError *jsonError;
//    NSDictionary *json =
//    [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&jsonError];
//    NSLog(@"socket - receive data %@", json);
//    
//    if (jsonError) {
//        NSLog(@"json 解析错误: --- error %@", jsonError);
//
//    }

//    [self.socket readDataWithTimeout:-1 tag:200];
    
    //服务器推送次数
//    self.pushCount++;
    
    //在这里进行校验操作,情况分为成功和失败两种,成功的操作一般都是拉取数据
}





#pragma mark 连接失败
//连接失败的回调
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    NSLog(@"Socket连接失败");
    
    self.pushCount = 0;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *currentStatu = [userDefaults valueForKey:@"Statu"];
    
    NSLog(@"currentStatu--%@",currentStatu);
    
    //程序在前台才进行重连
    if ([currentStatu isEqualToString:@"foreground"]) {
        
        NSLog(@"进入断线重连---进入断线重连---进入断线重连---");
        //重连次数
        self.reconnectCount++;
        
        //如果连接失败 累加1秒重新连接 减少服务器压力
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 * self.reconnectCount target:self selector:@selector(reconnectServer) userInfo:nil repeats:NO];
        
        self.timer = timer;
    }
}

//如果连接失败,5秒后重新连接
- (void)reconnectServer {
    
    self.pushCount = 0;
    
    self.reconnectCount = 0;
    
    //连接失败重新连接
    NSError *error = nil;
    [self.socket connectToHost:SocketHost onPort:SocketPort error:&error];
    if (error) {
        NSLog(@"SocektConnectError:%@",error);
    }
    
    NSLog(@"开始重连----开始重连----开始重连----");
}

#pragma mark 断开连接
//切断连接
- (void)cutOffSocket {
    NSLog(@"socket断开连接");
    
    self.pushCount = 0;
    
    self.reconnectCount = 0;
    
    [self.timer invalidate];
    self.timer = nil;
    
    [self.heartTimer invalidate];
    self.heartTimer = nil;
    
    [self.socket disconnect];
}



- (void)socketWriteData:(NSString *)data {
    NSData *requestData = [data dataUsingEncoding:NSUTF8StringEncoding];
    [self.socket writeData:requestData withTimeout:-1 tag:0];
    [self socketBeginReadData];
}
- (void)socketBeginReadData {
    [self.socket readDataToData:[GCDAsyncSocket CRLFData] withTimeout:10 maxLength:0 tag:0];
}





/*
 * 发送命令
 */
-(void)sendWithStr:(NSString *)str{
    
    @synchronized (_obj_Socket) {
        NSString *longConnect = [[Tool  URLEncodedString:str] stringByAppendingString:@"\r\n"];
        NSData   *dataStream  = [Tool getData_from_Str:longConnect];
        [self.socket writeData:dataStream withTimeout:-1 tag:101];
    }
    
}

/*
 * 异步
 */
-(void)Async_sendWithStr:(NSString *)str{
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //异步函数
    /*
     第一个参数:队列
     第二个参数:block,在里面封装任务
     */
    dispatch_async(queue, ^{
        [self sendWithStr:str];
        
    });

}

/*
 * 登录
 */
-(void)Action_LoginWithAccount:(NSString*)account withPassword:(NSString*)password{
    
    
//    NSLog(@"%@",[NSThread currentThread]);
    
    
    //NSString *Userid=@"029008427";
    //NSString *Password=@"123456";
    //NSString *Userid=@"moyi";
    //NSString *Password=@"665500";
    NSString * login=[NSString stringWithFormat:@"%@ %@ %@%@",@"Login",account,password,@"\r\n"];
    
//    return "Login "+Userid+" "+Password;
//Login 029008427 123456
    NSData   *dataStream  = [Tool getData_from_Str:login];

    [self.socket writeData:dataStream withTimeout:-1 tag:500];
    //读取数据
    [self.socket readDataWithTimeout:-1 tag:500];
    
    
    
    
    //NSString * check=[NSString stringWithFormat:@"%@ %@ %@ %@%@%@%@",@"Check",@"|",[Tool getCurrentTimestamp],[Tool getMacAddress],@"|",_port,@"\r\n"];
    //NSData *check_data=[Tool getData_from_Str:check];
    
    //[self.socket writeData:check_data withTimeout:-1 tag:100];
    //[self.socket readDataWithTimeout:-1 tag:100];
}

/*
 * 通用请求
 */
- (void)requestForUniversalWithName:(NSString *_Nullable)name WithContent:(NSString *_Nullable)content withTag:(NSInteger)tag {
    
    NSString   *request = [NSString stringWithFormat:@"%@ %@%@",name,content,@"\r\n"];
    NSData     *data = [Tool getData_from_Str:request];
    
    [self.socket writeData:data withTimeout:-1 tag:tag];
    //读取数据
    [self.socket readDataWithTimeout:-1 tag:tag];
    
    
}

/*
 * 交易请求
 */
- (void)requestForTransactionWithName:(NSString *_Nullable)name withNSDictionary:(NSDictionary *_Nullable)dic withTag:(NSInteger)tag {
    
    NSLog(@"dic---%@",dic);
    
    NSData  *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    
    //NSLog(@"data---%@",data);
    
    //NSString  *strdata = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
   // NSLog(@"strdata---%@",strdata);
    
    //压缩
    NSData     *datazip = [LFCGzipUtility gzipData:data];
    
    NSLog(@"datazip---%@",datazip);
    
    //转data
    NSData    *database64 = [datazip base64EncodedDataWithOptions:0];
    
    NSLog(@"database64---%@",database64);
    
    //data转str
    NSString  *strbase64 = [[NSString alloc] initWithData:database64 encoding:NSUTF8StringEncoding];
    
    NSLog(@"strbase64---%@",strbase64);
    
    NSString   *request = [NSString stringWithFormat:@"%@ %@%@",name,strbase64,@"\r\n"];
    
    NSData     *dataa = [Tool getData_from_Str:request];
    
    
    
    [self.socket writeData:dataa withTimeout:-1 tag:tag];
    //读取数据
    [self.socket readDataWithTimeout:-1 tag:tag];
    
}




/*
 * 修改密码
 */
- (void)requestForUniversalWithName:(NSString *_Nullable)name WithOldPsw:(NSString *_Nullable)oldPsw WithNewPsw:(NSString *_Nullable)newPsw WithAccount:(NSString *_Nullable)account withTag:(NSInteger)tag{
    
    NSString   *request = [NSString stringWithFormat:@"%@ %@ %@ %@%@",name,oldPsw,newPsw,account,@"\r\n"];
    NSData     *data = [Tool getData_from_Str:request];
    
    [self.socket writeData:data withTimeout:-1 tag:tag];
    //读取数据
    [self.socket readDataWithTimeout:-1 tag:tag];
    
}


@end




























