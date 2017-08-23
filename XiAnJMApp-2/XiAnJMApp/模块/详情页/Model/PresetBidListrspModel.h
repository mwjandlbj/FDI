//
//  PresetBidListrspModel.h
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/7/7.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PresetBidListrspModel : NSObject

@property (nonatomic,strong) NSMutableArray *data;

@property (nonatomic,copy) NSString *BidNumber;//编号
@property (nonatomic,copy) NSString *StockID;//合约
@property (nonatomic,copy) NSString *TradeType;//方向  0-买   1-卖
@property (nonatomic,copy) NSString *Lot;//委托手数
@property (nonatomic,copy) NSString *Price;//委托价格
@property (nonatomic,copy) NSString *PreseStatus;//委托状态  0-未触发   1-已触发  2-已撤销  3-已失效
@property (nonatomic,copy) NSString *PresrResult;//结果。  1-成功  其他展示 --
@property (nonatomic,copy) NSString *CreateDate;//创建时间
@property (nonatomic,copy) NSString *DealDate;//处理时间
@property (nonatomic,copy) NSString *DealBidNubmer;//对应单号

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)dicInitWithDic:(NSDictionary *)dic;

@end
