//
//  TcpManager.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/24.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "TcpManager.h"
@interface TcpManager() <GCDAsyncSocketDelegate>

@end

@implementation TcpManager
+(TcpManager *)Share
{
    static TcpManager *manager=nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager=[[TcpManager alloc]init];
        manager.asyncsocket=[[GCDAsyncSocket alloc]initWithDelegate:manager delegateQueue:dispatch_get_main_queue()];
        
    });
    return manager;
}


-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"didConnectToHost %@ port %d",host,port);
}


-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    NSLog(@"disconnected");
}


-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    
    NSLog(@"didReadData read data");
    NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"message is: \n%@",message);
    
    //    [sock disconnect];
}


-(void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    //    [sock disconnect];
    NSLog(@"didWriteDataWithTag");
}


-(NSTimeInterval)socket:(GCDAsyncSocket *)sock shouldTimeoutWriteWithTag:(long)tag elapsed:(NSTimeInterval)elapsed bytesDone:(NSUInteger)length
{
    NSLog(@"timeout");
    
    return 0;
}

-(BOOL)destroy
{
    
    [_asyncsocket disconnect];
    return YES;
}

@end
