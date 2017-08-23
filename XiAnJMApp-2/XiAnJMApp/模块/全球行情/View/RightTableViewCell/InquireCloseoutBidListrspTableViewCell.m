//
//  InquireCloseoutBidListrspTableViewCell.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/7/7.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "InquireCloseoutBidListrspTableViewCell.h"

#import "UIView+customView.h"

@implementation InquireCloseoutBidListrspTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView WithNumberOfLabels:(NSInteger)number {
    
    static NSString *identifier = @"cell";
    // 1.缓存中取
    InquireCloseoutBidListrspTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[InquireCloseoutBidListrspTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
        UIView *view = [UIView viewWithLabelNumber:number];
        view.tag = 100;
        view.backgroundColor = RGB(30,36,46);
        [cell.contentView addSubview:view];
        
        
        
    }
    return cell;
}

- (void)setModel:(CloseoutBidListrspModel *)model{
    if (_model != model) {
        _model = model;
        [self upData];
    }
}

- (void)upData{
    //这里先使用假数据
    UIView *view = [self.contentView viewWithTag:100];
    
    for (NSInteger i = 0; i<view.subviews.count ; i++) {
        
        UILabel *label = [view viewWithTag:i];
        
        label.text = [NSString stringWithFormat:@"%@",_model.data[i]];
        label.textColor = [UIColor whiteColor];
        
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
