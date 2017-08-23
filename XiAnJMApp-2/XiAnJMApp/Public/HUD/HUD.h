

#import <Foundation/Foundation.h>
#import "Common.h"
@interface HUD : NSObject

+(void)dismiss;
//+(void)showProgress:(CGFloat)progress message:(NSString*)message;
+(void)showMessage:(NSString*)message;
+(void)showProgress:(NSString*)message;
+(void)showErrorMessage:(NSString*)message;
+(void)showSuccessMessage:(NSString*)message;
//+(void)initConfig;

#pragma -mark 2017-02-07
+(void)showMessage:(NSString *)message inView:(UIView*)view;
+(void)showProgress:(NSString *)message inView:(UIView*)view;
+(void)dismissInView:(UIView*)view;


@end
