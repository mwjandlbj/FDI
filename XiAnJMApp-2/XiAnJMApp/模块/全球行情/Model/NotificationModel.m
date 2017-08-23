//
//  NotificationModel.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/7/14.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "NotificationModel.h"

@implementation NotificationModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    
    if (self = [super init]) {
        self.Title = dic[@"Title"];
//        self.CreateDate = dic[@"CreateDate"];
        self.Content = dic[@"Content"];
        
        NSString  *str = dic[@"CreateDate"];
        NSArray  *arr = [str componentsSeparatedByString:@"T"];
        NSString  *stre = [NSString stringWithFormat:@"%@>>",[arr firstObject]];
        self.CreateDate = stre;
    }
    
    [self getModelDatas];
    return self;
}

+ (instancetype)dicInitWithDic:(NSDictionary *)dic {
    return [[NotificationModel alloc] initWithDic:dic];
}

//赋值
- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
}

//多余值
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)getModelDatas{
    NSMutableArray *datas = [NSMutableArray array];
    
    [datas addObject:_Title];
    
//    [datas addObject:_CreateDate];
    NSString  *str = _CreateDate;
    NSArray  *arr = [str componentsSeparatedByString:@"T"];
    NSString  *stre = [NSString stringWithFormat:@"%@>>",[arr firstObject]];
    [datas addObject:stre];
    
    [datas addObject:_Content];
    
    self.data = [NSMutableArray arrayWithArray:datas];
}

@end
