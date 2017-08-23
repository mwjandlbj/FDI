//
//  DetailMiddleView.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/6/27.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "DetailMiddleView.h"
#import "Common.h"

@implementation DetailMiddleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGB(24,26,30);
//        self.backgroundColor = [UIColor redColor];
        [self initView];
        
    }
    return self;
}

- (void)initView {
    
    UIView  *bgView = [UIView new];
    bgView.backgroundColor = RGB(30,36,46);
    bgView.layer.cornerRadius = 5;
    bgView.clipsToBounds = YES;
    bgView.layer.borderWidth = 1;
    bgView.layer.borderColor = (__bridge CGColorRef _Nullable)(RGB(42,55,68));
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(4);
        make.top.equalTo(self.mas_top).offset(0);
        make.right.equalTo(self).offset(-4);
        make.bottom.equalTo(self).offset(-4);
        
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
