//
//  HttpRequest.h
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/7/11.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HttpRequest : NSObject

+ (void)requestForPostWithBlock:(void(^)(NSArray *dataArr))myBlock withURL:(NSString *)url withState:(NSString *)state withPhoneNum:(NSString *)phoneNum withNickName:(NSString *)nickName withDictionary:(NSDictionary *)dic;

@end
