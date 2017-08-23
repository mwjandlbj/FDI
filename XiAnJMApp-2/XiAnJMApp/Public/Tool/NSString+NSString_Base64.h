//
//  NSString+NSString_Base64.h
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/6/5.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSString_Base64)

/**
 *  转换为Base64编码
 */
- (NSString *)base64EncodedString;
/**
 *  将Base64编码还原
 */
- (NSString *)base64DecodedString;

@end
