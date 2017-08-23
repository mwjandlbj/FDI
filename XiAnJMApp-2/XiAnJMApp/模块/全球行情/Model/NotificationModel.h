//
//  NotificationModel.h
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/7/14.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationModel : NSObject

@property (nonatomic,strong) NSMutableArray *data;

@property (nonatomic,copy) NSString *Title;
@property (nonatomic,copy) NSString *CreateDate;
@property (nonatomic,copy) NSString *Content;

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)dicInitWithDic:(NSDictionary *)dic;

@end
