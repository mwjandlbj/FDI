//
//  UDPManager.h
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/26.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncUdpSocket.h"

/**
 *  业务类型
 */
typedef NS_ENUM(NSInteger, UDP_ACRequestType) {
    UDP_ACRequestType_Beat = 1,                       //心跳
    UDP_ACRequestType_GetConversationsList,           //获取会话列表
    UDP_ACRequestType_ConnectionAuthAppraisal = 7,        //连接鉴权
};
//typedef void (^SocketDidReadBlock)(NSError *__nullable error, id __nullable data);
@interface UDPManager : NSObject

//@property (nonatomic,assign)BOOL isConect;
@property(nonatomic,strong) GCDAsyncUdpSocket * udp_socket;

//单例
+ (instancetype)sharedSocketManager;

//连接
- (void)connectToServer;

//断开
- (void)cutOffSocket;



@end
