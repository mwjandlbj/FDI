//
//  Stock.h
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/22.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stock : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *number;
@property (nonatomic,strong) NSMutableArray *data;

@property (nonatomic,copy) NSString *ContractID;
@property (nonatomic,copy) NSString *ContractName;
@property (nonatomic,copy) NSString *PrevClose;
@property (nonatomic,copy) NSString *TodayOpen;
@property (nonatomic,copy) NSString *HighestPrice;
@property (nonatomic,copy) NSString *LowestPrice;
@property (nonatomic,copy) NSString *NewestPrice;
@property (nonatomic,copy) NSString *HoldVol;
@property (nonatomic,copy) NSString *TradeVol;
@property (nonatomic,copy) NSString *TradeTotal;
@property (nonatomic,copy) NSString *TodayBalance;
@property (nonatomic,copy) NSString *PrevBalance;
@property (nonatomic,copy) NSString *CurrentVol;
@property (nonatomic,copy) NSString *BuyPrice;
@property (nonatomic,copy) NSString *BuyVol;
@property (nonatomic,copy) NSString *SellPrice;
@property (nonatomic,copy) NSString *SellVol;
@property (nonatomic,copy) NSString *UpperLimit;
@property (nonatomic,copy) NSString *LowerLimit;
@property (nonatomic,copy) NSString *Market;
@property (nonatomic,assign) double Difference;
@property (nonatomic,assign) double DifferenceRatio;

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)dicInitWithDic:(NSDictionary *)dic;


@end
