//
//  NSString+NSString_Base64.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/6/5.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "NSString+NSString_Base64.h"

@implementation NSString (NSString_Base64)


/**
 *  转换为Base64编码
 */
- (NSString *)base64EncodedString;
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}


/**
 *  将Base64编码还原
 */
- (NSString *)base64DecodedString
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}


@end
