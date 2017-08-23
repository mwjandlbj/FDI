//
//  LoadingView.h
//  bestkeep
//
//  Created by yons on 16/12/16.
//  Copyright © 2016年 utouu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

+ (void)loadingInView:(UIView *)view;
+ (void)loadingShoppingCartInView:(UIView *)view;
+ (void)dismiss;

@end
