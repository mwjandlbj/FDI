//
//  WKRequestManager+WK.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/19.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "WKRequestManager+WK.h"
#import "MJExtension.h"
#define BKDataRequestTimeOut 8



@implementation WKRequestManager (WK)

-(NSString*)bkCurrentTime {
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    long long a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%lld", a];
    return timeString;
}

/**
 数据请求
 
 @param method 请求方式
 @param URLString 请求地址
 @param parameters 参数
 @param success 成功回调
 @param failure 失败回调
 */
-(void)wkDataRequest:(RequestMethod)method URLString:(NSString*)URLString parameters:(NSDictionary<NSString*, id>*)parameters success:(void (^)(id responseObject))success failure:(void(^)(id responseObject, NSError *error))failure {
    NSMutableString *body = [[NSMutableString alloc]init];;
    for(NSString *key in [parameters allKeys]){
        NSString *value= [parameters objectForKey:key];
        [body appendString:[NSString stringWithFormat:@"%@=%@&",key,value]];
    }
    
    
    NSError *exError;
    NSMutableURLRequest *request = [self HTTPRequestWithMethod:method URLString:URLString parameters:parameters error:&exError];
    if(exError) {
        failure(nil, exError);
        return;
    }
    
    request.timeoutInterval = BKDataRequestTimeOut;
    
    [self bkRequestHeaderFiledConfig:request parameters:parameters validateURL:URLString];
    
    [self dataWithRequest:request responseConfig:^id<AFURLResponseSerialization> _Nullable{
        
        AFHTTPResponseSerializer *serializer;
        if(parameters && [parameters.allKeys containsObject:@"service"]) {
            serializer = [AFHTTPResponseSerializer serializer];
        } else {
            serializer = [AFJSONResponseSerializer serializer];
            [serializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain", nil]];
        }
        
        return serializer;
    } completionHandler:^(NSURLResponse * _Nullable response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
        NSString *jsonStr = [responseObject mj_JSONString];
        
        NSLog(@"\n\n\n[---POST----Result----%li--]:%@     --request.URL-->%@\n\n\n",(long)httpResponse.statusCode,jsonStr,httpResponse.URL);
        if(error) {
            
            if(httpResponse.statusCode == 502 && error.userInfo[@"NSUnderlyingError"] != nil) {
                
                failure(responseObject, error.userInfo[@"NSUnderlyingError"]);
            } else {
                failure(responseObject, error);
            }
        } else {
            
            [[WKRequestManager manager] bkErrorFilter:URLString data:responseObject success:success retryReady:^(NSString *ST) {
                
                [[WKRequestManager manager] wkDataRequest:method URLString:URLString parameters:parameters success:success failure:failure];
            } failure:failure];
        }
        
    }];
}



-(void)bkRequestHeaderFiledConfig:(NSMutableURLRequest*)request parameters:(NSDictionary*)parameters validateURL:(NSString*)validateURL {
    
    NSDictionary *headerFields = [self bkHeaderContexts:parameters validateURL:validateURL];
    for (NSString *key in headerFields) {
        [request setValue:headerFields[key] forHTTPHeaderField:key];
    }
}
-(NSDictionary*)bkHeaderContexts:(NSDictionary<NSString*, id>*)parameters validateURL:(NSString*)validateURL {
    
    
    NSMutableDictionary *head_dic = [[NSMutableDictionary alloc] initWithCapacity:5];
    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
    NSString* versionNum =[infoDict objectForKey:@"CFBundleVersion"];
    NSString *version = [NSString stringWithFormat:@"%@.%@",[infoDict objectForKey:@"CFBundleShortVersionString"],versionNum];
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
    
    return head_dic;
}
/**
 验证返回数据是否可用 （主要判断令牌失效的情况,其他交由调用者去处理）
 */
-(void)bkErrorFilter:(NSString*)URLString data:(id)responseObject success:(void (^)(id responseObject))success retryReady:(void(^)(NSString *ST))retryReady failure:(void(^)(id responseObject, NSError *error))failure {
    if(![responseObject isKindOfClass:[NSDictionary class]]) {
        success(responseObject);
        return;
    }
    
    id codeValue = responseObject[@"code"];
    
    if(!codeValue || [codeValue isEqual:[NSNull null]] || [codeValue isEqualToString:@""]) {
        success(responseObject);
        return;
    }
    
    NSString *code = [NSString stringWithFormat:@"%@", codeValue];
    if([code isEqualToString:@"023"]) {
        
    } else if([code isEqualToString:@"025"]) { //令牌失效
        
        
    } else if([code isEqualToString:@"030"]) { //非法请求
        
    }else {
        success(responseObject);
    }
    
}

@end
