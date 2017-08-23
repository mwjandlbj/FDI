//
//  JM_Login_VC.h
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/22.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GCDAsyncSocket.h"

@interface JM_Login_VC : UIViewController

@property(nonatomic,strong) GCDAsyncSocket *socket;

@end
