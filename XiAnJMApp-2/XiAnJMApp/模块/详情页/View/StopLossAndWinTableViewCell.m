//
//  StopLossAndWinTableViewCell.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/8/15.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "StopLossAndWinTableViewCell.h"

#import "Common.h"

#import "UIView+customView.h"

@implementation StopLossAndWinTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView WithNumberOfLabels:(NSInteger)number{
    static NSString *identifier = @"cell";
    // 1.缓存中取
    StopLossAndWinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[StopLossAndWinTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        view.backgroundColor = RGB(222,224,227);
        for (int i = 0; i < number; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth*0.909/4 * i, 0, kScreenWidth*0.909/4, 35)];
            label.numberOfLines = 0;
            label.tag = i;
            label.backgroundColor = [UIColor clearColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = RGB(29,38,48);
            label.font = [UIFont systemFontOfSize:11];
            [view addSubview:label];
        }
        [cell.contentView addSubview:view];
        
    }
    return cell;
}
- (void)setModel:(StopLossAndWinModel *)model{
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
