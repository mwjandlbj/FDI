//
//  BillQueryTableViewCell.h
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/7/13.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BillQueryModel.h"

@interface BillQueryTableViewCell : UITableViewCell

@property (nonatomic, retain) BillQueryModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView WithNumberOfLabels:(NSInteger)number;

@end
