//
//  HttpRequest.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/7/11.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "HttpRequest.h"
#import <AFNetworking/AFNetworking.h>

@implementation HttpRequest
+ (void)requestForPostWithBlock:(void(^)(NSArray *dataArr))myBlock withURL:(NSString *)url withState:(NSString *)state withPhoneNum:(NSString *)phoneNum withNickName:(NSString *)nickName withDictionary:(NSDictionary *)dic {
    
    AFHTTPSessionManager  *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json",@"text/html", nil];
    
    
    NSString  *utf8Str = [nickName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [manager POST:[NSString stringWithFormat:@"%@?state=%@&phoneNumber=%@&nickName=%@",url,state,phoneNum,utf8Str] parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString  *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"str-------%@",str);
        
        NSMutableArray  *arr = @[].mutableCopy;
//        if (responseObject) {
//            NSDictionary  *dicc = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            
            [arr addObject:str];
//
            myBlock(arr);
//        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.localizedDescription);
    }];
    
}

@end
