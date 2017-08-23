//
//  Nav_Deatil.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/24.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "Nav_Deatil.h"
#import "Common.h"
@interface Nav_Deatil ()
@property (nonatomic,strong)UIButton * btn_left;
@end

@implementation Nav_Deatil
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
        
    }
    return self;
}

-(void)createUI{
    
    self.backgroundColor=RGB(44,52,60);
    _btn_left = [[UIButton alloc]init];
    [_btn_left setImage:[UIImage imageNamed:@"icon1"] forState:UIControlStateNormal];
    
    [self addSubview:_btn_left];
    [_btn_left addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    [_btn_left mas_makeConstraints:^(MASConstraintMaker *make) {
        

        make.centerY.equalTo(self.mas_centerY).offset(10);
        make.left.equalTo(self.mas_left).offset(20);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(35);
        
    }];
    
    

}

-(void)action{
    if ([self.delegate respondsToSelector:@selector(Btn_Nav_Deatil)]) {
        [self.delegate Btn_Nav_Deatil];
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
