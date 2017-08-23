//
//  Common.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/19.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "Common.h"
#import <objc/runtime.h>
@implementation Common

+ (UIColor*) hexColor:(NSInteger)hexValue {
    
    CGFloat red = (CGFloat)((hexValue & 0xFF0000) >> 16) / 255.0;
    CGFloat green = (CGFloat)((hexValue & 0xFF00) >> 8) /255.0;
    CGFloat blue = (CGFloat)(hexValue & 0xFF) / 255.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1];
    return color;
}

+(CGRect)screenBounds {
    return [[UIScreen mainScreen] bounds];
}

+(UIImage*) imageWithFrame:(CGRect)frame color:(UIColor*)color {
    if(CGRectEqualToRect(frame, CGRectZero)) {
        frame = CGRectMake(0, 0, 1, 1);
    }
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, frame);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+(UIFont*)systemFontOfSize:(CGFloat)size {
    
    return [UIFont systemFontOfSize:size];
}

+(UIFont*)boldSystemFontOfSize:(CGFloat)size {
    return [UIFont boldSystemFontOfSize:size];
}

+(BOOL)isVariableWithClass:(Class)cls varName:(NSString *)name {
    unsigned int outCount, i;
    Ivar *ivars = class_copyIvarList(cls, &outCount);
    for (i = 0; i < outCount; i++) {
        Ivar property = ivars[i];
        NSString *keyName = [NSString stringWithCString:ivar_getName(property) encoding:NSUTF8StringEncoding];
        keyName = [keyName stringByReplacingOccurrencesOfString:@"_" withString:@""];
        if ([keyName isEqualToString:name]) {
            return YES;
        }
    }
    return NO;
}

@end
