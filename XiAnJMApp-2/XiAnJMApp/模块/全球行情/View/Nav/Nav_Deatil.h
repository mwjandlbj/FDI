//
//  Nav_Deatil.h
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/24.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol Nav_Deatil_Delegate <NSObject>

-(void)Btn_Nav_Deatil;

@end
@interface Nav_Deatil : UIView


@property (nonatomic,assign)id<Nav_Deatil_Delegate>delegate;



@end
