//
//  AlertView.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/7/5.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "AlertView.h"

@implementation AlertView

//警示框
+ (void)alertViewWithText:(NSString *)content withVC:(UIViewController *)vc {
    
    UIAlertController  *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:content preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction   *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:sure];
    
    [vc presentViewController:alert animated:YES completion:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
