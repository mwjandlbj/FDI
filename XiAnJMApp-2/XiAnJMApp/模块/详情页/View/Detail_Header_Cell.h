//
//  Detail_Header_Cell.h
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/23.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface Detail_Header_Cell : UITableViewCell

@property (nonatomic,strong)UIView * view_left2;

/*
 * view_left1
 */
@property (nonatomic,strong)UIView * view_left1;
@property (nonatomic,strong)UILabel* lab_left_number1;
@property (nonatomic,strong)UILabel* lab_left_number2;
@property (nonatomic,strong)UILabel* lab_left_number3;


/*
 * view_right
 */
@property (nonatomic,strong)UIView * view_right;
//最高
@property (nonatomic,strong)UILabel* lab_Max;
@property (nonatomic,strong)UILabel* lab_Max_number;
//卖
@property (nonatomic,strong)UILabel* lab_Sell;
@property (nonatomic,strong)UILabel* lab_Sell_number;
//数量
@property (nonatomic,strong)UILabel* lab_MaxSell_num;

@property (nonatomic,strong)UIProgressView *view_MaxProgress;

//最低
@property (nonatomic,strong)UILabel* lab_Min;
@property (nonatomic,strong)UILabel* lab_Min_number;
//买
@property (nonatomic,strong)UILabel* lab_Buy;
@property (nonatomic,strong)UILabel* lab_Buy_number;
//数量
@property (nonatomic,strong)UILabel* lab_MinBuy_num;



+(CGFloat)computeHeight:(id)info;
-(void)relayOutUIWithModel:(id)model;
@end
