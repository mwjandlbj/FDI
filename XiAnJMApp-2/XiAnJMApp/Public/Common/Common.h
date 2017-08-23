//
//  Common.h
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/19.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "CellModel.h"
#import "SectionModel.h"
#import "UINavigationController+Kpop.h"

#define RGB(__r, __g, __b)  [UIColor colorWithRed:(1.0*(__r)/255)\
green:(1.0*(__g)/255)\
blue:(1.0*(__b)/255)\
alpha:1.0]


#define ApplicationBackGauge 12  //到手机屏幕边缘的间距
#define ApplicationNavigationBarBackGauge 7 //导航栏图片距屏幕边缘间距

#define HexColor(hexValue) [Common hexColor:hexValue]

#define ThemeColor HexColor(0x03bfa0)


#define ScreenBounds [Common screenBounds]
#define ScreenWidth ScreenBounds.size.width
#define ScreenHeight ScreenBounds.size.height

#define SystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]


@interface Common : NSObject
/**
 *  16进制RGB色
 *
 *  @param hexValue RGB值 16进制
 */
+ (UIColor*) hexColor:(NSInteger)hexValue;

/**
 *  屏幕尺寸
 */
+ (CGRect) screenBounds;

/**
 * 根据颜色生成图片
 */
+(UIImage*) imageWithFrame:(CGRect)frame color:(UIColor*)color;

+(UIFont*)systemFontOfSize:(CGFloat)size;

+(UIFont*)boldSystemFontOfSize:(CGFloat)size;

+(BOOL)isVariableWithClass:(Class)cls varName:(NSString *)name;
@end
