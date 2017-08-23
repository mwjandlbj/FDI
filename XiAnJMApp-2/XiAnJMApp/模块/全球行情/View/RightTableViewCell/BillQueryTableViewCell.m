//
//  BillQueryTableViewCell.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/7/13.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "BillQueryTableViewCell.h"

#import "Common.h"

#import "UIView+customView.h"

@implementation BillQueryTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView WithNumberOfLabels:(NSInteger)number{
    static NSString *identifier = @"cell";
    // 1.缓存中取
    BillQueryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[BillQueryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
//        UIView *view = [UIView viewWithLabelNumber:number];
//        view.tag = 100;
//        [cell.contentView addSubview:view];
        
        UIView  *view = [UIView new];
        view.tag = 100;
        view.frame = cell.frame;
        for (int i = 0; i < number; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/3 * i, 0, kScreenWidth/3, 35)];
            label.numberOfLines = 0;
            label.tag = i;
            label.backgroundColor = RGB(224,224,224);
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = RGB(29,38,48);
            label.font = [UIFont systemFontOfSize:12];
            [view addSubview:label];
        }
        [cell.contentView addSubview:view];
        
    }
    return cell;
}

- (void)setModel:(BillQueryModel *)model{
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
        
        
        if (_model.data != nil) {
            
        
        label.text = [NSString stringWithFormat:@"%@",_model.data[i]];
//        label.text = [NSString stringWithFormat:@"%ld",(long)i];
        label.textColor = [UIColor blackColor];
        }
        
        
        if (i==2) {
            if ([_model.CloseProfit doubleValue] > 0) {
                label.textColor = RGB(227,74,80);
            }else if ([_model.CloseProfit doubleValue] < 0) {
                label.textColor = RGB(44,179,120);
            }else {
                label.textColor = [UIColor blackColor];
            }
        }
        
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
