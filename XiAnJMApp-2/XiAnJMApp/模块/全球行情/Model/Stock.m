//
//  Stock.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/22.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "Stock.h"

@implementation Stock

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.ContractID = dic[@"ContractID"];
        self.ContractName = dic[@"ContractName"];
        self.PrevClose = dic[@"PrevClose"];
        self.TodayOpen = dic[@"TodayOpen"];
        self.HighestPrice = dic[@"HighestPrice"];
        self.LowestPrice = dic[@"LowestPrice"];
        self.NewestPrice = dic[@"NewestPrice"];
        self.HoldVol = dic[@"HoldVol"];
        self.TradeVol = dic[@"TradeVol"];
        self.TradeTotal = dic[@"TradeTotal"];
        self.TodayBalance = dic[@"TodayBalance"];
        self.PrevBalance = dic[@"PrevBalance"];
        self.CurrentVol = dic[@"CurrentVol"];
        self.BuyPrice = dic[@"BuyPrice"];
        self.BuyVol = dic[@"BuyVol"];
        self.SellPrice = dic[@"SellPrice"];
        self.SellVol = dic[@"SellVol"];
        self.UpperLimit = dic[@"UpperLimit"];
        self.LowerLimit = dic[@"LowerLimit"];
        self.Market = dic[@"Market"];
        self.Difference = [dic[@"Difference"] doubleValue];
        self.DifferenceRatio = [dic[@"DifferenceRatio"] doubleValue];
        
    }
    
    [self getModelDatas];
    return self;
}


+ (instancetype)dicInitWithDic:(NSDictionary *)dic {
    return [[Stock alloc] initWithDic:dic];
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
     [ @"合约名称",@"最新价",@"涨跌", @"涨跌幅", @"买一", @"买量", @"卖一", @"卖量",@"成交量",@"持仓量",@"成交额",@"现量",@"最高价",@"最低价", @"今开价",@"昨收价",]
     */
    [datas addObject:_ContractName];
    [datas addObject:_NewestPrice];
    
//    NSString  *differen = [NSString stringWithFormat:@"%@",_Difference];
//    NSString  *strr = [differen substringWithRange:NSMakeRange(0, 6)];
//    [datas addObject:_Difference];
    
    //去掉后面多余的0
    NSString  *differen = [NSString stringWithFormat:@"%.4lf",_Difference];
    NSString  *dif = [NSString stringWithFormat:@"%@",@(differen.floatValue)];
    [datas addObject:dif];
    
    //转换 百分比，保留小数点后俩位  如： 1.23%   0.24%
    NSString *diffRatio = [NSString stringWithFormat:@"%.4lf",_DifferenceRatio];
    float   flot = [diffRatio floatValue];
    NSString   *diffratio = [NSString stringWithFormat:@"%.2f%%",flot*100];
    //NSString *string = [diffRatio substringWithRange:NSMakeRange(0, 6)];
    [datas addObject:diffratio];
    
    [datas addObject:_BuyPrice];
    [datas addObject:_BuyVol];
    [datas addObject:_SellPrice];
    [datas addObject:_SellVol];
    [datas addObject:_TradeVol];
    [datas addObject:_HoldVol];
    [datas addObject:_TradeTotal];
    [datas addObject:_CurrentVol];
    [datas addObject:_HighestPrice];//计算属性
    [datas addObject:_LowestPrice];//计算属性
    
    [datas addObject:_TodayOpen];
    [datas addObject:_PrevClose];
    
    self.data = [NSMutableArray arrayWithArray:datas];
    
}


@end
