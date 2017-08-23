//
//  InquireLimitBidListrspTableViewCell.h
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/7/7.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LimitBidListrspModel.h"

@interface InquireLimitBidListrspTableViewCell : UITableViewCell

@property (nonatomic, retain) LimitBidListrspModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView WithNumberOfLabels:(NSInteger)number;

@end
