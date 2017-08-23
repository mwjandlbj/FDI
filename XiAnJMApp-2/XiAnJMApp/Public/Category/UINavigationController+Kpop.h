//
//  UINavigationController+Kpop.h
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/19.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#define IF(A,B) if(A) {B;}
#define MAKE_SELECTOR(SELECTOR_ONE,SELECTOR_TWO)\
Class class = [self class];\
SEL originalSelector = @selector(SELECTOR_ONE);\
SEL swizzledSelector = @selector(SELECTOR_TWO);\
Method originalMethod = class_getInstanceMethod(class, originalSelector);\
Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);\
BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));\
if (success) {\
class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));\
} else {\
method_exchangeImplementations(originalMethod, swizzledMethod);\
}
#define DISPATCH(A,B)\
static dispatch_once_t onceToken;dispatch_once(&onceToken, ^{MAKE_SELECTOR(A,B);\
});
#import <UIKit/UIKit.h>
@interface UINavigationController (Kpop)
@property (nonatomic, strong, readonly) UIPanGestureRecognizer *k_Pop_GesRecognizer;
@property (nonatomic, assign) BOOL k_NavBar_Show;
@end
@interface UIViewController (Kpop)
@property (nonatomic, assign) BOOL k_Pop_Disabled;
@property (nonatomic, assign) BOOL k_NavBar_Hidden;
@property (nonatomic, assign) CGFloat k_MaxL_Distance;
@end
