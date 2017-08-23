//
//  UDPManager.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/26.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "UDPManager.h"
#import "Tool.h"
#import <UIKit/UIKit.h>
//#define SocketHost @"47.52.93.27"
#define SocketPort 50608

//#define SocketHost @"101.37.86.94"
#define SocketHost @"101.37.86.57"

////#define SocketHost @"47.52.93.27"
////#define SocketPort 50611
//#define SocketPort 50613


/***
 *把请求回来的数据写入桌面
 *注意：写入路径
 *一个#意思是 把跟在它后面 变量增加 双引号“”
 *两个## 意思是 链接 把后面传过来的变量与##前面的内容进行链接
 **/
#define SLQKWriteFile(fileName) [responseObject writeToFile:[NSString stringWithFormat:@"/Users/wangzhaoke/Desktop/工程plist汇总/%@.plist",@#fileName] atomically:YES];


#import "SSZipArchive.h"
#import "LFCGzipUtility.h"

#import "Response.h"


#import "Stock.h"

//#import "NSString+NSString_Base64.h"


@interface UDPManager()<GCDAsyncUdpSocketDelegate,SSZipArchiveDelegate>

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

@implementation UDPManager

//全局访问点
+ (instancetype)sharedSocketManager {
    static UDPManager *_instance = nil;
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

#pragma mark 请求连接

//连接
- (void)connectToServer {
    self.pushCount = 1;
    
    /*
     * 设置socket的代理以及代理的线程
     */
//    dispatch_queue_t qQueue = dispatch_queue_create("Client queue", NULL);
//    self.socket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self
//                                               delegateQueue:qQueue];
    
    self.udp_socket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    //host是主机地址，port是端口号
    NSError *error = nil;
//    [self.udp_socket bindToPort:SocketPort error:&error];
//    [self.udp_socket bindToAddress:[Tool getData_from_Str:SocketHost] error:&error];
    [self.udp_socket connectToHost:SocketHost onPort:SocketPort error:&error];
    
    if (error) {
        //        DLog(@"SocketConnectError:%@",error);
    }
    
    
    [self.udp_socket beginReceiving:&error];

    

    /*
     * 在设置代理之后，你需要尝试连接到相应的地址来确定你的socket是否能连通了
     */
  
    
    
   
}





/**
 * 发送
 **/
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag{
    NSLog(@"udp发送时调用的方法");
}




/**
 * 关闭时调用的方法
 **/
- (void)udpSocketDidClose:(GCDAsyncUdpSocket *)sock withError:(NSError  * _Nullable)error{
    NSLog(@"udp关闭时调用的方法");
}
#pragma mark 连接成功
//连接成功的回调
/**
 * 链接成功
 **/
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didConnectToAddress:(NSData *)address{
    
    NSLog(@"UDP连接成功----------%@-----",[Tool getStr_from_Data:address]);
    NSLog(@"----------%hu,,,,",self.udp_socket.localPort);
    NSLog(@"----------%@,,,,",[NSString stringWithFormat:@"%hu",self.udp_socket.udp_localPort]);
    
    
    _port=[NSString stringWithFormat:@"%hu",self.udp_socket.udp_localPort];
    
    
    
    static  dispatch_once_t  firstlogin;
    dispatch_once(&firstlogin, ^{
        NSData *sendData = [Tool getData_from_Str:@"FirstLogin \r\n"];
        [self.udp_socket  sendData:sendData withTimeout:60
                               tag:202];
    });
    

    
    [self sendDataToServer];
}



//连接成功后向服务器发送数据
- (void)sendDataToServer {
    //发送数据代码省略...
    
    
        // 每隔30s像服务器发送心跳包
        self.heartTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(udp_longConnectToSocket) userInfo:nil repeats:YES];// 在longConnectToSocket方法中进行长连接需要向服务器发送的讯息
        [self.heartTimer fire];
    
    
    /*
      FirstLogin
     */
    
//    NSString  *firstlogin = [NSString stringWithFormat:@"%@%@",@"FirstLogin ",@"\r\n"];
//    NSData   *first_data = [Tool getData_from_Str:firstlogin];
//    
//    [self.udp_socket sendData:first_data withTimeout:60 tag:501];
    
    
//    //"LoginBeat 本地MAC地址+“|”+本地端口号
//    
//    
//    NSString * check=[NSString stringWithFormat:@"%@%@%@%@%@",@"LoginBeat ",[Tool getMacAddress],@"|",_port,@"\r\n"];
//    NSData *check_data=[Tool getData_from_Str:check];
//    
////    [self.socket sendData:check_data
////                   toHost:SocketHost
////                     port:SocketPort
////              withTimeout:60
////                      tag:201];
//    
//    [self.udp_socket  sendData:check_data withTimeout:60
//                       tag:201];
//    
////    [self.socket  sendData:check_data toAddress:[Tool getData_from_Str:SocketHost] withTimeout:60  tag:202];
//    
//    
//    
//    //如何对压缩文件进行解压
//    /*
//     第一个参数：要解压的文件
//     第二个参数：要解压到什么地方
//     */
////    + (NSData *)gzipData:(NSData*)pUncompressedData;  //压缩
////    
////    + (NSData *)ungzipData:(NSData *)compressedData;  //解压缩
////    H4sIAF9mKFkA22RsW7DIBRF/4UZV4CDSTzGGWwpTaPG7Y7ilxaVGIvgVlHVoVOXTv3IfEeBRG4sdUF65z7uvYh3VJjWWbl11QLlqKzKTUU4wgNeyT144fT5c/r+oiJqawuvhTYHLzCeMX5DMKpNI493HbRnRgIr1dMzHNzaqu1lVQS8NG8jSuLyCsaUni2Mbh6NRrmYsYnwMVY2EAHn08tYGyc9IEONudSyDTYRhbYDGfoWvbXQumhFMZr3x6tCs7DhUVQnGG1A66tmNMiBRT3F6KHrwC7VXrlLZnjiCNxK+wJ+aHutMVqo3Q58fDBMaOzzh+6lU8Zzf48QPuVp9s8hQmgjHdQq/g8jVCSEJyyrqchTmvuSGWXo4xflsWAJ4QEAAA==
//    NSString *original= @"H4sIAPJmKFkA/22RvU7DMBSF38WzU9nOj9uMTYdEKqWiobvV3IKFG0euA6oQAxMLEw/Z58B2q0AQi6X7neNzruVXVOjWGrGz1QLlqKzKTUVShAe8Egdwwvn96/z5QXnQ1gaeC6WPTmBpxtIJwajWjTjddtBeGPGslA+PcLRrI3dXK/d4qV9GlATzCsaU0hChVbPVCuV8xhLuaoxoIICMx9ex1lY4QIY15kKJ1scE5LcdyLBv0RsDrQ1RFKN5f/pb7dClCKMNKPVLZl72LOgJRvddB2YpD9JeO/0TR+BGmCdwQ9srhdFC7vfg6n1gRBNv+EF3wkrtuLtHSJpkcUL/OXxpIyzUMvwPI5RHJI1YVlOex3EeTyczMkVv32Wa4jzhAQAA";
//    
//    NSData * dataGzip = [original dataUsingEncoding:NSISOLatin1StringEncoding];
//    NSData * data = [LFCGzipUtility uncompressZippedData:dataGzip];
//    
////    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
////    NSDictionary *myDictionary = [unarchiver decodeObjectForKey:@"Some Key Value"];
//    
//
//    NSString * result = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
//    
//    
//    
//    NSLog(@"----%@",result);

    

    
//    NSString *path1 =NSHomeDirectory();
//    path1 = [path1 stringByAppendingString:@"/见哥.txt"];
//    [string writeToFile:path1 atomically:YES encoding:NSUTF8StringEncoding error:nil];
//    NSString *path2 =NSHomeDirectory();
//    path2 = [path2 stringByAppendingString:@"/不见哥.txt"];
//    
//    
//    
//    [Main unzipFileAtPath:path1 toDestination:path2];
//
//    NSString *contentString = [NSString stringWithContentsOfFile:path1 encoding:NSUTF8StringEncoding error:nil];
//    NSLog(@"%@",contentString);
    
    
    
    
}

// 心跳连接
-(void)udp_longConnectToSocket{
    
    
    NSString *longConnect = [NSString stringWithFormat:@"%@%@%@%@%@",@"LoginBeat ",[Tool getMacAddress],@"|",_port,@"\r\n"];
    NSData   *dataStream  = [Tool getData_from_Str:longConnect];
    
    [self.udp_socket  sendData:dataStream withTimeout:-1
                           tag:201];
    
    
    NSLog(@"UDP--LoginBeat---心跳执行一次。。。。UDP--LoginBeat---心跳执行一次。。。。UDP--LoginBeat---心跳执行一次。。。。");
  
    
}

- (void)setReceiveFilter:(nullable GCDAsyncUdpSocketReceiveFilterBlock)filterBlock
               withQueue:(nullable dispatch_queue_t)filterQueue
          isAsynchronous:(BOOL)isAsynchronous{
    
    
//    NSLog(<#NSString * _Nonnull format, ...#>)
    
    
    
    
}
//连接成功向服务器发送数据后,服务器会有响应
/**
 * 已收到请求的数据报。
 **/
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data
      fromAddress:(NSData *)address withFilterContext:(nullable id)filterContext{
    
//    static  dispatch_once_t  firstlogin;
//    dispatch_once(&firstlogin, ^{
//        NSData *sendData = [Tool getData_from_Str:@"FirstLogin \r\n"];
//        [self.udp_socket  sendData:sendData withTimeout:60
//                               tag:202];
//    });
//    NSData *sendData = [Tool getData_from_Str:@"FirstLogin \r\n"];
//    [self.udp_socket  sendData:sendData withTimeout:60
//                           tag:202];
    
    
    NSString *receiveStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"服务器ip地址--->%@,host---%u,内容--->%@",
//          [GCDAsyncUdpSocket hostFromAddress:address],
//          [GCDAsyncUdpSocket portFromAddress:address],
//          receiveStr);
    
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        
////        NSLog(<#NSString * _Nonnull format, ...#>)
////        receiveLab.text = receiveStr;
//    });
    
    
//    NSLog(@"-----收到的内容%@",receiveStr);
    
    Response  *response = [Response new];
    
    [response rspMsg:receiveStr];
    
    NSData  *dataa = [[NSData alloc] initWithBase64EncodedString:response.ResponseBody options:NSISOLatin1StringEncoding];
    
//    NSLog(@"%@",dataa);
    
    //解压
    NSData  *uncompress = [LFCGzipUtility uncompressZippedData:dataa];
    
    //将解压出来的NSdata转成NSString（这就是后台传过来的字符串经过解压处理后的结果字符串）
    
    NSArray *results = [NSJSONSerialization JSONObjectWithData:uncompress options:NSJSONReadingMutableContainers error:nil];
    
    //NSLog(@"解压---%@",results);
 
    static  dispatch_once_t  allstockinforsp;
    dispatch_once(&allstockinforsp, ^{
        /*
         NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/all.plist"];
         
         [[NSFileManager defaultManager]createFileAtPath:filePath contents:uncompress attributes:nil];
         */

        [[NSNotificationCenter defaultCenter]postNotificationName:@"allDatas" object:results];
        
    });
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeForResult" object:results];
    

    
//    Response  *response = [Response new];
//    
//    [response rspMsg:receiveStr];
//    
//    NSLog(@"%@",response.CommandName);
//    
//    if ([response.CommandName isEqualToString:@"pushrsp"]) {
//        if ([response.Status isEqualToString:@"SUCCESS"]) {
//            //将这个字符串（是经过base64转码的字符串）转为NSdata
//            NSData  *dataa = [[NSData alloc] initWithBase64EncodedString:response.ResponseBody options:NSISOLatin1StringEncoding];
//            
//            NSLog(@"%@",dataa);
//            
//            //解压
//            NSData  *uncompress = [LFCGzipUtility uncompressZippedData:dataa];
//            
//            //将解压出来的NSdata转成NSString（这就是后台传过来的字符串经过解压处理后的结果字符串）
//            
//            NSString * result = [[NSString alloc] initWithData:uncompress encoding:NSUTF8StringEncoding];
//            
//            
//            
//            NSLog(@"解压---%@",result);
//            
//        }else {
//            NSLog(@"%@",response.ResponseBody);
//        }
//        
//    }
    
    
    /*
    
    
    
    
//    根据子字符串分割字符串
//    NSString *str2=@"0123456=my_type=\"dlrthhkkll\" ";
    NSArray *temp=[receiveStr componentsSeparatedByString:@" "];
    NSLog(@"%@",[temp description]);
    
//    NSLog(@"%@",[[temp description] lastPathComponent]);
    
    NSLog(@"%@",[temp lastObject]);
    
    
    
    
    NSString  *sttt = @"H4sIAGV5NVkA/1WRTU7DMBSE7+K1G/kvsZNlUySQSqggsLcaFyzcuHIdUIW4Qq/AHdix4TbANXDcqEqW/sZvZp7eGyht651c+6sFKEB1US4rBOCZVnKrAv/7Pv4cP34/vxAP4sqpl9LYfVAYTziDoLaNPNzsVHsiGIJL/fik9n7l9Lr/JhJGIFja1xHjSZZBUKkpEyIMW9M8WAOKNMUU8+DvZKMiEZwjNoDaehkQStDQYC6NbHufiPqaZzKklZ1zqvXRKrScd4dpcgBRIxSCO2XMSM1PJMo0dLrf7ZRb6q32Q16/3QRcS/eswqPtjIFgoTcbFcJP/TAbk1vptY1TiOSUxLXzjAmUU8FwxgghIkY20qtax5sQhPkMZTOU1jgtKC5YnjBKwPs/kNZR3NQBAAA=";
    
    
    
    
    
//    NSString *decodeStr = [sttt base64DecodedString];
//    NSLog(@"Base64解码--%@",decodeStr);
//    
//    
//    NSString *base64Str = [receiveStr base64EncodedString];
//    NSLog(@"Base64编码--%@",base64Str);
    
    
    
    
    
    
    
    
//    NSData  *dataGzip = [sttt dataUsingEncoding:NSISOLatin1StringEncoding];
//    
//    //解压
//    NSData  *uncompress = [LFCGzipUtility uncompressZippedData:dataGzip];
//    
//    //将解压出来的NSdata转成NSString（这就是后台传过来的字符串经过解压处理后的结果字符串）
//    
//    NSString * result = [[NSString alloc] initWithData:uncompress encoding:NSISOLatin1StringEncoding];
    
    //将这个字符串（是经过base64转码的字符串）转为NSdata

    
    NSData  *dataa = [[NSData alloc] initWithBase64EncodedString:sttt options:NSISOLatin1StringEncoding];
    
    NSLog(@"%@",dataa);
    
    
//        NSData  *dataGzip = [sttt dataUsingEncoding:NSISOLatin1StringEncoding];
    
        //解压
        NSData  *uncompress = [LFCGzipUtility uncompressZippedData:dataa];
    
        //将解压出来的NSdata转成NSString（这就是后台传过来的字符串经过解压处理后的结果字符串）
    
        NSString * result = [[NSString alloc] initWithData:uncompress encoding:NSISOLatin1StringEncoding];
    
    NSLog(@"解压---%@",result);
    
    
    
    */
    
//    NSdata转为UIimage
    
//    UIImage *image = [UIImage imageWithData:data];
//    
////    _sceneControlImg.image = image;
//    NSLog(@"%@",image);
    
    
    //服务器推送次数
//    self.pushCount++;
    
    //在这里进行校验操作,情况分为成功和失败两种,成功的操作一般都是拉取数据
    //继续监听客户端发送消息
    
}

/*
 udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data
 fromAddress:(NSData *)address withFilterContext:(nullable id)filterContext
 */


#pragma mark 连接失败
// 发送消息失败回调
/**
 * 连接失败
 **/
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotConnect:(NSError * _Nullable)error{
    
    NSLog(@"UDP连接失败----UDP连接失败----UDP连接失败----");
}
/**
 *  发送错误
 **/
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError * _Nullable)error{
    
    self.pushCount = 0;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *currentStatu = [userDefaults valueForKey:@"Statu"];
    
    //程序在前台才进行重连
    if ([currentStatu isEqualToString:@"foreground"]) {
        
        //重连次数
        self.reconnectCount++;
        
        //如果连接失败 累加1秒重新连接 减少服务器压力
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 * self.reconnectCount target:self selector:@selector(reconnectServer) userInfo:nil repeats:NO];
        
        self.timer = timer;
    }
    
    if (tag == 200) {
        NSLog(@"client发送失败-->%@",error);
    }
    TTAlertNoTitle([error description]);
    
    
}



void TTAlertNoTitle(NSString* message) {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:nil];
    [alert show];
    
}




//如果连接失败,5秒后重新连接
- (void)reconnectServer {
    
    self.pushCount = 0;
    
    self.reconnectCount = 0;
    
    //连接失败重新连接
    NSError *error = nil;
    [self.udp_socket connectToHost:SocketHost onPort:SocketPort error:&error];
    if (error) {
        NSLog(@"SocektConnectError:%@",error);
    }
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
    
//    [self.udp_socket closeAfterSending];
    [self.udp_socket close];
    
}


















//
//- (void)socketWriteData:(NSString *)data {
//    NSData *requestData = [data dataUsingEncoding:NSUTF8StringEncoding];
//    [self.socket writeData:requestData withTimeout:-1 tag:0];
//    [self socketBeginReadData];
//}
//- (void)socketBeginReadData {
//    [self.socket readDataToData:[GCDAsyncSocket CRLFData] withTimeout:10 maxLength:0 tag:0];
//}
//


@end
























