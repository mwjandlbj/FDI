//
//  NotificationView.h
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/7/14.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define VIEWTAG     1234

@class NotificationModel;

@interface NotificationView : UIView

- (id)initWithPeople:(NotificationModel *)people;


@end
