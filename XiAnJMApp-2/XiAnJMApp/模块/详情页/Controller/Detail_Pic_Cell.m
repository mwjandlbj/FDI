//
//  Detail_Pic_Cell.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/23.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "Detail_Pic_Cell.h"
#import "Common.h"

@implementation Detail_Pic_Cell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView{
    
    
    
    
//    self.backgroundColor=RGB(30,36,46);
    self.backgroundColor=[UIColor  blackColor];
    
//    NSLog(@"%f",self.center.x);
//    NSLog(@"%f",self.center.y);
    
//    self.maskView.layer.cornerRadius = 5;
//    self.maskView.clipsToBounds = YES;
    
    UIView  *bgView = [UIView new];
    bgView.backgroundColor = RGB(30,36,46);
    bgView.layer.cornerRadius = 5;
    bgView.clipsToBounds = YES;
    [self addSubview:bgView];
    
    // 状态栏(statusbar)
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
//    NSLog(@"status width - %f", rectStatus.size.width); // 宽度
//    NSLog(@"status height - %f", rectStatus.size.height);   // 高度
    
    if (rectStatus.size.width >375) {
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mas_left).offset(4);
            make.top.equalTo(self.mas_top).offset(0);
            make.right.equalTo(self).offset(-4);
            make.bottom.equalTo(self).offset(-4);
            
        }];
    }else {
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mas_left).offset(4);
            make.top.equalTo(self.mas_top).offset(0);
            make.right.equalTo(self).offset(-4);
            make.bottom.equalTo(self).offset(-8);
            
        }];
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(CGFloat)computeHeight:(id)info{
    return kScreenHeight*0.697;
}
-(void)relayOutUIWithModel:(id)model{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
