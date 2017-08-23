
//
//  MenuView.h
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/23.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//
#import <UIKit/UIKit.h>


@interface MenuView : UIView

 
+(instancetype)MenuViewWithDependencyView:(UIView *)dependencyView MenuView:(UIView *)leftmenuView isShowCoverView:(BOOL)isCover;

-(instancetype)initWithDependencyView:(UIView *)dependencyView MenuView:(UIView *)leftmenuView isShowCoverView:(BOOL)isCover;
    

-(void)show;

-(void)hidenWithoutAnimation;
-(void)hidenWithAnimation;

@end
