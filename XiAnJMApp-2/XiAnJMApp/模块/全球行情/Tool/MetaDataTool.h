//
//  MetaDataTool.h
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/22.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MetaDataTool : NSObject

+ (NSArray *)customStocks;

/*
 * 时间比对
 */
+ (BOOL)changeDateWithCompareDay:(NSString *)compareDay WithCurrentDay:(NSString *)currentDay;


/*
 * 时间比对 当前点击时间是6点前后
 */
+ (BOOL)changeDateWithCurrentHourWithCompareDay:(NSString *)compareDay WithCurrentDay:(NSString *)currentDay;


@end
