//
//  First_title.h
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/22.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol First_title_Delegate <NSObject>

-(void)Btn_First_title:(NSInteger)tag;

@end



@interface First_title : UIView

@property (nonatomic,assign)id<First_title_Delegate>delegate;



@end



