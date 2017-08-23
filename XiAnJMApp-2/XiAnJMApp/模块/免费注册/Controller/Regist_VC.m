//
//  Regist_VC.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/23.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "Regist_VC.h"
#import "Common.h"
@interface Regist_VC ()
@property (weak, nonatomic) IBOutlet UIButton *btn_Firm;

@property (weak, nonatomic) IBOutlet UIButton *btn_Moni;

- (IBAction)action_Firm:(id)sender;

- (IBAction)action_Moni:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *btn_Regist;


- (IBAction)action_Regist:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *view_line_Firm;

@property (strong, nonatomic) IBOutlet UIView *view_line_Moni;

@property (weak, nonatomic) IBOutlet UIButton *btn_code;

- (IBAction)action_code:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *view_sex;

@property (weak, nonatomic) IBOutlet UIButton *btn_Man;

@property (weak, nonatomic) IBOutlet UIButton *btn_women;

- (IBAction)action_man:(id)sender;

- (IBAction)action_women:(id)sender;



@end

@implementation Regist_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];

}


-(void)viewWillAppear:(BOOL)animated{
    
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createUI{

    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"Back1"] ];

    
    [_btn_Firm setTitleColor:RGB(190, 195, 198) forState:UIControlStateNormal];//title color
    [_btn_Moni setTitleColor:RGB(49, 152, 124) forState:UIControlStateNormal];//title color

    _view_line_Firm.backgroundColor=RGB(49, 152, 124);
    _view_line_Moni.backgroundColor=RGB(49, 152, 124);
    _view_line_Firm.hidden=YES;
    _view_line_Moni.hidden=NO;
    
    
    [_btn_Regist.layer setCornerRadius:5.0]; //设置矩形圆角半径
    
    

    _view_sex.backgroundColor=RGB(49, 152, 124);
    _view_sex.clipsToBounds=YES;
    _view_sex.layer.cornerRadius = 5.0;
    
    [_btn_code.layer setCornerRadius:5.0]; //设置矩形圆角半径
    _btn_code.backgroundColor=RGB(49, 152, 124);

    
    
}


- (IBAction)action_Firm:(id)sender {
    [_btn_Firm setTitleColor:RGB(49, 152, 124) forState:UIControlStateNormal];//title color
    [_btn_Moni setTitleColor:RGB(190, 195, 198) forState:UIControlStateNormal];//title color
    _view_line_Firm.hidden=NO;
    _view_line_Moni.hidden=YES;
    
}

- (IBAction)action_Moni:(id)sender {
    [_btn_Firm setTitleColor:RGB(190, 195, 198) forState:UIControlStateNormal];//title color
    [_btn_Moni setTitleColor:RGB(49, 152, 124) forState:UIControlStateNormal];//title color
    _view_line_Firm.hidden=YES;
    _view_line_Moni.hidden=NO;
    
}

- (IBAction)action_Regist:(id)sender {
    
    NSLog(@"点击了完成注册");
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)action_code:(id)sender {
    
    
    __block NSInteger second = 60;
    //全局队列    默认优先级
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //定时器模式  事件源
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    //NSEC_PER_SEC是秒，＊1是每秒
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), NSEC_PER_SEC * 1, 0);
    //设置响应dispatch源事件的block，在dispatch源指定的队列上运行
    dispatch_source_set_event_handler(timer, ^{
        //回调主线程，在主线程中操作UI
        dispatch_async(dispatch_get_main_queue(), ^{
            if (second >= 0) {
                [_btn_code setTitle:[NSString stringWithFormat:@"(%ld)重发",second] forState:UIControlStateNormal];
                second--;
            }
            else
            {
                //这句话必须写否则会出问题
                dispatch_source_cancel(timer);
                [_btn_code setTitle:@"获取验证码" forState:UIControlStateNormal];
                
            }
        });
    });
    //启动源
    dispatch_resume(timer);
    
    
    
}
- (IBAction)action_man:(id)sender {
}

- (IBAction)action_women:(id)sender {
}
@end














































