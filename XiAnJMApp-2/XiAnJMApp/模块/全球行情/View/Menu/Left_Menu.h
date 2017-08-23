//
//  Left_Menu.h
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/23.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeMenuViewDelegate <NSObject>

-(void)LeftMenuViewClick:(NSInteger)tag;

@end

@interface Left_Menu : UIView

@property (nonatomic ,weak)id <HomeMenuViewDelegate> customDelegate;

@property (nonatomic,strong)UILabel *accountLabel;//账号
@property (nonatomic,strong)UILabel *NameLabel;//名字


@end

