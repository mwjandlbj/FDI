//
//  AlertView.h
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/7/5.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertView : UIView

//警示框
+ (void)alertViewWithText:(NSString *)content withVC:(UIViewController *)vc;

@end
