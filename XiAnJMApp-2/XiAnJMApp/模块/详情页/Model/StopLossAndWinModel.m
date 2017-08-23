//
//  StopLossAndWinModel.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/8/15.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "StopLossAndWinModel.h"

@implementation StopLossAndWinModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.StockID = dic[@"StockID"];
        self.TradeType_Id = dic[@"TradeType_Id"];
        self.Lot = dic[@"Lot"];
        self.Price = dic[@"Price"];
        
        
    }
    [self getModelDatas];
    return self;
}

+ (instancetype)dicInitWithDic:(NSDictionary *)dic {
    
    return [[StopLossAndWinModel alloc] initWithDic:dic];
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
    
    
    [datas addObject:_StockID];
    
    if ([self.TradeType_Id intValue] == 0) {
        NSString  *str = @"买";
        [datas addObject:str];
    }else {
        NSString  *str = @"卖";
        [datas addObject:str];
    }
    
    NSString  *Lot = [NSString stringWithFormat:@"%@",_Lot];
    [datas addObject:Lot];
    
    
    //??? 计算----均价
    NSString  *Price = [NSString stringWithFormat:@"%@",_Price];
    [datas addObject:Price];
    
    
    self.data = [NSMutableArray arrayWithArray:datas];
    
    
}



@end
