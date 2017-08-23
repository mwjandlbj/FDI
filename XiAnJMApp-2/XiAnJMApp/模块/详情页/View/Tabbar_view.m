//
//  Tabbar_view.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/23.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "Tabbar_view.h"
#import "Common.h"

#define WIDTH_Lab  ScreenWidth/5.0
#define HEIGHT_Lab  15
#define WIDTH_ImgV  35
#define HEIGHT_Tabbar 50

@interface Tabbar_view (){
    
    NSInteger   count;
    UIView      *foundBGView;//资金背景view
    
}
/*
 * 资金
 */
@property(nonatomic,strong)UIImageView * imgV_Fund;
@property(nonatomic,strong)UILabel     * lab_Fund;

/*
 * 成交
 */
@property(nonatomic,strong)UIImageView * imgV_Bargain;
@property(nonatomic,strong)UILabel     * lab_Bargain;

/*
 * 交易
 */
@property(nonatomic,strong)UIImageView * imgV_Transaction;
@property(nonatomic,strong)UILabel     * lab_Transaction;

/*
 * 查询
 */
@property(nonatomic,strong)UIImageView * imgV_Inquire;
@property(nonatomic,strong)UILabel     * lab_Inquire;

/*
 * 设置
 */
@property(nonatomic,strong)UIImageView * imgV_Set;
@property(nonatomic,strong)UILabel     * lab_Set;


@end

@implementation Tabbar_view
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
        
    }
    return self;
}

-(void)createUI{
    
    
    CGFloat centerY_ImgV=(HEIGHT_Tabbar-HEIGHT_Lab)/2.0;
    
    
    /*
     * 资金
     */
    _lab_Fund=[[UILabel alloc]init];
    _lab_Fund.text=@"资金";
    _lab_Fund.textAlignment=NSTextAlignmentCenter;
    _lab_Fund.font = [UIFont systemFontOfSize:11];
    [self addSubview:_lab_Fund];
    [_lab_Fund mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.width.mas_equalTo(WIDTH_Lab);
        make.height.mas_equalTo(HEIGHT_Lab);
        
    }];
    
    
    _imgV_Fund=[[UIImageView alloc]init];
    _imgV_Fund.backgroundColor=[UIColor  redColor];
    _imgV_Fund.image=[UIImage imageNamed:@"icon1"];
    
    UITapGestureRecognizer *imgFundTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgFundClick)];
    // 2. 将点击事件添加到label上
    [_imgV_Fund addGestureRecognizer:imgFundTapGestureRecognizer];
    _imgV_Fund.userInteractionEnabled = YES; // 可以理解为设置label可被点击
    
    
    [self addSubview:_imgV_Fund];
    [_imgV_Fund mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mas_left).offset(WIDTH_Lab/2.0);
        make.centerY.equalTo(self.mas_top).offset(centerY_ImgV);
        make.width.mas_equalTo(WIDTH_ImgV);
        make.height.mas_equalTo(WIDTH_ImgV);
        
    }];
    
    

    /*
     * 成交
     */
    _lab_Bargain=[[UILabel alloc]init];
    _lab_Bargain.text=@"成交";
    _lab_Bargain.textAlignment=NSTextAlignmentCenter;
    _lab_Bargain.font = [UIFont systemFontOfSize:11];
    [self addSubview:_lab_Bargain];
    [_lab_Bargain mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.left.equalTo(_lab_Fund.mas_right).offset(0);
        make.width.mas_equalTo(WIDTH_Lab);
        make.height.mas_equalTo(HEIGHT_Lab);
        
    }];
    
    _imgV_Bargain=[[UIImageView alloc]init];
    _imgV_Bargain.image=[UIImage imageNamed:@"icon1"];
    
    UITapGestureRecognizer *imgBargainTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgBargainClick)];
    // 2. 将点击事件添加到label上
    [_imgV_Bargain addGestureRecognizer:imgBargainTapGestureRecognizer];
    _imgV_Bargain.userInteractionEnabled = YES; // 可以理解为设置label可被点击
    
    
    [self addSubview:_imgV_Bargain];
    [_imgV_Bargain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_left).offset(WIDTH_Lab/2.0+WIDTH_Lab);
        make.centerY.equalTo(self.mas_top).offset(centerY_ImgV);
        make.width.mas_equalTo(WIDTH_ImgV);
        make.height.mas_equalTo(WIDTH_ImgV);
        
    }];
    
    
    
    /*
     * 交易
     */
    _lab_Transaction=[[UILabel alloc]init];
    _lab_Transaction.text=@"交易";
    _lab_Transaction.textAlignment=NSTextAlignmentCenter;
    _lab_Transaction.font = [UIFont systemFontOfSize:11];
    [self addSubview:_lab_Transaction];
    [_lab_Transaction mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.left.equalTo(_lab_Bargain.mas_right).offset(0);
        make.width.mas_equalTo(WIDTH_Lab);
        make.height.mas_equalTo(HEIGHT_Lab);
        
    }];
    
    _imgV_Transaction=[[UIImageView alloc]init];
    _imgV_Transaction.image=[UIImage imageNamed:@"icon1"];
    
    UITapGestureRecognizer *imgTransactionTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTransactionClick)];
    // 2. 将点击事件添加到label上
    [_imgV_Transaction addGestureRecognizer:imgTransactionTapGestureRecognizer];
    _imgV_Transaction.userInteractionEnabled = YES; // 可以理解为设置label可被点击
    
    
    [self addSubview:_imgV_Transaction];
    [_imgV_Transaction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_left).offset(WIDTH_Lab/2.0+WIDTH_Lab*2);
        make.centerY.equalTo(self.mas_top).offset(centerY_ImgV);
        make.width.mas_equalTo(WIDTH_ImgV);
        make.height.mas_equalTo(WIDTH_ImgV);
        
    }];
    
    
    /*
     * 查询
     */
    _lab_Inquire=[[UILabel alloc]init];
    _lab_Inquire.text=@"查询";
    _lab_Inquire.textAlignment=NSTextAlignmentCenter;
    _lab_Inquire.font = [UIFont systemFontOfSize:11];
    [self addSubview:_lab_Inquire];
    [_lab_Inquire mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.left.equalTo(_lab_Transaction.mas_right).offset(0);
        make.width.mas_equalTo(WIDTH_Lab);
        make.height.mas_equalTo(HEIGHT_Lab);
        
    }];
    
    _imgV_Inquire=[[UIImageView alloc]init];
    _imgV_Inquire.image=[UIImage imageNamed:@"icon1"];
    
    UITapGestureRecognizer *imgInquireTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgInquireClick)];
    // 2. 将点击事件添加到label上
    [_imgV_Inquire addGestureRecognizer:imgInquireTapGestureRecognizer];
    _imgV_Inquire.userInteractionEnabled = YES; // 可以理解为设置label可被点击
    
    
    [self addSubview:_imgV_Inquire];
    [_imgV_Inquire mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_left).offset(WIDTH_Lab/2.0+WIDTH_Lab*3);
        make.centerY.equalTo(self.mas_top).offset(centerY_ImgV);
        make.width.mas_equalTo(WIDTH_ImgV);
        make.height.mas_equalTo(WIDTH_ImgV);
        
    }];
    
    
    /*
     * 设置
     */
    _lab_Set=[[UILabel alloc]init];
    _lab_Set.text=@"设置";
    _lab_Set.textAlignment=NSTextAlignmentCenter;
    _lab_Set.font = [UIFont systemFontOfSize:11];
    [self addSubview:_lab_Set];
    [_lab_Set mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.left.equalTo(_lab_Inquire.mas_right).offset(0);
        make.width.mas_equalTo(WIDTH_Lab);
        make.height.mas_equalTo(HEIGHT_Lab);
        
    }];
    
    _imgV_Set=[[UIImageView alloc]init];
    _imgV_Set.image=[UIImage imageNamed:@"icon1"];
    
    UITapGestureRecognizer *imgSetTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgSetClick)];
    // 2. 将点击事件添加到label上
    [_imgV_Set addGestureRecognizer:imgSetTapGestureRecognizer];
    _imgV_Set.userInteractionEnabled = YES; // 可以理解为设置label可被点击
    
    
    [self addSubview:_imgV_Set];
    [_imgV_Set mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_left).offset(WIDTH_Lab/2.0+WIDTH_Lab*4);
        make.centerY.equalTo(self.mas_top).offset(centerY_ImgV);
        make.width.mas_equalTo(WIDTH_ImgV);
        make.height.mas_equalTo(WIDTH_ImgV);
        
    }];
    
}




#pragma mark  --资金点击触发方法
- (void)imgFundClick {
    NSLog(@"资金点击触发方法");
    
    count +=1;
    
    if (count%2 == 1) {
    
    foundBGView = [UIView new];
    foundBGView.frame = CGRectMake(3, self.frame.size.height/2, self.frame.size.width-6, self.frame.size.width-45);
        
    foundBGView.backgroundColor = [UIColor redColor];
    [self addSubview:foundBGView];
    
    }else {
        [foundBGView removeFromSuperview];
    }
    
}

#pragma mark  --成交点击触发方法
- (void)imgBargainClick {
    NSLog(@"成交点击触发方法");
}

#pragma mark  --交易点击触发方法
- (void)imgTransactionClick {
    NSLog(@"交易点击触发方法");
}


#pragma mark  --查询点击触发方法
- (void)imgInquireClick {
    NSLog(@"查询点击触发方法");
}


#pragma mark  --设置点击触发方法
- (void)imgSetClick {
    NSLog(@"设置点击触发方法");
}

@end






































