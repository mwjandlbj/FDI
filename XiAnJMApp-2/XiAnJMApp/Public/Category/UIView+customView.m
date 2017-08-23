//
//  UIView+customView.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/22.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "UIView+customView.h"
#import "Stock.h"


#define LabelWidth 85
#define LabelHeight 35

@implementation UIView (customView)

+ (UIView *)viewWithLabelNumber:(NSInteger)num{
    UIView *view = [[self alloc] initWithFrame:CGRectMake(0, 0, LabelWidth * num, LabelHeight)];
    
    
//    Stock  *stock = [Stock new];
    
    for (int i = 0; i < num; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(LabelWidth * i, 0, LabelWidth, LabelHeight)];
        
        label.numberOfLines = 0;
        label.tag = i;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = RGB(222,224,227);
        label.font = [UIFont systemFontOfSize:11];
//        label.backgroundColor = [UIColor clearColor];
        label.text = [NSString stringWithFormat:@"%d",i];//假数据
        
        
        
        
        [view addSubview:label];
        
        /*
        NSLog(@"%ld",label.tag);
        
        if (label.tag == 2) {
            label.textColor = [UIColor redColor];
        }
        
        if (label.tag == 1) {
            label.text = stock.ContractName;
        }
         */
    }
    return view;
}

@end
