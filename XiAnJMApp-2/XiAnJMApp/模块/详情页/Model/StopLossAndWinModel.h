//
//  StopLossAndWinModel.h
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/8/15.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StopLossAndWinModel : NSObject


@property (nonatomic,strong) NSMutableArray *data;

@property (nonatomic,copy) NSString *StockID;//合约
@property (nonatomic,copy) NSString *TradeType_Id;//方向  0-买   1-卖
@property (nonatomic,copy) NSString *Lot;//手数
@property (nonatomic,copy) NSString *Price;//均价
//@property (nonatomic,copy) NSString *CloseProfit;//盈亏


- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)dicInitWithDic:(NSDictionary *)dic;

@end
