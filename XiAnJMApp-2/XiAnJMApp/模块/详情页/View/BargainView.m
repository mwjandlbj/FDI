//
//  BargainView.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/6/16.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "BargainView.h"
#import "Common.h"

@implementation BargainView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGB(30,36,46);
        [self initView];
        
    }
    return self;
}

- (void)initView {
    
//    _bargainTableview = [UITableView new];
////    bargainTableview.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-44);
//    _bargainTableview.backgroundColor = RGB(30,36,46);
//    [self addSubview:_bargainTableview];
//    [_bargainTableview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(0);
//        make.top.equalTo(self).offset(0);
//        make.right.equalTo(self).offset(0);
//        make.bottom.equalTo(self).offset(-44);
//        
//        
//    }];
    
    
    
    UIView   *view = [UIView new];
//    view.frame = CGRectMake(0, self.frame.size.height-44, self.frame.size.width, 44);
    view.backgroundColor = RGB(30,36,46);;
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
//        make.top.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
        make.height.mas_equalTo(32);
        
    }];
    
    _yingkui = [UILabel new];
//    label1.frame = CGRectMake(0, 0, view.frame.size.width/3, 44);
    _yingkui.text = @"平仓盈亏：---";
    _yingkui.textAlignment = NSTextAlignmentCenter;
    _yingkui.textColor = [UIColor whiteColor];
    _yingkui.font = [UIFont systemFontOfSize:12];
//    _yingkui.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    _yingkui.backgroundColor = RGB(30,36,46);
    _yingkui.layer.borderWidth = 1;
    _yingkui.layer.borderColor = [RGB(42,55,68) CGColor];
    [view addSubview:_yingkui];
    [_yingkui mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(0);
        make.top.equalTo(view).offset(0);
//        make.right.equalTo(view).offset(0);
        make.bottom.equalTo(view).offset(0);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
    
    _shouxufei = [UILabel new];
//    label2.frame = CGRectMake(view.frame.size.width/3, 0, view.frame.size.width/3, 44);
    _shouxufei.text = @"手续费：---";
    _shouxufei.textAlignment = NSTextAlignmentCenter;
    _shouxufei.textColor = [UIColor whiteColor];
    _shouxufei.font = [UIFont systemFontOfSize:12];
//    _shouxufei.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];;
    _shouxufei.backgroundColor = RGB(30,36,46);
    _shouxufei.layer.borderWidth = 1;
    _shouxufei.layer.borderColor = [RGB(42,55,68) CGColor];
    [view addSubview:_shouxufei];
    [_shouxufei mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_yingkui.mas_right).offset(0);
        make.top.equalTo(view).offset(0);
        //        make.right.equalTo(view).offset(0);
        make.bottom.equalTo(view).offset(0);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
    
    
    _chengjiao = [UILabel new];
//    label3.frame = CGRectMake(view.frame.size.width/3*2, 0, view.frame.size.width/3, 44);
    _chengjiao.text = @"成交手数：---";
    _chengjiao.textAlignment = NSTextAlignmentCenter;
    _chengjiao.textColor = [UIColor whiteColor];
    _chengjiao.font = [UIFont systemFontOfSize:12];
//    _chengjiao.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    _chengjiao.backgroundColor = RGB(30,36,46);
    _chengjiao.layer.borderWidth = 1;
    _chengjiao.layer.borderColor = [RGB(42,55,68) CGColor];
    [view addSubview:_chengjiao];
    [_chengjiao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shouxufei.mas_right).offset(0);
        make.top.equalTo(view).offset(0);
        //        make.right.equalTo(view).offset(0);
        make.bottom.equalTo(view).offset(0);
//        make.width.mas_equalTo(kScreenWidth/3);
        make.right.equalTo(view).offset(0);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
