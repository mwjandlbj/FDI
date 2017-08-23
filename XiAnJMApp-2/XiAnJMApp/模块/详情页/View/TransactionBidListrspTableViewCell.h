//
//  TransactionBidListrspTableViewCell.h
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/7/28.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TransactionBidListrspModel.h"

@interface TransactionBidListrspTableViewCell : UITableViewCell

@property (nonatomic, retain) TransactionBidListrspModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView WithNumberOfLabels:(NSInteger)number;

@end
