//
//  BillQueryModel.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/7/13.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "BillQueryModel.h"

@implementation BillQueryModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    
    if (self = [super init]) {
        self.StockID = dic[@"StockID"];
        self.CloseOutLot = dic[@"CloseOutLot"];
        self.CloseProfit = dic[@"CloseProfit"];
        self.CloseTime = dic[@"CloseTime"];
    }
    
    [self getModelDatas];
    return self;
}

+ (instancetype)dicInitWithDic:(NSDictionary *)dic {
    return [[BillQueryModel alloc] initWithDic:dic];
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
    /*
     * 合约，手数，盈亏
     */
    
    [datas addObject:_StockID];
    
    NSString  *lot = [NSString stringWithFormat:@"%@",_CloseOutLot];
    [datas addObject:lot];
    
    [datas addObject:_CloseProfit];
    
    
    self.data = [NSMutableArray arrayWithArray:datas];
}

@end
