//
//  MetaDataTool.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/22.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//


#import "MetaDataTool.h"
#import "Stock.h"

@implementation MetaDataTool

+ (NSArray *)customStocks{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"customStocks.plist" ofType:nil]];
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        Stock *stock = [Stock new];
        [stock setValuesForKeysWithDictionary:dic];
        [mutableArray addObject:stock];
    }
    return mutableArray;
}

/*
 * 时间比对
 */
+ (BOOL)changeDateWithCompareDay:(NSString *)compareDay WithCurrentDay:(NSString *)currentDay {
    
//    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
//    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss "];//设置时间显示的格式，此处使用的formater格式要与字符串格式完全一致，否则转换失败
//    NSDate  *daydate = [formater dateFromString:day];
    
    NSArray  *arr = [compareDay componentsSeparatedByString:@"T"];
    
    NSString *qian = [arr firstObject];
    NSString *hou = [arr lastObject];
    NSArray  *array = [currentDay componentsSeparatedByString:@"-"];
    NSString *day = [array lastObject];
    
    NSString *tomorrow = [NSString stringWithFormat:@"%@-%@-%d",array[0],array[1],[day intValue]+1];
    
    NSString *todayMoring = [NSString stringWithFormat:@"%@ %@",currentDay,@"06:00:00.000"];
    
    NSString *tomorrowMoring = [NSString stringWithFormat:@"%@ %@",tomorrow,@"06:00:00.000"];
    
    NSString *choose = [NSString stringWithFormat:@"%@ %@",qian,hou];
    
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss.SSS"];
    

    NSDate  *dateTodayMoring = [dateFormatter dateFromString:todayMoring];
    NSTimeInterval  disTodayMoring = [dateTodayMoring timeIntervalSince1970];
    
    NSDate  *dateTomorrowMoring = [dateFormatter dateFromString:tomorrowMoring];
    NSTimeInterval  disTomorrowMoring = [dateTomorrowMoring timeIntervalSince1970];
    
    
    NSDate  *datechoose = [dateFormatter dateFromString:choose];
    NSTimeInterval  dischoose = [datechoose timeIntervalSince1970];
    
    
    if (dischoose>disTodayMoring && dischoose<disTomorrowMoring) {
        
        NSLog(@"在中间-----在中间-----在中间-----在中间-----");
        return YES;
    }else {
        NSLog(@"不在-----不在-----不在-----不在-----不在-----");
        return NO;
    }
    
    
}


/*
 * 时间比对 当前点击时间是6点前后
 */
+ (BOOL)changeDateWithCurrentHourWithCompareDay:(NSString *)compareDay WithCurrentDay:(NSString *)currentDay{
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *DateTime = [formatter stringFromDate:date];
    NSLog(@"%@============年-月-日  时：分：秒=====================",DateTime);
    
    NSArray  *are = [DateTime componentsSeparatedByString:@" "];
    NSString *hour = [are lastObject];
    NSArray  *aer = [hour componentsSeparatedByString:@":"];
    NSString *houur = [aer firstObject];
    NSLog(@"---当前是几点 ---%@",houur);
    
    
    
    NSArray  *arr = [compareDay componentsSeparatedByString:@"T"];
    
    NSString *qian = [arr firstObject];
    NSString *hou = [arr lastObject];
    NSArray  *array = [currentDay componentsSeparatedByString:@"-"];
    
    NSString *day = [array lastObject];
    
    NSString *tomorrow = [NSString stringWithFormat:@"%@-%@-%d",array[0],array[1],[day intValue]+1];
    
    NSString *yestoday = [NSString stringWithFormat:@"%@-%@-%d",array[0],array[1],[day intValue]-1];
    
    
    NSString *todayMoring = [NSString stringWithFormat:@"%@ %@",currentDay,@"06:00:00.000"];
    
    NSString *tomorrowMoring = [NSString stringWithFormat:@"%@ %@",tomorrow,@"06:00:00.000"];
    
    NSString *yestodayMoring = [NSString stringWithFormat:@"%@ %@",yestoday,@"06:00:00.000"];
    
    NSString *choose = [NSString stringWithFormat:@"%@ %@",qian,hou];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss.SSS"];
    
    NSDate  *dateTodayMoring = [dateFormatter dateFromString:todayMoring];
    NSTimeInterval  disTodayMoring = [dateTodayMoring timeIntervalSince1970];
    
    NSDate  *dateTomorrowMoring = [dateFormatter dateFromString:tomorrowMoring];
    NSTimeInterval  disTomorrowMoring = [dateTomorrowMoring timeIntervalSince1970];
    
    NSDate  *dateYestodayMoring = [dateFormatter dateFromString:yestodayMoring];
    NSTimeInterval  disYestodayMoring = [dateYestodayMoring timeIntervalSince1970];
    
    NSDate  *datechoose = [dateFormatter dateFromString:choose];
    NSTimeInterval  dischoose = [datechoose timeIntervalSince1970];
    
    if ([houur intValue] < 6) {// 6点前 点击
        
        if (dischoose > disYestodayMoring && dischoose < disTodayMoring) {
            NSLog(@"小于6--在中间-----在中间-----在中间-----在中间-----");
            return YES;
        }else {
            NSLog(@"小于6--不在-----不在-----不在-----不在-----不在-----");
            return NO;
        }
        
    }else {//
        
        if (dischoose > disTodayMoring && dischoose < disTomorrowMoring) {
            NSLog(@"大于等于6--在中间-----在中间-----在中间-----在中间-----");
            return YES;
        }else {
            NSLog(@"大于等于6--不在-----不在-----不在-----不在-----不在-----");
            return NO;
        }
        
    }


}
@end
