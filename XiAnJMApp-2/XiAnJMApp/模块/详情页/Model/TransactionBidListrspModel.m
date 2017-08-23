//
//  TransactionBidListrspModel.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/7/28.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "TransactionBidListrspModel.h"

@implementation TransactionBidListrspModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        
        self.StockID = dic[@"StockID"];
        self.Trade_ID = dic[@"Trade_ID"];

        self.BidLot = dic[@"BidLot"];
        self.DealPrice = dic[@"DealPrice"];
        self.TriggerMode = dic[@"TriggerMode"];
        self.CreateDate = dic[@"CreateDate"];
        self.BidNumber = dic[@"BidNumber"];
    }
    [self getModelDatas];
    return self;
}

+ (instancetype)dicInitWithDic:(NSDictionary *)dic {
    return [[TransactionBidListrspModel alloc] initWithDic:dic];
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
    
    if ([self.Trade_ID intValue] == 0) {
        NSString  *str = @"买";
        [datas addObject:str];
    }else {
        NSString  *str = @"卖";
        [datas addObject:str];
    }
    

    
    NSString  *bidLot = [NSString stringWithFormat:@"%@",_BidLot];
    [datas addObject:bidLot];
    
    NSString  *dealPrice = [NSString stringWithFormat:@"%@",_DealPrice];
    [datas addObject:dealPrice];
    
    if ([self.TriggerMode intValue] == 0) {
        NSString  *str = @"市价";
        [datas addObject:str];
    }else {
        NSString  *str = @"限价";
        [datas addObject:str];
    }
    
    
    //[datas addObject:_CreateDate];
    
    //    if (_CreateDate.length > 17) {
    NSArray  *date = [_CreateDate componentsSeparatedByString:@"T"];
    NSString *str = [NSString stringWithFormat:@"%@\n%@",[date firstObject],[date lastObject]];
    
    
    [datas addObject:str];
    //    }
    
    NSString  *BidNumber = [NSString stringWithFormat:@"%@",_BidNumber];
    [datas addObject:BidNumber];
    
    self.data = [NSMutableArray arrayWithArray:datas];
    
}

@end
