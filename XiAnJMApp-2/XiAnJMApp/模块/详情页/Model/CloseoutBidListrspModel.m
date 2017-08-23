//
//  CloseoutBidListrspModel.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/7/7.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "CloseoutBidListrspModel.h"

@implementation CloseoutBidListrspModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.CloseBidNumber = dic[@"CloseBidNumber"];
        self.StockID = dic[@"StockID"];
        self.TradeID = dic[@"TradeID"];
        self.CloseOutLot = dic[@"CloseOutLot"];
        self.OpenPrice = dic[@"OpenPrice"];
        self.ClosePrice = dic[@"ClosePrice"];
        self.CloseProfit = dic[@"CloseProfit"];
        self.TradeFee = dic[@"TradeFee"];
        self.CloseTime = dic[@"CloseTime"];
    }
    [self getModelDatas];
    return self;
}

+ (instancetype)dicInitWithDic:(NSDictionary *)dic {
    return [[CloseoutBidListrspModel alloc] initWithDic:dic];
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
    
    NSString  *CloseBidNumber = [NSString stringWithFormat:@"%@",_CloseBidNumber];
    [datas addObject:CloseBidNumber];
    
    [datas addObject:_StockID];
    
    if ([self.TradeID intValue] == 0) {
        NSString  *str = @"买";
        [datas addObject:str];
    }else {
        NSString  *str = @"卖";
        [datas addObject:str];
    }
    
    
    NSString  *CloseOutLot = [NSString stringWithFormat:@"%@",_CloseOutLot];
    [datas addObject:CloseOutLot];
    
    NSString  *OpenPrice = [NSString stringWithFormat:@"%@",_OpenPrice];
    [datas addObject:OpenPrice];
    
    NSString  *ClosePrice = [NSString stringWithFormat:@"%@",_ClosePrice];
    [datas addObject:ClosePrice];
    
    NSString  *CloseProfit = [NSString stringWithFormat:@"%@",_CloseProfit];
    [datas addObject:CloseProfit];
    
    NSString  *TradeFee = [NSString stringWithFormat:@"%@",_TradeFee];
    [datas addObject:TradeFee];
    
    
    //[datas addObject:_CreateDate];
    
    //    if (_CreateDate.length > 17) {
    NSArray  *CloseTime = [_CloseTime componentsSeparatedByString:@"T"];
    NSString *str = [NSString stringWithFormat:@"%@\n%@",[CloseTime firstObject],[CloseTime lastObject]];
    
    
    [datas addObject:str];
    //    }
    
    self.data = [NSMutableArray arrayWithArray:datas];
    
}

@end
