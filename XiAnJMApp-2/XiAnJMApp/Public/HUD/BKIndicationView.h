


#import <UIKit/UIKit.h>

@interface BKIndicationView : UIActivityIndicatorView

+(void)showInView:(UIView *)view;
+(void)dismiss;
+(void)showInView:(UIView *)view Point:(CGPoint)point;
+(void)dismissWithCenter:(CGPoint)point;
@end
