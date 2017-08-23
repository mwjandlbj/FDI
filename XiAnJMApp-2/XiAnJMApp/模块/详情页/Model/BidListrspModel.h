//
//  BidListrspModel.h
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/7/6.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BidListrspModel : NSObject

@property (nonatomic,strong) NSMutableArray *data;

@property (nonatomic,copy) NSString *BidNumber;//编号
@property (nonatomic,copy) NSString *StockID;//合约
@property (nonatomic,copy) NSString *Trade_ID;//方向  0-买   1-卖
@property (nonatomic,copy) NSString *Order_Id;//开平  0-开   1-平
@property (nonatomic,copy) NSString *BidLot;//手数
@property (nonatomic,copy) NSString *DealPrice;//价格
@property (nonatomic,copy) NSString *TriggerMode;//类型  0-市价   1-限价
@property (nonatomic,copy) NSString *CreateDate;//成交时间


- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)dicInitWithDic:(NSDictionary *)dic;

@end
