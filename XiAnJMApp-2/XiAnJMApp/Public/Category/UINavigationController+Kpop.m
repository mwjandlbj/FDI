//
//  UINavigationController+Kpop.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/19.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//


#import "UINavigationController+Kpop.h"
#import <objc/runtime.h>
#import "Common.h"



@interface K_Pop_GesDelegate : NSObject <UIGestureRecognizerDelegate>
@property (nonatomic, weak) UINavigationController *nav_VC;
@end
@implementation K_Pop_GesDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer{
    UIViewController *topVC = self.nav_VC.viewControllers.lastObject;
    IF(self.nav_VC.viewControllers.count <= 1,return NO)
    IF(topVC.k_Pop_Disabled,return NO)
    CGPoint point_begin = [gestureRecognizer locationInView:gestureRecognizer.view];
    CGFloat MAX_Distance = topVC.k_MaxL_Distance;
    IF(MAX_Distance > 0 && point_begin.x > MAX_Distance,return NO)
    
    /*
     * 设置侧滑边缘距离
     */
    if (point_begin.x>ScreenWidth/4.0) {
        return NO;
    }
//    if ([[UIView BKcurrentViewController] isKindOfClass:[BK_SP_Success_VC class]]) {
//        //    if ([[UIView BKcurrentViewController] isKindOfClass:[BK_SP_Fail_VC class]]||[[UIView BKcurrentViewController] isKindOfClass:[BK_SP_Success_VC class]]) {
//        
//        //获得视图控制器堆栈数组
//        NSArray *currentControllers = self.nav_VC.viewControllers;
//        
//        //基于堆栈数组实例化新的数组
//        NSMutableArray *newControllers = [NSMutableArray arrayWithArray:currentControllers];
//        
//        
//        int count = 0;
//        
//        
//        
//        for (int i=0;i<newControllers.count;i++) {
//            if ([newControllers[i] isKindOfClass:[BK_SP_Success_VC class]]) {
//                NSLog(@"--%d-->>>>>%@",i,newControllers[i] );
//                count=i;
//            }
//            //            if ([newControllers[i] isKindOfClass:[BK_SP_Fail_VC class]]||[newControllers[i] isKindOfClass:[BK_SP_Success_VC class]]) {
//            //                NSLog(@"--%d-->>>>>%@",i,newControllers[i] );
//            //                count=i;
//            //            }
//        }
//        
//        for (int i=count-1; i>0;i--) {
//            if (count-1>0) {
//                [newControllers removeObjectAtIndex:i];
//            }
//        }
//        
//        //为堆栈重新赋值
//        [self.nav_VC setViewControllers:newControllers animated:YES];
//    }
    
    IF([[self.nav_VC valueForKey:@"_isTransitioning"] boolValue],return NO)
    CGPoint point_trans = [gestureRecognizer translationInView:gestureRecognizer.view];
    IF((point_trans.x <= 0), return  NO)
    
    
    
    
    
    return YES;
}
@end

typedef void (^K_WillAppear_Block)(UIViewController *viewController, BOOL animated);
@interface UIViewController (KPopGes)
@property (nonatomic, copy) K_WillAppear_Block k_WillAppear_block;
@end
@implementation UIViewController (KPopGes)
+ (void)load{
    DISPATCH(viewWillAppear:,new_viewWillAppear:)
}
- (void)new_viewWillAppear:(BOOL)animated{
    [self new_viewWillAppear:animated];
    IF(self.k_WillAppear_block, self.k_WillAppear_block(self, animated))
}
- (K_WillAppear_Block)k_WillAppear_block{
    return objc_getAssociatedObject(self, _cmd);
}
-(void)setK_WillAppear_block:(K_WillAppear_Block)block{
    objc_setAssociatedObject(self, @selector(k_WillAppear_block), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end

@implementation UINavigationController (Kpop)
+ (void)load{
    DISPATCH(pushViewController:animated:,new_pushViewController:animated:)
}
- (void)new_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (![self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:self.k_Pop_GesRecognizer]) {
        [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.k_Pop_GesRecognizer];
        NSArray *arr_Targets = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
        id firest_target = [arr_Targets.firstObject valueForKey:@"target"];
        SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");
        self.k_Pop_GesRecognizer.delegate = self.k_Pop_Gesdelegate;
        [self.k_Pop_GesRecognizer addTarget:firest_target action:internalAction];
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    [self k_setupVC_BasNavBar_IfNeed:viewController];
    IF(![self.viewControllers containsObject:viewController], [self new_pushViewController:viewController animated:animated])
}

- (void)k_setupVC_BasNavBar_IfNeed:(UIViewController *)showVC{
    IF(!self.k_NavBar_Show, return)
    __weak typeof(self) weakSelf = self;
    K_WillAppear_Block block = ^(UIViewController *viewController, BOOL animated) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        IF(strongSelf, [strongSelf setNavigationBarHidden:viewController.k_NavBar_Hidden animated:animated])
    };
    showVC.k_WillAppear_block = block;
    UIViewController *disappearingVC = self.viewControllers.lastObject;
    IF(disappearingVC && !disappearingVC.k_WillAppear_block, disappearingVC.k_WillAppear_block = block)
}
- (K_Pop_GesDelegate *)k_Pop_Gesdelegate{
    K_Pop_GesDelegate *delegate = objc_getAssociatedObject(self, _cmd);
    if (!delegate) {
        delegate = [[K_Pop_GesDelegate alloc] init];
        delegate.nav_VC = self;
        objc_setAssociatedObject(self, _cmd, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return delegate;
}
- (UIPanGestureRecognizer *)k_Pop_GesRecognizer{
    UIPanGestureRecognizer *panGesRec = objc_getAssociatedObject(self, _cmd);
    if (!panGesRec) {
        panGesRec = [[UIPanGestureRecognizer alloc] init];
        panGesRec.maximumNumberOfTouches = 1;
        objc_setAssociatedObject(self, _cmd, panGesRec, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return panGesRec;
}
- (BOOL)k_NavBar_Show{
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    IF(number, return number.boolValue)
    self.k_NavBar_Show = YES;
    return YES;
}
- (void)setK_NavBar_Show:(BOOL)enabled{
    SEL key = @selector(k_NavBar_Show);
    objc_setAssociatedObject(self, key, @(enabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end

@implementation UIViewController (Kpop)
- (BOOL)k_Pop_Disabled{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
-(void)setK_Pop_Disabled:(BOOL)disabled{
    objc_setAssociatedObject(self, @selector(k_Pop_Disabled), @(disabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)k_NavBar_Hidden{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
-(void)setK_NavBar_Hidden:(BOOL)hidden{
    objc_setAssociatedObject(self, @selector(k_NavBar_Hidden), @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)k_MaxL_Distance{
#if CGFLOAT_IS_DOUBLE
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
#else
    return [objc_getAssociatedObject(self, _cmd) floatValue];
#endif
}
-(void)setK_MaxL_Distance:(CGFloat)distance{
    SEL key = @selector(k_MaxL_Distance);
    objc_setAssociatedObject(self, key, @(MAX(0, distance)), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end












