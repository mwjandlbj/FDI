

#import "HUD.h"
#import "BKAnimatedAlert.h"
#import "MBProgressHUD.h"
@implementation HUD

+(void)dismiss {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        [self dismissInView:window];
    });
}

+(void)showMessage:(NSString*)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        if(!window) {
            return;
        }
        
        [self MBMessageHUDWithview:window message:message];
    });
}

+(void)showProgress:(NSString*)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        if(!window) {
            return;
        }
        
        [self MBProgressHUDWithView:window message:message];
    });
}

+(void)showErrorMessage:(NSString*)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        if(!window) {
            return;
        }
        
        [self MBMessageHUDWithview:window message:message];
    });
}

+(void)showSuccessMessage:(NSString*)message {
    [HUD dismiss];
    BKAnimatedAlert *alert = [[BKAnimatedAlert alloc] init];
    [alert BkAlert_Style:BKAlertStyle_Success accordingDetailContentAutoLayout:message];
}





+(void)showMessage:(NSString *)message inView:(UIView *)view {
    if([NSThread isMainThread]) {
        [self MBMessageHUDWithview:view message:message];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self MBMessageHUDWithview:view message:message];
        });
    }
}

+(void)showProgress:(NSString *)message inView:(UIView *)view {
    if([NSThread isMainThread]) {
        [self MBProgressHUDWithView:view message:message];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self MBProgressHUDWithView:view message:message];
        });
    }
}

+(void)dismissInView:(UIView *)view {
    if(!view) {
        return;
    }
    
    if([NSThread isMainThread]) {
        [self removeHUDInView:view];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self removeHUDInView:view];
        });
    }
    
    
}

+(void)removeHUDInView:(UIView*)view {
    NSArray *array = view.subviews;
    
    for (UIView *view in array) {
        if([view isKindOfClass:[MBProgressHUD class]]) {
            MBProgressHUD *hud = (MBProgressHUD*)view;
            [hud hideAnimated:YES];
        }
    }
}

+(MBProgressHUD*)MBMessageHUDWithview:(UIView*)view message:(NSString*)message {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    hud.detailsLabel.text = message;
    hud.mode = MBProgressHUDModeText;
    if(SystemVersion >= 8.0) {
        hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    } else {
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    }
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.contentColor = [UIColor whiteColor];
    
    [hud hideAnimated:YES afterDelay:2.5];
    
    
    return hud;
}

+(MBProgressHUD*)MBProgressHUDWithView:(UIView*)view message:(NSString*)message {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor clearColor];
    hud.contentColor = ThemeColor;
    hud.detailsLabel.textColor = [UIColor blackColor];
    
    if(message && ![message isEqualToString:@""]) {
        hud.detailsLabel.text = message;
    }
    
    return hud;
}

@end
