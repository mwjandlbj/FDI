


#import "BKIndicationView.h"
#import "Common.h"



@implementation BKIndicationView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.color = RGB(27, 188, 155 );
        self.transform = CGAffineTransformMakeScale(1.5f, 1.5f);
        
    }
    return self;
}

+ (instancetype)sharedView
{
    static BKIndicationView *indicationView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        indicationView = [[self alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        indicationView.center = CGPointMake(ScreenWidth/2, ScreenHeight/2-32);
    });
    return indicationView;
}


+(void)showInView:(UIView *)view{
    
    [[BKIndicationView sharedView] startAnimating];
    [view addSubview:[BKIndicationView sharedView]];
}

+(instancetype)sharedViewWithCenter:(CGPoint)point{
    static BKIndicationView *indicationView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        indicationView = [[self alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        indicationView.center = point;
    });
    return indicationView;
}
+(void)showInView:(UIView *)view Point:(CGPoint)point{
    
    [[BKIndicationView sharedViewWithCenter:point] startAnimating];
    [view addSubview:[BKIndicationView sharedViewWithCenter:point]];
}
+(void)dismissWithCenter:(CGPoint)point{
    [[BKIndicationView sharedViewWithCenter:point] stopAnimating];
    [[BKIndicationView sharedViewWithCenter:point] removeFromSuperview];
}
+(void)dismiss{
    
    [[BKIndicationView sharedView] stopAnimating];
    
//    dispatch_async(dispatch_get_main_queue()
//                   , ^{
                       
                      [[BKIndicationView sharedView] removeFromSuperview];
//                   });
    
    
}

@end
