//
//  BargainRightTableViewCell.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/6/28.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "BargainRightTableViewCell.h"



#import "UIView+customView.h"

@implementation BargainRightTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView WithNumberOfLabels:(NSInteger)number
{
    static NSString *identifier = @"cell";
    // 1.缓存中取
    BargainRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[BargainRightTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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

- (void)setModel:(BargainCloseOutBidListrspModel *)model{
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
        label.textColor = [UIColor whiteColor];
        }
        //        if (i == 4 && _model.Difference > 0) {
        //            label.textColor = RGB(227,74,80);
        //        }else if (i ==4 && _model.Difference < 0){
        //            label.textColor = RGB(44,179,120);
        //        }else {
        //            label.textColor = [UIColor blackColor];
        //        }
        
//        if (i==1 |i==2| i==3 |i==4| i==5 |i==6| i==7) {
//            if (_model.Difference > 0) {
//                label.textColor = RGB(227,74,80);
//            }else if (_model.Difference < 0) {
//                label.textColor = RGB(44,179,120);
//            }else {
//                label.textColor = [UIColor blackColor];
//            }
//        }
        
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
