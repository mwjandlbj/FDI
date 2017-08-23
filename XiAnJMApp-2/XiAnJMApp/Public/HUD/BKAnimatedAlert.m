

#import "BKAnimatedAlert.h"
//按钮颜色
#define OKBUTTON_BGCOLOR [UIColor colorWithRed:158/255.0 green:214/255.0 blue:243/255.0 alpha:1]
#define CANCELBUTTON_BGCOLOR [UIColor colorWithRed:255/255.0 green:20/255.0 blue:20/255.0 alpha:1]
//按钮起始tag
#define TAG 100
#define WIDTH_ALERT    120
#define WIDTH_AUTOLAYOUTALERT 200

NSUInteger const Button_Size_Width = 80;
NSUInteger const Button_Size_Height = 30;

NSInteger const Title_Font = 16;
NSInteger const Detial_Font = 14;

//Logo半径（画布）
NSInteger const Logo_Size = 25;

NSInteger const Button_Font = 16;

@interface BKAnimatedAlert ()
{
    UIView * _logoView;//画布
    UILabel * _titleLabel;//标题
    UILabel * _detailLabel;//详情
    UIButton * _OkButton;//确定按钮
    UIButton * _canleButton;//取消按钮
    UIView * _assistView;  //辅助画布视图；
}
@end

NSInteger const Logo_Center_x = WIDTH_ALERT / 2;
NSInteger const Logo_Center_y = WIDTH_ALERT / 2 - 10;

@implementation BKAnimatedAlert

- (void)BKAlert_Style:(BKAlertViewStyle)style detail:(NSString *)detail{
    
    switch (style) {
        case BKAlertStyle_Success:
            [self  draw_Success];
            break;
            
        case BKAlertStyle_Fail:
            [self draw_Fail];
            break;
        case BKAlertStyle_Waring:
            [self draw_Waring];
            break;
        case BKAlertStyle_NoSave:
            [self draw_NoSave];
            break;
        case BKAlertStyle_Busy:
            [self draw_Busy];
            break;
        default:
            break;
    }
    [self addTitle:nil detail:detail];
    [self BtnHidden];
    
    
}
- (void)BKAlert_Style:(BKAlertViewStyle)style title:(NSString *)title detail:(NSString *)detail {
    switch (style) {
        case BKAlertStyle_Success:
            [self  draw_Success];
            break;
            
        case BKAlertStyle_Fail:
            [self draw_Fail];
            break;
        case BKAlertStyle_Waring:
            [self draw_Waring];
            break;
        case BKAlertStyle_NoSave:
            [self draw_NoSave];
            break;
        case BKAlertStyle_Busy:
            [self draw_Busy];
            break;
        default:
            break;
    }
    
    [self addTitle:title detail:detail];
    [self BtnHidden];
}

- (void)BKAlert_Style:(BKAlertViewStyle)style title:(NSString *)title detail:(NSString *)detail canleButtonTitle:(NSString *)canle okButtonTitle:(NSString *)ok callBlock:(BKAnimatedAlert_callBack)callBack{
    
    switch (style) {
        case BKAlertStyle_Success:
            [self  draw_Success];
            break;
            
        case BKAlertStyle_Fail:
            [self draw_Fail];
            break;
        case BKAlertStyle_Waring:
            [self draw_Waring];
            break;
        case BKAlertStyle_NoSave:
            [self draw_NoSave];
            break;
        case BKAlertStyle_Busy:
            [self draw_Busy];
            break;
        default:
            break;
    }
    [self addTitle:title detail:detail];
    [self setClickBlock:nil];//释放掉之前的Block
    [self setClickBlock:callBack];
    [self  addBtn];
    [self  addButtonTitleWithCancle:canle OK:ok];
    
}

//根据提示内容 自适应提示弹窗的宽度
-(void)BkAlert_Style:(BKAlertViewStyle)style accordingDetailContentAutoLayout:(NSString *)detail
{
    
//    CGSize Labelsize = [detail boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-80, 1000) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:13]} context:nil].size;
    
    switch (style) {
        case BKAlertStyle_Success:
            [self  draw_Success];
            _assistView.bounds = CGRectMake(0, 0,WIDTH_AUTOLAYOUTALERT,WIDTH_ALERT);
            _assistView.center = CGPointMake([self lastWindow].center.x, [self lastWindow].center.y - 80);
            break;
            
        case BKAlertStyle_Fail:
            [self draw_Fail];
            _assistView.bounds = CGRectMake(0, 0, WIDTH_AUTOLAYOUTALERT,WIDTH_ALERT);
            _assistView.center = CGPointMake([self lastWindow].center.x, [self lastWindow].center.y - 80);
            break;
        case BKAlertStyle_Waring:
            [self draw_Waring];
            _assistView.bounds = CGRectMake(0, 0, WIDTH_AUTOLAYOUTALERT,WIDTH_ALERT);
            _assistView.center = CGPointMake([self lastWindow].center.x, [self lastWindow].center.y - 80);
            break;
            
        default:
            break;
    }
    
    [self addTitle:nil detail:detail];
     _detailLabel.frame=CGRectMake(_assistView.frame.origin.x,_assistView.frame.origin.y + _logoView.frame.size.height-30,_assistView.frame.size.width, Detial_Font + 5);
    [self BtnHidden];
}


- (instancetype)init{
    self = [super init];
    if (self) {
        [self Face];
    }
    return self;
}
/**
 *  界面初始化
 */
- (void)Face{
    
    [self addTitleAndDetailTitle];
}

#pragma mark-添加标题和详细信息
-(void)addTitleAndDetailTitle{
    CGFloat x = _logoView.frame.origin.x;
    CGFloat y = _logoView.frame.origin.y;
    CGFloat height = _logoView.frame.size.height;
    CGFloat width = _logoView.frame.size.width;
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x ,y + height / 2, width, Title_Font + 5)];
    [_titleLabel setFont:[UIFont systemFontOfSize:Title_Font]];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    _detailLabel  = [[UILabel alloc] initWithFrame:CGRectMake(x ,y + height / 2 + (Title_Font + 10)+30, width, Detial_Font + 5)];
    _detailLabel.numberOfLines = 0;
    _detailLabel.textColor = [UIColor whiteColor];
    [_detailLabel setFont:[UIFont systemFontOfSize:Detial_Font]];
    [_detailLabel setTextAlignment:NSTextAlignmentCenter];
    [[self lastWindow] addSubview:_titleLabel];
    [[self lastWindow] addSubview:_detailLabel];
}
#pragma mark-添加按钮
-(void)addBtn{
    CGFloat centerY = _detailLabel.center.y + 40;
    if (!_OkButton) {
        _OkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _OkButton.layer.cornerRadius = 5;
        _OkButton.titleLabel.font = [UIFont systemFontOfSize:Button_Font];
        _OkButton.backgroundColor = OKBUTTON_BGCOLOR;
        [[self lastWindow] addSubview:_OkButton];
        _canleButton.hidden = YES;
        _canleButton.tag = TAG + 1;
        [_canleButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (!_canleButton) {
        _canleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _canleButton.backgroundColor = CANCELBUTTON_BGCOLOR;
        _canleButton.layer.cornerRadius = 5;
        _canleButton.titleLabel.font = [UIFont systemFontOfSize:Button_Font];
        [[self lastWindow] addSubview:_canleButton];
        _OkButton.hidden = YES;
        _OkButton.tag = TAG;
        [_OkButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    _OkButton.center = CGPointMake(_detailLabel.center.x + 50, centerY);
    _OkButton.bounds = CGRectMake(0, 0, Button_Size_Width, Button_Size_Height);
    _canleButton.center = CGPointMake(_detailLabel.center.x - 50, centerY);
    _canleButton.bounds = CGRectMake(0, 0, Button_Size_Width, Button_Size_Height);
    
}

-(void)BtnHidden{
    _canleButton.hidden = YES;
    _OkButton.hidden = YES;
}
#pragma mark-btn点击事件
- (void)buttonClick:(UIButton *)sender{
    self.clickBlock(sender.tag - TAG);
}

#pragma mark-——画布
- (void)Canvas{
    //移除画布
    [_logoView removeFromSuperview];
    _logoView = nil;
    [_assistView removeFromSuperview];
    _assistView = nil;
    
    //创建辅助画布视图
    _assistView = [UIView new];
    _assistView.bounds = CGRectMake(0, 0, WIDTH_ALERT, WIDTH_ALERT);
    _assistView.center = CGPointMake([self lastWindow].center.x, [self lastWindow].center.y - 80);
    _assistView.backgroundColor = [UIColor blackColor];
    _assistView.alpha = 0.5;
    _assistView.layer.cornerRadius = 10;
    _assistView.layer.masksToBounds = YES;
    //新建画布
    _logoView                     = [UIView new];
    _logoView.center              = CGPointMake([self lastWindow].center.x, [self lastWindow].center.y - 80);
    _logoView.bounds              = CGRectMake(0, 0,WIDTH_ALERT , WIDTH_ALERT);
    _logoView.backgroundColor     = [UIColor clearColor];
    _logoView.layer.cornerRadius  = 10;
    _logoView.layer.shadowColor   = [UIColor blackColor].CGColor;
    _logoView.layer.shadowOffset  = CGSizeMake(0, 5);
    _logoView.layer.shadowOpacity = 0.3f;
    _logoView.layer.shadowRadius  = 10.0f;
    
    //保证画布位于所有视图层级的最下方
    if (_titleLabel != nil) {
        [[self lastWindow] insertSubview:_logoView belowSubview:_titleLabel];
        [[self lastWindow] insertSubview:_assistView belowSubview:_logoView];
    }else{
        [[self lastWindow] addSubview:_assistView];
        [[self lastWindow] addSubview:_logoView];
    }
}

#pragma mark-添加标题信息和详细信息
- (void)addTitle:(NSString *)title detail:(NSString *)detail{
    if (!title) {
        _titleLabel.hidden=YES;
        [_titleLabel setFont:[UIFont systemFontOfSize:Title_Font]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        CGFloat x = _logoView.frame.origin.x;
        CGFloat y = _logoView.frame.origin.y;
        CGFloat height = _logoView.frame.size.height;
        CGFloat width = _logoView.frame.size.width;
        _detailLabel.frame=CGRectMake(x ,y + height -Detial_Font - 15 , width, Detial_Font + 5);
    }else{
        _titleLabel.text  = title;
    }
    _detailLabel.text = detail;
}
-(void) draw_Success{
    [self Canvas];
    
    //自绘制图标中心点
    CGPoint pathCenter = CGPointMake(Logo_Center_x, Logo_Center_y);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:pathCenter radius:Logo_Size startAngle:-M_PI endAngle:M_PI clockwise:YES];
    
    //自绘制图标
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    
    CGFloat x = Logo_Center_x;
    CGFloat y = Logo_Center_y;
    //勾的起点
    [path moveToPoint:CGPointMake(x - Logo_Size + 8, y - 3)];
    //勾的最底端
    CGPoint p1 = CGPointMake(x - Logo_Size + 8 + 12, y + 10);
    [path addLineToPoint:p1];
    //勾的最上端
    CGPoint p2 = CGPointMake(x + Logo_Size - 8 , y - 10);
    [path addLineToPoint:p2];
    //新建图层——绘制上面的圆圈和勾
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor whiteColor].CGColor;
    layer.lineWidth = 3;
    layer.path = path.CGPath;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 0.5;
    [layer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
    [_logoView.layer addSublayer:layer];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(delay_Method) userInfo:nil repeats:NO];
}
- (void)draw_Fail{
    [self Canvas];
    
    CGFloat x = Logo_Center_x;
    CGFloat y = Logo_Center_y;
    
    //自绘制图标中心点
    CGPoint pathCenter = CGPointMake(x, y);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:pathCenter radius:Logo_Size startAngle:-M_PI/4*3 endAngle:M_PI*5/4 clockwise:YES];
    
    
    //圆角矩形
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    
    CGFloat spaceX = 11;
    CGFloat spaceY = 14;
    //斜线1
    [path moveToPoint:CGPointMake(x - spaceX , y - spaceY)];
    CGPoint p1 = CGPointMake(x + spaceX, y + spaceY);
    [path addLineToPoint:p1];
    //斜线2
    [path moveToPoint:CGPointMake(x + spaceX , y - spaceY)];
    CGPoint p2 = CGPointMake(x - spaceX, y + spaceY);
    [path addLineToPoint:p2];
    
    //新建图层——绘制上述路径
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor whiteColor].CGColor;
    layer.lineWidth = 3;
    layer.path = path.CGPath;
#pragma  使用NSStringFromSelector(@selector(strokeEnd))作为KeyPath的作用，绘制动画每一次Show均重复运行
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 0.5;
    //和上对应
    [layer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
    [_logoView.layer addSublayer:layer];
    
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(delay_Method) userInfo:nil repeats:NO];
}


-(void)draw_Waring{
    [self Canvas];
    
    CGFloat x = Logo_Center_x;
    CGFloat y = Logo_Center_y;
    
    //自绘制图标中心点
    CGPoint pathCenter = CGPointMake(x, y);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:pathCenter radius:Logo_Size startAngle:-M_PI/2 endAngle:M_PI*3/2 clockwise:YES];
    
    //自绘制图标中心dian
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    
    //绘制感叹号
    //绘制直线
    [path moveToPoint:CGPointMake(x, y - Logo_Size + 8)];
    CGPoint p4 = CGPointMake(x, y + Logo_Size - 15);
    [path addLineToPoint:p4];
    //绘制实心圆
    [path moveToPoint:CGPointMake(x, y + Logo_Size - 10)];
    [path addArcWithCenter:CGPointMake(x, y + Logo_Size - 10) radius:1.0f startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    //新建图层——绘制上述路径
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor whiteColor].CGColor;
    layer.lineWidth = 3;
    layer.path = path.CGPath;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 0.5;
    [layer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
    [_logoView.layer addSublayer:layer];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(delay_Method) userInfo:nil repeats:NO];
}

- (void)draw_NoSave {
    [self Canvas];
    
    CGFloat x = Logo_Center_x;
    CGFloat y = Logo_Center_y;
    
    //自绘制图标中心点
    CGPoint pathCenter = CGPointMake(x, y);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:pathCenter radius:Logo_Size startAngle:-M_PI/4*3 endAngle:M_PI*5/4 clockwise:YES];
    //绘制 中间的斜线
    CGFloat spaceX = 15;
    CGFloat spaceY = 18;
    //斜线1
    [path moveToPoint:CGPointMake(x - spaceX , y - spaceY)];
    CGPoint p1 = CGPointMake(x + spaceX, y + spaceY);
    [path addLineToPoint:p1];
    
    //新建图层——绘制上述路径
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor whiteColor].CGColor;
    layer.lineWidth = 3;
    layer.path = path.CGPath;
    
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 0.5;
    [layer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
    [_logoView.layer addSublayer:layer];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(delay_Method) userInfo:nil repeats:NO];
    
}

- (void)draw_Busy {
    [self Canvas];
    
    CGFloat x = Logo_Center_x;
    CGFloat y = Logo_Center_y;
    
    //自绘制图标中心点
    CGPoint pathCenter = CGPointMake(x, y);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:pathCenter radius:Logo_Size startAngle:-M_PI/2 endAngle:M_PI*3/2 clockwise:YES];
    
    //绘制实心圆
    [path moveToPoint:CGPointMake(x-1, y - Logo_Size + 10)];
    [path addArcWithCenter:CGPointMake(x-1, y - Logo_Size + 10) radius:1.0f startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    //绘制竖线
    [path moveToPoint:CGPointMake(x-4, y - Logo_Size + 17)];
    [path addLineToPoint:CGPointMake(x, y - Logo_Size + 17)];
    
    [path moveToPoint:CGPointMake(x, y - Logo_Size + 15)];
    [path addLineToPoint:CGPointMake(x, y + Logo_Size - 8)];
    
    [path moveToPoint:CGPointMake(x-4, y + Logo_Size - 8)];
    [path addLineToPoint:CGPointMake(x+4, y + Logo_Size - 8)];
    
    //新建图层——绘制上述路径
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor whiteColor].CGColor;
    layer.lineWidth = 3;
    layer.path = path.CGPath;
    
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 0.5;
    [layer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
    [_logoView.layer addSublayer:layer];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(delay_Method) userInfo:nil repeats:NO];
    
}

- (void) addButtonTitleWithCancle:(NSString *)cancle OK:(NSString *)ok{
    BOOL flag = NO;
    if (cancle == nil && ok != nil ) {
        flag = YES;
    }
    CGFloat centerY = _detailLabel.center.y + 40;
    if (flag) {
        _OkButton.center = CGPointMake(_detailLabel.center.x, centerY);
        _OkButton.bounds = CGRectMake(0, 0, Button_Size_Width, Button_Size_Height);
        _canleButton.hidden = YES;
        
    }else{
        _canleButton.hidden = NO;
        [_canleButton setTitle:cancle forState:UIControlStateNormal];
        _OkButton.center = CGPointMake(_detailLabel.center.x + 50, centerY);
        _OkButton.bounds = CGRectMake(0, 0, Button_Size_Width, Button_Size_Height);
    }
    _OkButton.hidden = NO;
    [_OkButton setTitle:ok forState:UIControlStateNormal];
}

#pragma mark-获取全屏最上层的Window
-(UIWindow *)lastWindow{
    NSArray *windows = [UIApplication sharedApplication].windows;
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        if ([window isKindOfClass:[UIWindow class]] &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds) && ![NSStringFromClass(window.class) isEqualToString:@"UIRemoteKeyboardWindow"])
            
            return window;
    }
    return [UIApplication sharedApplication].keyWindow;
}
-(void)delay_Method{
    _logoView.hidden=YES;
    _assistView.hidden = YES;
    _OkButton.hidden=YES;
    _titleLabel.hidden=YES;
    _detailLabel.hidden=YES;
    _canleButton.hidden=YES;
    [_logoView removeFromSuperview];
    [_assistView removeFromSuperview];
    [_OkButton removeFromSuperview];
    [_titleLabel removeFromSuperview];
    [_detailLabel removeFromSuperview];
    [_canleButton removeFromSuperview];
}

@end





















