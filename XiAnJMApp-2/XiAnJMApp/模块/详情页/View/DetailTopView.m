//
//  DetailTopView.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/6/27.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "DetailTopView.h"

#import "Common.h"

//#define kSelfWidth  self.frame.size.width


@implementation DetailTopView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGB(24,26,30);
        [self initView];
        
        
    }
    return self;
}

- (void)initView {
   
    _view_left1=[[UIView alloc]init];
    _view_left1.backgroundColor=RGB(30, 36, 46);
    _view_left1.layer.cornerRadius=5;
    _view_left1.layer.borderWidth = 1;
    _view_left1.layer.borderColor = [RGB(44, 52, 60) CGColor];
    [self addSubview:_view_left1];
    [_view_left1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(4);
        make.width.mas_equalTo(kScreenWidth*0.317);
        make.height.mas_equalTo(kScreenWidth*0.147);
        //        make.bottom.equalTo(self.mas_bottom);
        make.top.equalTo(self.mas_top).offset(4);
        
    }];
    
    
    _lab_left_number1 = [UILabel new];
    _lab_left_number1.text = @"---";
    //    _lab_left_number1.backgroundColor = [UIColor yellowColor];
    _lab_left_number1.textAlignment = NSTextAlignmentCenter;
    _lab_left_number1.font = [UIFont systemFontOfSize:21];
    _lab_left_number1.textColor = RGB(44, 179, 120);
    [_view_left1 addSubview:_lab_left_number1];
    [_lab_left_number1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_view_left1.mas_left).offset(18);
        make.top.equalTo(_view_left1).offset(8);
        make.right.equalTo(_view_left1.mas_right).offset(-18);
        make.bottom.equalTo(_view_left1).offset(-24);
    }];
    
    _lab_left_number2 = [UILabel new];
    _lab_left_number2.text = @"-- --";
    //    _lab_left_number2.backgroundColor = [UIColor yellowColor];
    _lab_left_number2.textAlignment = NSTextAlignmentCenter;
    _lab_left_number2.font = [UIFont systemFontOfSize:14];
    _lab_left_number2.textColor = RGB(44, 179, 120);
    [_view_left1 addSubview:_lab_left_number2];
    [_lab_left_number2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_view_left1).offset(11);
        make.top.equalTo(_lab_left_number1.mas_bottom).offset(4);
        make.right.equalTo(_view_left1).offset(-11);
        make.bottom.equalTo(_view_left1.mas_bottom).offset(-4);
    }];
    
    
    _view_left2=[[UIView alloc]init];
    _view_left2.layer.cornerRadius=5;
    [self addSubview:_view_left2];
    _view_left2.layer.borderWidth=1;
    _view_left2.layer.borderColor = [RGB(44, 52, 60) CGColor];
    _view_left2.backgroundColor=RGB(30, 36, 46);
    [_view_left2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(4);
        make.width.mas_equalTo(kScreenWidth*0.317);
        make.height.mas_equalTo(kScreenWidth*0.076);
        //        make.bottom.equalTo(self.mas_bottom);
        make.top.equalTo(_view_left1.mas_bottom).offset(1);
        
    }];
    
    _lab_left_number3 = [UILabel new];
    //_lab_left_number3.text = @"自选市场";
    //    _lab_left_number3.backgroundColor = [UIColor yellowColor];
    _lab_left_number3.textAlignment = NSTextAlignmentCenter;
    _lab_left_number3.font = [UIFont systemFontOfSize:13];
    _lab_left_number3.textColor = RGB(227, 74, 80);
    [_view_left2 addSubview:_lab_left_number3];
    [_lab_left_number3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_view_left2).offset(17);
        make.top.equalTo(_view_left2).offset(7);
        make.right.equalTo(_view_left2).offset(-17);
        make.bottom.equalTo(_view_left2).offset(-7);
    }];
    
    
    //    右
    _view_right=[[UIView alloc]init];
    _view_right.backgroundColor=RGB(30, 36, 46);
    _view_right.layer.cornerRadius=5;
    _view_right.layer.borderWidth = 1;
    _view_right.layer.borderColor = [RGB(44, 52, 60) CGColor];
    [self addSubview:_view_right];
    [_view_right mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_view_left2.mas_right).offset(4);
        make.bottom.equalTo(self.mas_bottom).offset(-4);
        make.top.equalTo(self.mas_top).offset(4);
        make.right.equalTo(self.mas_right).offset(-4);
        
    }];
    
    _lab_Max = [UILabel new];
    _lab_Max.text = @"最高";
//    _lab_Max.bounds = CGRectMake(0, 0, kScreenWidth*0.107, kScreenWidth*0.04);
//    _lab_Max.center = CGPointMake(self.center.x/5.5, self.center.y*1.2);
    _lab_Max.frame = CGRectMake(11, kScreenWidth*0.053, kScreenWidth*0.127, 15);
//        _lab_Max.backgroundColor = [UIColor yellowColor];
    _lab_Max.textAlignment = NSTextAlignmentCenter;
    _lab_Max.font = [UIFont systemFontOfSize:14];
    _lab_Max.textColor = RGB(255, 255, 255);
    [_view_right addSubview:_lab_Max];
    //    [_lab_Max mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    ////        make.left.equalTo(_view_right).offset(9);
    ////        make.top.equalTo(_view_right).offset(20);
    ////        make.right.equalTo(_view_right).offset(-194);
    ////        make.bottom.equalTo(_view_right).offset(-51);
    //
    //
    //        make.left.equalTo(_view_right).offset(9);
    //        make.top.equalTo(_view_right).offset(20);
    ////        make.right.equalTo(_view_right).offset(-194);
    //        make.bottom.equalTo(_view_right).offset(-51);
    //        make.width.mas_equalTo(40);
    //
    //    }];
    
    
    _lab_Max_number = [UILabel new];
//    _lab_Max_number.bounds = CGRectMake(0, 0, kScreenWidth*0.12, kScreenWidth*0.04);
//    _lab_Max_number.center = CGPointMake(self.center.x/2.2, self.center.y*1.2);
    _lab_Max_number.frame = CGRectMake(11+kScreenWidth*0.127, kScreenWidth*0.053, kScreenWidth*0.127, 15);
    _lab_Max_number.text = @"---";
    //    _lab_Max_number.backgroundColor = [UIColor yellowColor];
    _lab_Max_number.textAlignment = NSTextAlignmentCenter;
    _lab_Max_number.font = [UIFont systemFontOfSize:10];
    _lab_Max_number.textColor = RGB(227, 74, 80);
    [_view_right addSubview:_lab_Max_number];
    //    [_lab_Max_number mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.left.equalTo(_view_right).offset(56);
    //        make.top.equalTo(_view_right).offset(20);
    //        make.right.equalTo(_view_right).offset(-150);
    //        make.bottom.equalTo(_view_right).offset(-51);
    //    }];
    
    _lab_Sell = [UILabel new];
//    _lab_Sell.bounds = CGRectMake(0, 0, kScreenWidth*0.107, kScreenWidth*0.04);
//    _lab_Sell.center = CGPointMake(self.center.x/1.25, self.center.y*1.2);
    _lab_Sell.frame = CGRectMake(11+kScreenWidth*0.127*2, kScreenWidth*0.053, kScreenWidth*0.127, 15);
    _lab_Sell.text = @"卖价";
    //    _lab_Sell.backgroundColor = [UIColor yellowColor];
    _lab_Sell.textAlignment = NSTextAlignmentCenter;
    _lab_Sell.font = [UIFont systemFontOfSize:14];
    _lab_Sell.textColor = RGB(255, 255, 255);
    [_view_right addSubview:_lab_Sell];
    //    [_lab_Sell mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.left.equalTo(_view_right).offset(93);
    //        make.top.equalTo(_view_right).offset(20);
    //        make.right.equalTo(_view_right).offset(-113);
    //        make.bottom.equalTo(_view_right).offset(-51);
    //    }];
    
    
    _lab_Sell_number = [UILabel new];
//    _lab_Sell_number.bounds = CGRectMake(0, 0, kScreenWidth*0.12, kScreenWidth*0.04);
//    _lab_Sell_number.center = CGPointMake(self.center.x*1.12, self.center.y*1.2);
    _lab_Sell_number.frame = CGRectMake(11+kScreenWidth*0.127*3, kScreenWidth*0.053, kScreenWidth*0.127, 15);
    _lab_Sell_number.text = @"---";
    //    _lab_Sell_number.backgroundColor = [UIColor yellowColor];
    _lab_Sell_number.textAlignment = NSTextAlignmentCenter;
    _lab_Sell_number.font = [UIFont systemFontOfSize:10];
    _lab_Sell_number.textColor = RGB(46, 178, 141);
    [_view_right addSubview:_lab_Sell_number];
    //    [_lab_Sell_number mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.left.equalTo(_view_right).offset(131);
    //        make.top.equalTo(_view_right).offset(20);
    //        make.right.equalTo(_view_right).offset(-78);
    //        make.bottom.equalTo(_view_right).offset(-51);
    //    }];
    
    
    _lab_MaxSell_num = [UILabel new];
//    _lab_MaxSell_num.bounds = CGRectMake(0, 0, kScreenWidth*0.08, kScreenWidth*0.04);
//    _lab_MaxSell_num.center = CGPointMake(self.center.x*1.4, self.center.y*1.2);
    _lab_MaxSell_num.frame = CGRectMake(kScreenWidth*0.127*4, kScreenWidth*0.053, kScreenWidth*0.127, 15);
    _lab_MaxSell_num.text = @"---";
    //    _lab_MaxSell_num.backgroundColor = [UIColor yellowColor];
    _lab_MaxSell_num.textAlignment = NSTextAlignmentRight;
    _lab_MaxSell_num.font = [UIFont systemFontOfSize:10];
    _lab_MaxSell_num.textColor = RGB(182, 71, 90);
//    _lab_MaxSell_num.textColor = [UIColor yellowColor];
    [_view_right addSubview:_lab_MaxSell_num];
    
    
    _lab_Min = [UILabel new];
    
//    _lab_Min.bounds = CGRectMake(0, 0, kScreenWidth*0.107, kScreenWidth*0.04);
//    _lab_Min.center = CGPointMake(self.center.x/5.5, self.center.y*2.8);
    _lab_Min.frame = CGRectMake(11, kScreenWidth*0.149, kScreenWidth*0.127, 15);
    _lab_Min.text = @"最低";
    //    _lab_Min.backgroundColor = [UIColor yellowColor];
    _lab_Min.textAlignment = NSTextAlignmentCenter;
    _lab_Min.font = [UIFont systemFontOfSize:14];
    _lab_Min.textColor = RGB(255, 255, 255);
    [_view_right addSubview:_lab_Min];
    //    [_lab_Min mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.left.equalTo(_view_right).offset(9);
    //        make.top.equalTo(_view_right).offset(56);
    //        make.right.equalTo(_view_right).offset(-194);
    //        make.bottom.equalTo(_view_right).offset(-15);
    //    }];
    
    _lab_Min_number = [UILabel new];
//    _lab_Min_number.bounds = CGRectMake(0, 0, kScreenWidth*0.12, kScreenWidth*0.04);
//    _lab_Min_number.center = CGPointMake(self.center.x/2.2, self.center.y*2.8);
    _lab_Min_number.frame = CGRectMake(11+kScreenWidth*0.127, kScreenWidth*0.149, kScreenWidth*0.127, 15);
    _lab_Min_number.text = @"---";
    //    _lab_Min_number.backgroundColor = [UIColor yellowColor];
    _lab_Min_number.textAlignment = NSTextAlignmentCenter;
    _lab_Min_number.font = [UIFont systemFontOfSize:10];
    _lab_Min_number.textColor = RGB(46, 178, 141);
    [_view_right addSubview:_lab_Min_number];
    //    [_lab_Min_number mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.left.equalTo(_view_right).offset(56);
    //        make.top.equalTo(_view_right).offset(56);
    //        make.right.equalTo(_view_right).offset(-150);
    //        make.bottom.equalTo(_view_right).offset(-15);
    //    }];
    
    _lab_Buy = [UILabel new];
//    _lab_Buy.bounds = CGRectMake(0, 0, kScreenWidth*0.107, kScreenWidth*0.04);
//    _lab_Buy.center = CGPointMake(self.center.x/1.25, self.center.y*2.8);
    _lab_Buy.frame = CGRectMake(11+kScreenWidth*0.127*2, kScreenWidth*0.149, kScreenWidth*0.127, 15);
    _lab_Buy.text = @"买价";
    //    _lab_Buy.backgroundColor = [UIColor yellowColor];
    _lab_Buy.textAlignment = NSTextAlignmentCenter;
    _lab_Buy.font = [UIFont systemFontOfSize:14];
    _lab_Buy.textColor = RGB(255, 255, 255);
    [_view_right addSubview:_lab_Buy];
    //    [_lab_Buy mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.left.equalTo(_view_right).offset(93);
    //        make.top.equalTo(_view_right).offset(56);
    //        make.right.equalTo(_view_right).offset(-113);
    //        make.bottom.equalTo(_view_right).offset(-15);
    //    }];
    
    
    _lab_Buy_number = [UILabel new];
//    _lab_Buy_number.bounds = CGRectMake(0, 0, kScreenWidth*0.12, kScreenWidth*0.04);
//    _lab_Buy_number.center = CGPointMake(self.center.x*1.12, self.center.y*2.8);
    _lab_Buy_number.frame = CGRectMake(11+kScreenWidth*0.127*3, kScreenWidth*0.149, kScreenWidth*0.127, 15);
    _lab_Buy_number.text = @"---";
    //    _lab_Buy_number.backgroundColor = [UIColor yellowColor];
    _lab_Buy_number.textAlignment = NSTextAlignmentCenter;
    _lab_Buy_number.font = [UIFont systemFontOfSize:10];
    _lab_Buy_number.textColor = RGB(46, 178, 141);
    [_view_right addSubview:_lab_Buy_number];
    //    [_lab_Buy_number mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.left.equalTo(_view_right).offset(131);
    //        make.top.equalTo(_view_right).offset(56);
    //        make.right.equalTo(_view_right).offset(-78);
    //        make.bottom.equalTo(_view_right).offset(-15);
    //    }];
    
    
    _lab_MinBuy_num = [UILabel new];
//    _lab_MinBuy_num.bounds = CGRectMake(0, 0, kScreenWidth*0.08, kScreenWidth*0.04);
//    _lab_MinBuy_num.center = CGPointMake(self.center.x*1.4, self.center.y*2.8);
    _lab_MinBuy_num.frame = CGRectMake(kScreenWidth*0.127*4, kScreenWidth*0.149, kScreenWidth*0.127, 15);
    _lab_MinBuy_num.text = @"---";
    //    _lab_MinBuy_num.backgroundColor = [UIColor yellowColor];
    _lab_MinBuy_num.textAlignment = NSTextAlignmentRight;
    _lab_MinBuy_num.font = [UIFont systemFontOfSize:10];
    _lab_MinBuy_num.textColor = RGB(46, 178, 141);
//    _lab_MinBuy_num.textColor = [UIColor yellowColor];
    [_view_right addSubview:_lab_MinBuy_num];

    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
