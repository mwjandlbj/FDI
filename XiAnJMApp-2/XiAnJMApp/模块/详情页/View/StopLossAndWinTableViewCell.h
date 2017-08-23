//
//  StopLossAndWinTableViewCell.h
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/8/15.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "StopLossAndWinModel.h"

@interface StopLossAndWinTableViewCell : UITableViewCell

@property (nonatomic, retain) StopLossAndWinModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView WithNumberOfLabels:(NSInteger)number;

@end
