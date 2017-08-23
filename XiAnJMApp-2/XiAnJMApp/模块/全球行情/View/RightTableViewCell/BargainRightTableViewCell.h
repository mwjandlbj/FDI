//
//  BargainRightTableViewCell.h
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/6/28.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BargainCloseOutBidListrspModel.h"

@interface BargainRightTableViewCell : UITableViewCell

@property (nonatomic, retain) BargainCloseOutBidListrspModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView WithNumberOfLabels:(NSInteger)number;

@end
