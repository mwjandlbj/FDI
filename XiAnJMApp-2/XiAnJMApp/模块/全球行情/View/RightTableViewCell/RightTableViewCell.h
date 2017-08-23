//
//  RightTableViewCell.h
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/22.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Stock.h"

@interface RightTableViewCell : UITableViewCell

@property (nonatomic, retain) Stock *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView WithNumberOfLabels:(NSInteger)number;

@end
