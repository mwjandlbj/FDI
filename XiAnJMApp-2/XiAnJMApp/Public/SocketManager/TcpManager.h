//
//  TcpManager.h
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/24.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"
//#import "AsyncSocket.h"
@interface TcpManager : NSObject
@property(strong,nonatomic) GCDAsyncSocket *asyncsocket;

+(TcpManager *)Share;
-(BOOL)destroy;
@end
