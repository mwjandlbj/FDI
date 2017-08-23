//
//  TransactionPresetBidListrspModel.h
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/7/28.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransactionPresetBidListrspModel : NSObject

@property (nonatomic,strong) NSMutableArray *data;


@property (nonatomic,copy) NSString *StockID;//合约
@property (nonatomic,copy) NSString *TradeType;//方向  0-买   1-卖
@property (nonatomic,copy) NSString *Lot;//委托手数
@property (nonatomic,copy) NSString *Price;//委托价格
@property (nonatomic,copy) NSString *PreseStatus;//委托状态  0-未触发   1-已触发  2-已撤销  3-已失效

@property (nonatomic,copy) NSString *CreateDate;//创建时间

@property (nonatomic,copy) NSString *BidNumber;//编号

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)dicInitWithDic:(NSDictionary *)dic;


@end
