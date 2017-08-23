//
//  CloseoutBidListrspModel.h
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/7/7.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CloseoutBidListrspModel : NSObject


@property (nonatomic,strong) NSMutableArray *data;

@property (nonatomic,copy) NSString *CloseBidNumber;//编号
@property (nonatomic,copy) NSString *StockID;//合约
@property (nonatomic,copy) NSString *TradeID;//方向  0-买   1-卖
@property (nonatomic,copy) NSString *CloseOutLot;//手数
@property (nonatomic,copy) NSString *OpenPrice;//开仓价
@property (nonatomic,copy) NSString *ClosePrice;//平仓价
@property (nonatomic,copy) NSString *CloseProfit;//平仓盈亏
@property (nonatomic,copy) NSString *TradeFee;//手续费
@property (nonatomic,copy) NSString *CloseTime;//成交时间

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)dicInitWithDic:(NSDictionary *)dic;

@end
