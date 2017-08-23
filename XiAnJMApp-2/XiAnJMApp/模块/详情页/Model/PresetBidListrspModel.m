//
//  PresetBidListrspModel.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/7/7.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "PresetBidListrspModel.h"

@implementation PresetBidListrspModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.BidNumber = dic[@"BidNumber"];
        self.StockID = dic[@"StockID"];
        self.TradeType = dic[@"TradeType"];
        self.Lot = dic[@"Lot"];
        self.Price = dic[@"Price"];
        self.PreseStatus = dic[@"PreseStatus"];
        self.PresrResult = dic[@"PresrResult"];
        self.CreateDate = dic[@"CreateDate"];
        self.DealDate = dic[@"DealDate"];
        self.DealBidNubmer = dic[@"DealBidNubmer"];
    }
    [self getModelDatas];
    return self;
}

+ (instancetype)dicInitWithDic:(NSDictionary *)dic {
    return [[PresetBidListrspModel alloc] initWithDic:dic];
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
    
    NSString  *BidNumber = [NSString stringWithFormat:@"%@",_BidNumber];
    [datas addObject:BidNumber];
    
    [datas addObject:_StockID];
    
    if ([self.TradeType intValue] == 0) {
        NSString  *str = @"买";
        [datas addObject:str];
    }else {
        NSString  *str = @"卖";
        [datas addObject:str];
    }
    
    
    NSString  *Lot = [NSString stringWithFormat:@"%@",_Lot];
    [datas addObject:Lot];
    
    NSString  *Price = [NSString stringWithFormat:@"%@",_Price];
    [datas addObject:Price];
    
    
    if ([self.PreseStatus intValue] == 0) {
        NSString  *str = @"未触发";
        [datas addObject:str];
    }else if ([self.PreseStatus intValue] == 1){
        NSString  *str = @"已触发";
        [datas addObject:str];
    }else if ([self.PreseStatus intValue] == 2){
        NSString  *str = @"已撤销";
        [datas addObject:str];
    }else {
        NSString  *str = @"已失效";
        [datas addObject:str];
    }
    
    if ([self.PresrResult intValue] == 1) {
        NSString  *str = @"成功";
        [datas addObject:str];
    }else {
        NSString  *str = @"--";
        [datas addObject:str];
    }
    
    //[datas addObject:_CreateDate];
    
    //    if (_CreateDate.length > 17) {
    NSArray  *CreateDate = [_CreateDate componentsSeparatedByString:@"T"];
    NSString *CreateDateStr = [NSString stringWithFormat:@"%@\n%@",[CreateDate firstObject],[CreateDate lastObject]];
    [datas addObject:CreateDateStr];
    //    }
    
    NSArray  *DealDate = [_DealDate componentsSeparatedByString:@"T"];
    NSString *DealDateStr = [NSString stringWithFormat:@"%@\n%@",[DealDate firstObject],[DealDate lastObject]];
    [datas addObject:DealDateStr];
    
    NSString  *DealBidNubmer = [NSString stringWithFormat:@"%@",_DealBidNubmer];
    [datas addObject:DealBidNubmer];
    
    self.data = [NSMutableArray arrayWithArray:datas];
    
}

@end
