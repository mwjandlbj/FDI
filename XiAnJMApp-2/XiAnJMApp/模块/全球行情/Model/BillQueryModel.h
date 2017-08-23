//
//  BillQueryModel.h
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/7/13.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BillQueryModel : NSObject

@property (nonatomic,strong) NSMutableArray *data;

@property (nonatomic,copy) NSString *StockID;
@property (nonatomic,copy) NSString *CloseOutLot;
@property (nonatomic,copy) NSString *CloseProfit;
@property (nonatomic,copy) NSString *CloseTime;

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)dicInitWithDic:(NSDictionary *)dic;


@end
