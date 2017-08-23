//
//  InquireView.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/6/16.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "InquireView.h"

#import <Masonry/Masonry.h>

#define kSelfWidth  self.frame.size.width
#define kSelfHeight self.frame.size.height



@implementation InquireView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGB(30,36,46);
//        [self initView];
        
    }
    return self;
}

- (void)initView {
    
    UIView  *topView = [UIView new];
//    topView.backgroundColor = [UIColor redColor];
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.top.equalTo(self).offset(0);
        //        make.right.equalTo(view).offset(0);
//        make.bottom.equalTo(view).offset(0);
        //        make.width.mas_equalTo(kScreenWidth/3);
        make.right.equalTo(self).offset(0);
        make.height.mas_equalTo(self.frame.size.height/5);
    }];
    
    
    NSArray  *btnTitleArr = @[@"交易明细",@"委托记录",@"止损止盈",@"成交纪录",];
    
    for (int i = 0; i < 4; i++) {
        UIButton  *btn = [UIButton new];
        btn.frame = CGRectMake((kSelfWidth-2)/4*i, 0, (kSelfWidth-2)/4, 32);
//        btn.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.f green:arc4random()%255/255.f blue:arc4random()%255/255.f alpha:1];
        btn.backgroundColor = [UIColor clearColor];
        btn.selected = NO;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [RGB(42,55,68) CGColor];
        [btn setTitle:[NSString stringWithFormat:@"%@",btnTitleArr[i]] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:11];
        [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i+10086;
        [topView addSubview:btn];
        
        if (i == 0) {
            btn.backgroundColor = RGB(24,26,30);
        }
        
        
    }
    
}
- (void)btnclick:(UIButton *)sender {
//    NSLog(@"234567890-876556789");
    
    if (sender.selected) {
        sender.backgroundColor = [UIColor yellowColor];
        
        
    }else {
        if (sender.tag == 10086) {
            NSLog(@"1111111111111111");
                        sender.backgroundColor = [UIColor redColor];
        }else if (sender.tag == 10087){
            NSLog(@"2222222222222222");
                        sender.backgroundColor = [UIColor redColor];
        }else if (sender.tag == 10088){
            NSLog(@"3333333333333333");
                        sender.backgroundColor = [UIColor redColor];
        }else {
            NSLog(@"4444444444444444");
                        sender.backgroundColor = [UIColor redColor];
        }
    }
    
    
    
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
