


#import <UIKit/UIKit.h>

/**
 *  点击样式
 */
typedef NS_ENUM(NSInteger, MyWindowClick){
    /**
     *  点击确定按钮
     */
    MyWindowClickForOK = 0,
    /**
     *  点击取消按钮
     */
    MyWindowClickForCancel
};

/**
 *  提示框显示样式
 */
typedef NS_ENUM(NSInteger, BKAlertViewStyle){
    BKAlertStyle_Success=0,//成功
    BKAlertStyle_Fail,//失败
    BKAlertStyle_Waring,//警告
    BKAlertStyle_Busy,//繁忙；
    BKAlertStyle_NoSave//没有服务；
};

typedef void (^BKAnimatedAlert_callBack)(MyWindowClick buttonIndex);
@interface BKAnimatedAlert : NSObject

@property (nonatomic, copy) BKAnimatedAlert_callBack clickBlock ;//按钮点击事件的回调


/**
 *  创建AlertView并展示
 */
- (void)BKAlert_Style:(BKAlertViewStyle)style detail:(NSString *)detail;
- (void)BKAlert_Style:(BKAlertViewStyle)style title:(NSString *)title detail:(NSString *)detail ;
- (void)BKAlert_Style:(BKAlertViewStyle)style title:(NSString *)title detail:(NSString *)detail canleButtonTitle:(NSString *)canle okButtonTitle:(NSString *)ok callBlock:(BKAnimatedAlert_callBack)callBack;
-(void)delay_Method;
/**
 *  根据内容多少确定弹窗大小
 */
-(void)BkAlert_Style:(BKAlertViewStyle)style accordingDetailContentAutoLayout:(NSString *)detail;

@end
