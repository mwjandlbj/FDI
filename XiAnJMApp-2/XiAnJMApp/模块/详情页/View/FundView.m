//
//  FundView.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/6/12.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "FundView.h"
#import <Masonry/Masonry.h>

#define kSelfWidth  self.frame.size.width


@implementation FundView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGB(19,21,24);
        [self initView];
        
    }
    return self;
}

- (void)initView {
    
    _jichuhuobi = [UILabel new];
    _jichuhuobi.bounds = CGRectMake(0, 0, kSelfWidth*0.27, kSelfWidth*0.04);
    _jichuhuobi.center = CGPointMake(self.center.x/2.1, self.center.y/38);
    _jichuhuobi.text = @"基础货币(美元)";
//    _jichuhuobi.backgroundColor = [UIColor blueColor];
    _jichuhuobi.textAlignment = NSTextAlignmentLeft;
    _jichuhuobi.font = [UIFont systemFontOfSize:12];
    _jichuhuobi.textColor = RGB(222,224,227);
    [self addSubview:_jichuhuobi];
    
//    [_jichuhuobi mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(self).offset(16);
//        make.bottom.equalTo(self).offset(-297);
//        make.left.equalTo(self).offset(38);
//        make.right.equalTo(self).offset(-240);
//        
//    }];
    
    _status = [UILabel new];
    _status.bounds = CGRectMake(0, 0, kSelfWidth*0.27, kSelfWidth*0.04);
    _status.center = CGPointMake(self.center.x*1.5, self.center.y/38);
    _status.text = @"正常";
//    _status.backgroundColor = [UIColor blueColor];
    _status.textAlignment = NSTextAlignmentRight;
    _status.font = [UIFont systemFontOfSize:12];
    _status.textColor = RGB(46,178,141);
    [self addSubview:_status];
    
    
    
    //第一条
    _firstView = [UIView new];
    _firstView.bounds = CGRectMake(4, 0, kSelfWidth-8, kSelfWidth*0.1493);
    _firstView.center = CGPointMake(self.center.x, self.center.y/12.7);
    _firstView.backgroundColor = RGB(30,36,46);
    _firstView.layer.cornerRadius = 5;
    _firstView.clipsToBounds = YES;
    [self addSubview:_firstView];
//    [_firstView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).offset(39);
//        make.bottom.equalTo(self).offset(-231);
//        make.left.equalTo(self).offset(8);
//        make.right.equalTo(self).offset(0);
//    }];
    
    _keyongzijin = [UILabel new];
    _keyongzijin.text = @"可用资金:";
    _keyongzijin.font = [UIFont systemFontOfSize:13];
    _keyongzijin.textColor = RGB(222,224,227);
    _keyongzijin.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_keyongzijin];
    [_keyongzijin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstView).offset(21);
        make.bottom.equalTo(_firstView).offset(-22);
        make.left.equalTo(_firstView).offset(31);
        make.right.equalTo(_firstView).offset(-265);
    }];
    
    _keyongzijinCount = [UILabel new];
    _keyongzijinCount.text = @"---";
    _keyongzijinCount.font = [UIFont systemFontOfSize:13];
    _keyongzijinCount.textColor = RGB(222,224,227);
    _keyongzijinCount.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_keyongzijinCount];
    [_keyongzijinCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstView).offset(21);
        make.bottom.equalTo(_firstView).offset(-22);
        make.left.equalTo(_firstView).offset(94);
        make.right.equalTo(_firstView).offset(-190);
    }];
    
    _keyongquanyi = [UILabel new];
    _keyongquanyi.text = @"可用权益:";
    _keyongquanyi.font = [UIFont systemFontOfSize:13];
    _keyongquanyi.textColor = RGB(222,224,227);
    _keyongquanyi.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_keyongquanyi];
    [_keyongquanyi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstView).offset(22);
        make.bottom.equalTo(_firstView).offset(-22);
        make.left.equalTo(_firstView).offset(194);
        make.right.equalTo(_firstView).offset(-98);
    }];
    
    _keyongquanyiCount = [UILabel new];
    _keyongquanyiCount.text = @"---";
    _keyongquanyiCount.font = [UIFont systemFontOfSize:13];
    _keyongquanyiCount.textColor = RGB(222,224,227);
    _keyongquanyiCount.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_keyongquanyiCount];
    [_keyongquanyiCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstView).offset(22);
        make.bottom.equalTo(_firstView).offset(-22);
        make.left.equalTo(_firstView).offset(261);
        make.right.equalTo(_firstView).offset(-20);
    }];
    
    
    //第二条
    _secondView = [UIView new];
    _secondView.bounds = CGRectMake(4, 0, kSelfWidth-8, kSelfWidth*0.1493);
    _secondView.center = CGPointMake(self.center.x, self.center.y/6.79);
    _secondView.backgroundColor = RGB(30,36,46);
    _secondView.layer.cornerRadius = 5;
    _secondView.clipsToBounds = YES;
    [self addSubview:_secondView];
//    [_secondView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).offset(96);
//        make.bottom.equalTo(self).offset(-174);
//        make.left.equalTo(self).offset(8);
//        make.right.equalTo(self).offset(0);
//    }];
    
    _pingcangyingkui = [UILabel new];
    _pingcangyingkui.text = @"平仓盈亏:";
    _pingcangyingkui.font = [UIFont systemFontOfSize:13];
    _pingcangyingkui.textColor = RGB(222,224,227);
    _pingcangyingkui.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_pingcangyingkui];
    [_pingcangyingkui mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_secondView).offset(21);
        make.bottom.equalTo(_secondView).offset(-22);
        make.left.equalTo(_secondView).offset(31);
        make.right.equalTo(_secondView).offset(-265);
    }];
    
    _pingcangyingkuiCount = [UILabel new];
    _pingcangyingkuiCount.text = @"---";
    _pingcangyingkuiCount.font = [UIFont systemFontOfSize:13];
    _pingcangyingkuiCount.textColor = RGB(182,71,90);
    _pingcangyingkuiCount.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_pingcangyingkuiCount];
    [_pingcangyingkuiCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_secondView).offset(21);
        make.bottom.equalTo(_secondView).offset(-22);
        make.left.equalTo(_secondView).offset(94);
        make.right.equalTo(_secondView).offset(-190);
    }];
    
    _chicangyingkui = [UILabel new];
    _chicangyingkui.text = @"持仓盈亏:";
    _chicangyingkui.font = [UIFont systemFontOfSize:13];
    _chicangyingkui.textColor = RGB(222,224,227);
    _chicangyingkui.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_chicangyingkui];
    [_chicangyingkui mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_secondView).offset(22);
        make.bottom.equalTo(_secondView).offset(-22);
        make.left.equalTo(_secondView).offset(194);
        make.right.equalTo(_secondView).offset(-98);
    }];
    
    _chicangyingkuiCount = [UILabel new];
    _chicangyingkuiCount.text = @"---";
    _chicangyingkuiCount.font = [UIFont systemFontOfSize:13];
    _chicangyingkuiCount.textColor = RGB(46,178,141);
    _chicangyingkuiCount.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_chicangyingkuiCount];
    [_chicangyingkuiCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_secondView).offset(22);
        make.bottom.equalTo(_secondView).offset(-22);
        make.left.equalTo(_secondView).offset(261);
        make.right.equalTo(_secondView).offset(-20);
    }];
    
    
    //第三条
    _thirdView = [UIView new];
    _thirdView.bounds = CGRectMake(4, 0, kSelfWidth-8, kSelfWidth*0.1493);
    _thirdView.center = CGPointMake(self.center.x, self.center.y/4.64);
    _thirdView.backgroundColor = RGB(30,36,46);
    _thirdView.layer.cornerRadius = 5;
    _thirdView.clipsToBounds = YES;
    [self addSubview:_thirdView];
//    [_thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).offset(152);
//        make.bottom.equalTo(self).offset(-117);
//        make.left.equalTo(self).offset(8);
//        make.right.equalTo(self).offset(0);
//    }];
    
    _shouxufei = [UILabel new];
    _shouxufei.text = @"手 续 费:";
    _shouxufei.font = [UIFont systemFontOfSize:13];
    _shouxufei.textColor = RGB(222,224,227);
    _shouxufei.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_shouxufei];
    [_shouxufei mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_thirdView).offset(21);
        make.bottom.equalTo(_thirdView).offset(-22);
        make.left.equalTo(_thirdView).offset(31);
        make.right.equalTo(_thirdView).offset(-265);
    }];
    
    _shouxufeiCount = [UILabel new];
    _shouxufeiCount.text = @"---";
    _shouxufeiCount.font = [UIFont systemFontOfSize:13];
    _shouxufeiCount.textColor = RGB(222,224,227);
    _shouxufeiCount.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_shouxufeiCount];
    [_shouxufeiCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_thirdView).offset(21);
        make.bottom.equalTo(_thirdView).offset(-22);
        make.left.equalTo(_thirdView).offset(94);
        make.right.equalTo(_thirdView).offset(-190);
    }];
    
    _yanqifei = [UILabel new];
    _yanqifei.text = @"延 期 费:";
    _yanqifei.font = [UIFont systemFontOfSize:13];
    _yanqifei.textColor = RGB(222,224,227);
    _yanqifei.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_yanqifei];
    [_yanqifei mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_thirdView).offset(22);
        make.bottom.equalTo(_thirdView).offset(-22);
        make.left.equalTo(_thirdView).offset(194);
        make.right.equalTo(_thirdView).offset(-98);
    }];
    
    _yanqifeiCount = [UILabel new];
    _yanqifeiCount.text = @"---";
    _yanqifeiCount.font = [UIFont systemFontOfSize:13];
    _yanqifeiCount.textColor = RGB(222,224,227);
    _yanqifeiCount.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_yanqifeiCount];
    [_yanqifeiCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_thirdView).offset(22);
        make.bottom.equalTo(_thirdView).offset(-22);
        make.left.equalTo(_thirdView).offset(261);
        make.right.equalTo(_thirdView).offset(-20);
    }];
    
    
    //第四条
    _fourthView = [UIView new];
    _fourthView.bounds = CGRectMake(4, 0, kSelfWidth-8, kSelfWidth*0.1493);
    _fourthView.center = CGPointMake(self.center.x, self.center.y/3.52);
    _fourthView.backgroundColor = RGB(30,36,46);
    _fourthView.layer.cornerRadius = 5;
    _fourthView.clipsToBounds = YES;
    [self addSubview:_fourthView];
//    [_fourthView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).offset(209);
//        make.bottom.equalTo(self).offset(-60);
//        make.left.equalTo(self).offset(8);
//        make.right.equalTo(self).offset(0);
//    }];
    
    _zongyingkui = [UILabel new];
    _zongyingkui.text = @"总 盈 亏:";
    _zongyingkui.font = [UIFont systemFontOfSize:13];
    _zongyingkui.textColor = RGB(222,224,227);
    _zongyingkui.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_zongyingkui];
    [_zongyingkui mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fourthView).offset(21);
        make.bottom.equalTo(_fourthView).offset(-22);
        make.left.equalTo(_fourthView).offset(31);
        make.right.equalTo(_fourthView).offset(-265);
    }];
    
    _zongyingkuiCount = [UILabel new];
    _zongyingkuiCount.text = @"---";
    _zongyingkuiCount.font = [UIFont systemFontOfSize:13];
    _zongyingkuiCount.textColor = RGB(222,224,227);
    _zongyingkuiCount.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_zongyingkuiCount];
    [_zongyingkuiCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fourthView).offset(21);
        make.bottom.equalTo(_fourthView).offset(-22);
        make.left.equalTo(_fourthView).offset(94);
        make.right.equalTo(_fourthView).offset(-190);
    }];
    
    _fengxiandu = [UILabel new];
    _fengxiandu.text = @"风 险 度:";
    _fengxiandu.font = [UIFont systemFontOfSize:13];
    _fengxiandu.textColor = RGB(222,224,227);
    _fengxiandu.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_fengxiandu];
    [_fengxiandu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fourthView).offset(22);
        make.bottom.equalTo(_fourthView).offset(-22);
        make.left.equalTo(_fourthView).offset(194);
        make.right.equalTo(_fourthView).offset(-98);
    }];
    
    _fengxianduCount = [UILabel new];
    _fengxianduCount.text = @"0.00%";
    _fengxianduCount.font = [UIFont systemFontOfSize:13];
    _fengxianduCount.textColor = RGB(222,224,227);
    _fengxianduCount.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_fengxianduCount];
    [_fengxianduCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fourthView).offset(22);
        make.bottom.equalTo(_fourthView).offset(-22);
        make.left.equalTo(_fourthView).offset(261);
        make.right.equalTo(_fourthView).offset(-20);
    }];
    
    
    //第五条
    _fifthView = [UIView new];
    _fifthView.bounds = CGRectMake(4, 0, kSelfWidth-8, kSelfWidth*0.1493);
    _fifthView.center = CGPointMake(self.center.x, self.center.y/2.84);
    _fifthView.backgroundColor = RGB(30,36,46);
    _fifthView.layer.cornerRadius = 5;
    _fifthView.clipsToBounds = YES;
    [self addSubview:_fifthView];
    
//    [_fifthView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).offset(266);
//        make.bottom.equalTo(self).offset(-3);
//        make.left.equalTo(self).offset(8);
//        make.right.equalTo(self).offset(0);
//    }];
    
    _baozhengjin = [UILabel new];
    _baozhengjin.text = @"占 用 保 证 金:";
    _baozhengjin.font = [UIFont systemFontOfSize:13];
    _baozhengjin.textColor = RGB(222,224,227);
    _baozhengjin.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_baozhengjin];
    [_baozhengjin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fifthView).offset(21);
        make.bottom.equalTo(_fifthView).offset(-22);
        make.left.equalTo(_fifthView).offset(31);
        make.right.equalTo(_fifthView).offset(-215);
    }];
    
    _baozhengjinCount = [UILabel new];
    _baozhengjinCount.text = @"---";
    _baozhengjinCount.font = [UIFont systemFontOfSize:13];
    _baozhengjinCount.textColor = RGB(222,224,227);
    _baozhengjinCount.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_baozhengjinCount];
    [_baozhengjinCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fifthView).offset(21);
        make.bottom.equalTo(_fifthView).offset(-22);
        make.left.equalTo(_fifthView).offset(124);
        make.right.equalTo(_fifthView).offset(-140);
    }];
    
//    _fengkongedu = [UILabel new];
//    _fengkongedu.text = @"风控额度:";
//    _fengkongedu.font = [UIFont systemFontOfSize:13];
//    _fengkongedu.textColor = RGB(222,224,227);
//    _fengkongedu.textAlignment = NSTextAlignmentLeft;
//    [self addSubview:_fengkongedu];
//    [_fengkongedu mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_fifthView).offset(22);
//        make.bottom.equalTo(_fifthView).offset(-22);
//        make.left.equalTo(_fifthView).offset(194);
//        make.right.equalTo(_fifthView).offset(-98);
//    }];
//    
//    _fengkongeduCount = [UILabel new];
//    _fengkongeduCount.text = @"4500000.00";
//    _fengkongeduCount.font = [UIFont systemFontOfSize:13];
//    _fengkongeduCount.textColor = RGB(222,224,227);
//    _fengkongeduCount.textAlignment = NSTextAlignmentLeft;
//    [self addSubview:_fengkongeduCount];
//    [_fengkongeduCount mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_fifthView).offset(22);
//        make.bottom.equalTo(_fifthView).offset(-22);
//        make.left.equalTo(_fifthView).offset(261);
//        make.right.equalTo(_fifthView).offset(-20);
//    }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
