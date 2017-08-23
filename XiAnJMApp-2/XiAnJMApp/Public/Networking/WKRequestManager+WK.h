//
//  WKRequestManager+WK.h
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/19.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "WKRequestManager.h"
#import "WKFileObject.h"
@interface WKRequestManager (WK)

/**
 获取当前时间
 */
-(nonnull NSString*)bkCurrentTime;


/**
 数据请求
 
 @param method 请求方式
 @param URLString 请求地址
 @param parameters 参数
 @param success 成功回调
 @param failure 失败回调
 */
-(void)wkDataRequest:(RequestMethod)method URLString:(nonnull NSString*)URLString parameters:(nullable NSDictionary<NSString*, id>*)parameters success:(nonnull void (^)(_Nullable id responseObject))success failure:(nonnull void(^)(_Nullable id responseObject,  NSError * _Nullable error))failure;


@end
