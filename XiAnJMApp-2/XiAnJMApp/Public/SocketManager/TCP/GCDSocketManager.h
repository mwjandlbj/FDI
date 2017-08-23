//
//  GCDSocketManager.h
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/24.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"
/**
 *  业务类型
 */
typedef NS_ENUM(NSInteger, GACRequestType) {
    GACRequestType_Beat = 1,                       //心跳
    GACRequestType_GetConversationsList,           //获取会话列表
    GACRequestType_ConnectionAuthAppraisal = 7,        //连接鉴权
};
typedef void (^SocketDidReadBlock)(NSError *__nullable error, id __nullable data);
@interface GCDSocketManager : NSObject

//@property (nonatomic,assign)BOOL isConect;
@property(nonatomic,strong) GCDAsyncSocket * _Nullable socket;

//单例
+ (instancetype _Nullable )sharedSocketManager;

//连接
- (void)connectToServer;

//断开
- (void)cutOffSocket;

/*
 * 登录
 */
-(void)Action_LoginWithAccount:(NSString * _Nullable)account withPassword:(NSString*_Nullable)password;

/*
 * 通用请求
 */
- (void)requestForUniversalWithName:(NSString *_Nullable)name WithContent:(NSString *_Nullable)content withTag:(NSInteger)tag;

/*
 * 交易请求
 */
- (void)requestForTransactionWithName:(NSString *_Nullable)name withNSDictionary:(NSDictionary *_Nullable)dic withTag:(NSInteger)tag;

/*
 * 修改密码
 */
- (void)requestForUniversalWithName:(NSString *_Nullable)name WithOldPsw:(NSString *_Nullable)oldPsw WithNewPsw:(NSString *_Nullable)newPsw WithAccount:(NSString *_Nullable)account withTag:(NSInteger)tag;

@end
