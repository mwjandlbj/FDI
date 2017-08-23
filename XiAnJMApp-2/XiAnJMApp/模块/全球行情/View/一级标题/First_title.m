//
//  First_title.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/22.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "First_title.h"
#import "Common.h"

#define BTN_WIDTH  ScreenWidth/3.0
@interface First_title ()

@property (nonatomic,strong)UIButton * btn_1;
@property (nonatomic,strong)UIButton * btn_2;
@property (nonatomic,strong)UIButton * btn_3;
@property (nonatomic,strong)UIView   * view_line1;
@property (nonatomic,strong)UIView   * view_line2;
@property (nonatomic,strong)UIView   * view_line3;



@end


@implementation First_title


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
        [self relayOutUI];
        
    }
    return self;
}

-(void)createUI{

    
    _btn_1=[[UIButton alloc]init];
    [self addSubview:_btn_1];
    _btn_1.tag=101;

    _btn_2=[[UIButton alloc]init];
    [self addSubview:_btn_2];
    _btn_2.tag=102;

    
    _btn_3=[[UIButton alloc]init];
    [self addSubview:_btn_3];
    _btn_3.tag=103;


    
    _btn_1.backgroundColor=[UIColor clearColor];
    [_btn_1 setTitle:@"自选" forState:UIControlStateNormal];//button title
    _btn_1.titleLabel.font = [UIFont systemFontOfSize:13];
    [_btn_1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];//title color
    [_btn_1 addTarget:self action:@selector(Btn_Selected:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _btn_2.backgroundColor=[UIColor clearColor];
    [_btn_2 setTitle:@"美能源NYMEX" forState:UIControlStateNormal];//button title
    _btn_2.titleLabel.font = [UIFont systemFontOfSize:13];
    [_btn_2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];//title color
    [_btn_2 addTarget:self action:@selector(Btn_Selected:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _btn_3.backgroundColor=[UIColor clearColor];
    [_btn_3 setTitle:@"恒升指数HKEX" forState:UIControlStateNormal];//button title
    _btn_3.titleLabel.font = [UIFont systemFontOfSize:13];
    [_btn_3 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];//title color
    [_btn_3 addTarget:self action:@selector(Btn_Selected:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _view_line1=[[UIView alloc]init];
    [self addSubview:_view_line1];
    _view_line1.backgroundColor=[UIColor redColor];
    
    _view_line2=[[UIView alloc]init];
    [self addSubview:_view_line2];
    _view_line2.backgroundColor=[UIColor redColor];
    _view_line2.hidden=YES;
    
    
    
    _view_line3=[[UIView alloc]init];
    [self addSubview:_view_line3];
    _view_line3.backgroundColor=[UIColor redColor];
    _view_line3.hidden=YES;

    
    
}


-(void)relayOutUI{
    
    [_btn_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.width.mas_equalTo(BTN_WIDTH);
    }];
    
 
    [_btn_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.left.equalTo(_btn_1.mas_right).offset(0);
        make.width.mas_equalTo(BTN_WIDTH);
    }];
    
    [_btn_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.left.equalTo(_btn_2.mas_right).offset(0);
        make.width.mas_equalTo(BTN_WIDTH);
    }];
    
    
    [_view_line1 mas_makeConstraints:^(MASConstraintMaker *make) {

        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.width.mas_equalTo(BTN_WIDTH);
        make.height.mas_equalTo(1.0);
    }];
    
    
    [_view_line2 mas_makeConstraints:^(MASConstraintMaker *make) {

        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.left.equalTo(_btn_1.mas_right).offset(0);
        make.width.mas_equalTo(BTN_WIDTH);
        make.height.mas_equalTo(1.0);

    }];
    
    [_view_line3 mas_makeConstraints:^(MASConstraintMaker *make) {

        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.left.equalTo(_btn_2.mas_right).offset(0);
        make.width.mas_equalTo(BTN_WIDTH);
        make.height.mas_equalTo(1.0);

    }];
    
    
    
}


-(void)Btn_Selected:(UIButton*)btn{

    if (btn.tag==101) {
        [_btn_1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];//title color
        [_btn_2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];//title color
        [_btn_3 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];//title color
        
        _view_line1.hidden=NO;
        _view_line2.hidden=YES;
        _view_line3.hidden=YES;
        
        


    }else if(btn.tag==102){
        [_btn_1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];//title color
        [_btn_2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];//title color
        [_btn_3 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];//title color
        
        _view_line1.hidden=YES;
        _view_line2.hidden=NO;
        _view_line3.hidden=YES;
        
    }else if(btn.tag==103){
        [_btn_1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];//title color
        [_btn_2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];//title color
        [_btn_3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];//title color
        
        _view_line1.hidden=YES;
        _view_line2.hidden=YES;
        _view_line3.hidden=NO;
        
    }
    
    if ([self.delegate respondsToSelector:@selector(Btn_First_title:)]) {
        [self.delegate Btn_First_title:btn.tag];
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
