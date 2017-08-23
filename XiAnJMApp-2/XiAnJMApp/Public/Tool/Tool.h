//
//  Tool.h
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/24.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tool : NSObject
//字符串转Data
+(NSData*)getData_from_Str:(NSString *)str;

//NSData 转NSString
+(NSString *)getStr_from_Data:(NSData *)data;

//data 转char
+(char *)getChar_from_Data:(NSData *)data;

// char 转data
+(NSData *)getData_from_Char:(char *)tempData;

+(NSString *)URLEncodedString:(NSString *)str;

//获取当前时间的时间戳
+(NSString*)getCurrentTimestamp;

/*
 * mac地址
 */
+ (NSString *)getMacAddress;



@end




















































