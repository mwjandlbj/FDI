//
//  JM_Login_VC.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/22.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "JM_Login_VC.h"
#import "Glb_M_VC.h"
#import "RootNavigationController.h"
#import "Common.h"
#import "Regist_VC.h"
#import "GCDSocketManager.h"
#import "TcpManager.h"

#import "RegistViewController.h"

#import "AlertView.h"

#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <unistd.h>

#import <arpa/inet.h>
#import <netdb.h>

#define kSelfHeight  UIScreen.mainScreen.bounds.size.height

#define kSelfWidth  UIScreen.mainScreen.bounds.size.width


#import "UDPManager.h"
@interface JM_Login_VC () {
    NSInteger      count1;
    NSInteger      count2;
}

@property (strong, nonatomic) UIImageView  *accountImage;//  账号图片
@property (weak, nonatomic) IBOutlet UILabel *accountLab;
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (strong, nonatomic) UIImageView *accountLine;

@property (strong, nonatomic) UIImageView  *passwordImage;// 密码图片
@property (weak, nonatomic) IBOutlet UILabel *passwordLab;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (strong, nonatomic) UIImageView *passwordLine;

@property (nonatomic,strong)UIImageView   *runLine;//滑动的线


@property (nonatomic,strong) UIButton    *remeberAccount;
@property (nonatomic,strong) UIImageView    *remeberAccountImage;
@property (nonatomic,strong) UILabel    *remeberAccountLab;
@property (nonatomic,strong) UIButton    *remeberPassword;
@property (nonatomic,strong) UIImageView    *remeberPasswordImage;
@property (nonatomic,strong) UILabel    *remeberPasswordLab;


/*
 * 背景图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *ImgV_Back;

/*
 * 实盘
 */
@property (weak, nonatomic) IBOutlet UIButton *btn_Firm;
- (IBAction)Action_Firm:(id)sender;




/*
 * 模拟
 */
@property (weak, nonatomic) IBOutlet UIButton *btn_moni;
- (IBAction)Action_Moni:(id)sender;



/*
 * 登录
 */
@property (weak, nonatomic) IBOutlet UIButton *btn_Login;
- (IBAction)Action_Login:(id)sender;



/*
 * 忘记密码
 */
@property (weak, nonatomic) IBOutlet UIButton *btn_ForgetPassword;

- (IBAction)Action_ForgetPassword:(id)sender;




/*
 * 免费注册
 */
@property (weak, nonatomic) IBOutlet UIButton *btn_Register;


- (IBAction)Action_Register:(id)sender;


@property (nonatomic,strong)GCDSocketManager * manager;



@end

@implementation JM_Login_VC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    count1 = 0;
    count2 = 0;
    
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.accountTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];

}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createUI];
    
    
//    [self updataWindows];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeVC:) name:@"loginrspSUCCESS" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginfail:) name:@"loginrspFAIL" object:nil];
    
    //实盘不提供注册和忘记密码
    self.btn_Register.hidden = YES;
    self.btn_ForgetPassword.hidden = YES;
    
//    self.accountTF.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"account"];
//    self.passwordTF.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
}

// 自定义警示框
-(void)updataWindows {
    
    UIWindow  *windows = [UIApplication sharedApplication].keyWindow;
    
//    windows = [UIApplication sharedApplication].keyWindow;
    
    
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(40, kScreenHeight/2 - 40, kScreenWidth - 80, 80)];
    
    view.backgroundColor = [UIColor blackColor];
    
    view.layer.masksToBounds = YES;
    
    view.layer.cornerRadius = 8.0f;
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view.bounds.size.width, 80)];
    
    label.numberOfLines = 3;
    
    label.text = @" 您的信息已经重新提交，我们正在在加紧审核，请稍侯 ";
    
    label.textColor = [UIColor whiteColor];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [windows addSubview:view];
    
    [view addSubview:label];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
        
        //2秒以后移除view
        
        [view removeFromSuperview];
        
    });
    
}

-(void)createUI{
    self.view.backgroundColor=[UIColor whiteColor];
    _ImgV_Back.image=[UIImage imageNamed:@"Back1"];
    
    
    _btn_Login.bounds = CGRectMake(0, 0, kSelfWidth*0.76, kSelfWidth*0.136);
    _btn_Login.center = CGPointMake(self.view.center.x, self.view.center.y*1.34);
    _btn_Login.backgroundColor=[UIColor colorWithRed:178.f/255.f green:72.f/255.f blue:92.f/255.f alpha:1];
    [_btn_Login.layer setCornerRadius:5.0]; //设置矩形圆角半径
    
    [_btn_Login.layer setBorderWidth:1.0]; //边框宽度
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 252.f/255.f,98.f/255.f,92.f/255.f , 1 });
    [_btn_Login.layer setBorderColor:colorref];//边框颜色
    
    [_btn_Login setTitle:@"登录实盘" forState:UIControlStateNormal];//button title
    [_btn_Login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//title color

    
    
    _manager = [GCDSocketManager sharedSocketManager];
    [_manager   connectToServer];

//    UDPManager  *udp=[UDPManager sharedSocketManager];
//    [udp        connectToServer];
    
    
    
    
//    TcpManager *tcp = [TcpManager Share];
//    GCDAsyncSocket *socket = tcp.asyncsocket;
//    if (![socket connectToHost:@"101.37.86.94" onPort:50613 error:nil]) {
//        NSLog(@"fail to connect");
//    }
//    [socket readDataWithTimeout:3 tag:1];
//    [socket writeData:[@"LoginBeat\r&\r\n" dataUsingEncoding:NSUTF8StringEncoding] withTimeout:3 tag:1];
    
    
    
    //实盘
    _btn_Firm.bounds = CGRectMake(0, 0, kSelfWidth*0.187, kSelfWidth*0.091);
    _btn_Firm.center = CGPointMake(self.view.center.x/2, self.view.center.y*0.386);
    [_btn_Firm setTitleColor:[UIColor colorWithRed:227.f/255.f green:74.f/255.f blue:80.f/255.f alpha:1] forState:UIControlStateNormal];
    
    self.runLine = [UIImageView new];
    self.runLine.bounds = CGRectMake(0, 0, kSelfWidth*0.203, 1);
    self.runLine.center = CGPointMake(_btn_Firm.center.x, self.view.center.y*0.42);
    _runLine.backgroundColor = [UIColor colorWithRed:227.f/255.f green:74.f/255.f blue:80.f/255.f alpha:1];
    [self.view addSubview:_runLine];
    
    //模拟
    _btn_moni.bounds = CGRectMake(0, 0, kSelfWidth*0.187, kSelfWidth*0.091);
    _btn_moni.center = CGPointMake(self.view.center.x*1.5, self.view.center.y*0.386);
    
    
    //账号
    self.accountImage = [UIImageView new];
    self.accountImage.bounds = CGRectMake(0, 0, kSelfWidth*0.061, kSelfWidth*0.061);
    self.accountImage.center = CGPointMake(self.view.center.x*0.3, self.view.center.y*0.735);
    self.accountImage.image = [UIImage imageNamed:@"ic_person_main"];
    [self.view addSubview:self.accountImage];
    
    
    self.accountLab.bounds = CGRectMake(0, 0, kSelfWidth*0.15, kSelfWidth*0.02);
    self.accountLab.center = CGPointMake(self.view.center.x*0.53, self.view.center.y*0.735);
    
    self.accountTF.bounds = CGRectMake(0, 0, kSelfWidth*0.52, kSelfWidth*0.067);
    self.accountTF.center = CGPointMake(self.view.center.x*1.15, self.view.center.y*0.735);
    self.accountTF.backgroundColor = [UIColor clearColor];
    [self.accountTF setValue:RGB(178, 181, 198) forKeyPath:@"_placeholderLabel.textColor"];
    
    self.accountLine = [UIImageView new];
    self.accountLine.bounds = CGRectMake(0, 0, kSelfWidth*0.76, 1);
    self.accountLine.center = CGPointMake(self.view.center.x, self.view.center.y*0.78);
    self.accountLine.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.accountLine];
    
    
    //密码
    self.passwordImage = [UIImageView new];
    self.passwordImage.bounds = CGRectMake(0, 0, kSelfWidth*0.061, kSelfWidth*0.061);
    self.passwordImage.center = CGPointMake(self.view.center.x*0.3, self.view.center.y*0.91);
    self.passwordImage.image = [UIImage imageNamed:@"ic_psd_main"];
    [self.view addSubview:self.passwordImage];
    
    self.passwordLab.bounds = CGRectMake(0, 0, kSelfWidth*0.15, kSelfWidth*0.02);
    self.passwordLab.center = CGPointMake(self.view.center.x*0.53, self.view.center.y*0.91);
    
    
    self.passwordTF.bounds = CGRectMake(0, 0, kSelfWidth*0.52, kSelfWidth*0.067);
    self.passwordTF.center = CGPointMake(self.view.center.x*1.15, self.view.center.y*0.91);
    self.passwordTF.backgroundColor = [UIColor clearColor];
    [self.passwordTF setValue:RGB(178, 181, 198) forKeyPath:@"_placeholderLabel.textColor"];
    
    
    self.passwordLine = [UIImageView new];
    self.passwordLine.bounds = CGRectMake(0, 0, kSelfWidth*0.76, 1);
    self.passwordLine.center = CGPointMake(self.view.center.x, self.view.center.y*0.96);
    self.passwordLine.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.passwordLine];
    
    
    //记住账号
    self.remeberAccount = [UIButton new];
    self.remeberAccount.bounds = CGRectMake(0, 0, kSelfWidth*0.25, kSelfWidth*0.08);
    self.remeberAccount.center = CGPointMake(self.view.center.x*0.5, self.view.center.y*1.1);
//    self.remeberAccount.backgroundColor = [UIColor redColor];
    [self.remeberAccount addTarget:self action:@selector(remeberAccountBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.remeberAccount];
    
    self.remeberAccountImage = [UIImageView new];
    self.remeberAccountImage.frame = CGRectMake(kSelfWidth*0.04, kSelfWidth*0.02, kSelfWidth*0.04, kSelfWidth*0.04);
    self.remeberAccountImage.image = [UIImage imageNamed:@"kuang_03"];
//    self.remeberAccountImage.backgroundColor = [UIColor yellowColor];
    [self.remeberAccount addSubview:self.remeberAccountImage];
    
    
    self.remeberAccountLab = [UILabel new];
    self.remeberAccountLab.frame = CGRectMake(kSelfWidth*0.1, 0, kSelfWidth*0.2, kSelfWidth*0.08);
    self.remeberAccountLab.text = @"记住账号";
    self.remeberAccountLab.font = [UIFont systemFontOfSize:12];
//    self.remeberAccountLab.backgroundColor = [UIColor yellowColor];
    self.remeberAccountLab.textColor = [UIColor colorWithRed:196.f/255.f green:201.f/255.f blue:209.f/255.f alpha:1];
    [self.remeberAccount addSubview:self.remeberAccountLab];

    
    //记住密码
    self.remeberPassword = [UIButton new];
    self.remeberPassword.bounds = CGRectMake(0, 0, kSelfWidth*0.25, kSelfWidth*0.08);
    self.remeberPassword.center = CGPointMake(self.view.center.x*1.5, self.view.center.y*1.1);
//    self.remeberPassword.backgroundColor = [UIColor redColor];
    [self.remeberPassword addTarget:self action:@selector(remeberPasswordBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.remeberPassword];
    
    
    self.remeberPasswordImage = [UIImageView new];
    self.remeberPasswordImage.frame = CGRectMake(kSelfWidth*0.04, kSelfWidth*0.02, kSelfWidth*0.04, kSelfWidth*0.04);
    self.remeberPasswordImage.image = [UIImage imageNamed:@"kuang_03"];
//    self.remeberPasswordImage.backgroundColor = [UIColor yellowColor];
    [self.remeberPassword addSubview:self.remeberPasswordImage];
    
    
    self.remeberPasswordLab = [UILabel new];
    self.remeberPasswordLab.frame = CGRectMake(kSelfWidth*0.1, 0, kSelfWidth*0.2, kSelfWidth*0.08);
    self.remeberPasswordLab.text = @"记住密码";
    self.remeberPasswordLab.font = [UIFont systemFontOfSize:12];
//    self.remeberPasswordLab.backgroundColor = [UIColor yellowColor];
    self.remeberPasswordLab.textColor = [UIColor colorWithRed:196.f/255.f green:201.f/255.f blue:209.f/255.f alpha:1];
    [self.remeberPassword addSubview:self.remeberPasswordLab];
    
    
    //忘记密码

    self.btn_ForgetPassword.bounds = CGRectMake(0, 0, kSelfWidth*0.25, kSelfWidth*0.08);
    self.btn_ForgetPassword.center = CGPointMake(self.view.center.x/2, self.view.center.y*1.555);
//    self.btn_ForgetPassword.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.btn_ForgetPassword];
    
    
    //免费注册
    self.btn_Register.bounds = CGRectMake(0, 0, kSelfWidth*0.25, kSelfWidth*0.08);
    self.btn_Register.center = CGPointMake(self.view.center.x*1.5, self.view.center.y*1.555);
//    self.btn_Register.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.btn_Register];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 * 实盘
 */
- (IBAction)Action_Firm:(id)sender {
    
    
    self.btn_Register.hidden = YES;
    self.btn_ForgetPassword.hidden = YES;
    
    _ImgV_Back.image=[UIImage imageNamed:@"shipan.jpg"];
    
    [_btn_Firm setTitleColor:[UIColor colorWithRed:227.f/255.f green:74.f/255.f blue:80.f/255.f alpha:1] forState:UIControlStateNormal];
    [_btn_moni setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btn_Login setTitle:@"登录实盘" forState:UIControlStateNormal];//button title

    [UIView animateWithDuration:0.3 animations:^{
        self.runLine.bounds = CGRectMake(0, 0, 76, 1);
        self.runLine.center = CGPointMake(_btn_Firm.center.x, self.view.center.y*0.42);
    }];
    
    
}



/*
 * 模拟
 */
- (IBAction)Action_Moni:(id)sender {
    
    self.btn_Register.hidden = NO;
    self.btn_ForgetPassword.hidden = NO;
    
    _ImgV_Back.image=[UIImage imageNamed:@"moni.jpg"];
    
    [_btn_moni setTitleColor:[UIColor colorWithRed:227.f/255.f green:74.f/255.f blue:80.f/255.f alpha:1] forState:UIControlStateNormal];
    [_btn_Firm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [_btn_Login setTitle:@"登录模拟" forState:UIControlStateNormal];//button title
    
    [UIView animateWithDuration:0.3 animations:^{
        self.runLine.bounds = CGRectMake(0, 0, 76, 1);
        self.runLine.center = CGPointMake(_btn_moni.center.x, self.view.center.y*0.42);
    }];
    
}


/*
 * 登录
 */

#pragma mark  ---登录
- (IBAction)Action_Login:(id)sender {
   
    
    //Glb_M_VC * VC =[[Glb_M_VC alloc]init];
    //[self.navigationController pushViewController:VC animated:YES];
    
//    NSLog(@"%@",[NSThread currentThread]);
    
    if (self.accountTF.text.length >0 &&self.passwordTF.text.length >0) {
        
    [_manager Action_LoginWithAccount:self.accountTF.text withPassword:self.passwordTF.text];
    
    }else {
        [AlertView alertViewWithText:@"请输入账号或密码" withVC:self];
    }
    
}

/*
 * 忘记密码
 */
- (IBAction)Action_ForgetPassword:(id)sender {
    
    NSLog(@"点击了忘记密码");
    
}


/*
 * 免费注册
 */
- (IBAction)Action_Register:(id)sender {
    
//    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Regist_VC" bundle:[NSBundle mainBundle]];
//    UIViewController *Regist_VC = [story instantiateViewControllerWithIdentifier:@"Regist_VC"];
//    
//    [self.navigationController pushViewController:Regist_VC animated:YES];
    
    RegistViewController  *registVC = [RegistViewController new];
    [self.navigationController pushViewController:registVC animated:YES];
    
}


//
//- (void)test
//{
//
//    
//    NSString * host =@"101.37.86.94";
//    NSNumber * port = @50613;
//    
//    // 创建 socket
//    int socketFileDescriptor = socket(AF_INET, SOCK_STREAM, 0);
//    if (-1 == socketFileDescriptor) {
//        NSLog(@"创建失败");
//        return;
//    }
//    
//    // 获取 IP 地址
//    struct hostent * remoteHostEnt = gethostbyname([host UTF8String]);
//    if (NULL == remoteHostEnt) {
//        close(socketFileDescriptor);
//        NSLog(@"%@",@"无法解析服务器的主机名");
//        return;
//    }
//    
//    struct in_addr * remoteInAddr = (struct in_addr *)remoteHostEnt->h_addr_list[0];
//    
//    // 设置 socket 参数
//    struct sockaddr_in socketParameters;
//    socketParameters.sin_family = AF_INET;
//    socketParameters.sin_addr = *remoteInAddr;
//    socketParameters.sin_port = htons([port intValue]);
//    
//    // 连接 socket
//    int ret = connect(socketFileDescriptor, (struct sockaddr *) &socketParameters, sizeof(socketParameters));
//    if (-1 == ret) {
//        close(socketFileDescriptor);
//        NSLog(@"连接失败");
//        return;
//    }
//    
//    NSLog(@"连接成功");
//}
//
//#pragma mark -socket的代理
//#pragma mark 连接成功
//-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
//    NSLog(@"%s",__func__);
//}
//
//
//#pragma mark 断开连接
//-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
//    if (err) {
//        NSLog(@"连接失败");
//    }else{
//        NSLog(@"正常断开");
//    }
//}
//
//
//#pragma mark 数据发送成功
//-(void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
//    NSLog(@"%s",__func__);
//    
//    //发送完数据手动读取，-1不设置超时
//    [sock readDataWithTimeout:-1 tag:tag];
//}
//
//#pragma mark 读取数据
//-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
//    NSString *receiverStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"%s %@",__func__,receiverStr);
//}

#pragma mark  ---记住账号
- (void)remeberAccountBtn:(UIButton *)sender {
    count1 += 1;
    if (count1%2 == 1) {
        self.remeberAccountImage.image = [UIImage imageNamed:@"gouxuankuang"];
        self.remeberAccountLab.textColor = [UIColor colorWithRed:44.f/255.f green:179.f/255.f blue:120.f/255.f alpha:1];
    }else {
        self.remeberAccountImage.image = [UIImage imageNamed:@"kuang_03"];
        self.remeberAccountLab.textColor = [UIColor colorWithRed:196.f/255.f green:201.f/255.f blue:209.f/255.f alpha:1];
    }
    
}
#pragma mark  ---记住密码
- (void)remeberPasswordBtn:(UIButton *)sender {
   
    count2 += 1;
    if (count2%2 == 1) {
        self.remeberPasswordImage.image = [UIImage imageNamed:@"gouxuankuang"];
        self.remeberPasswordLab.textColor = [UIColor colorWithRed:44.f/255.f green:179.f/255.f blue:120.f/255.f alpha:1];
    }else {
        self.remeberPasswordImage.image = [UIImage imageNamed:@"kuang_03"];
        self.remeberPasswordLab.textColor = [UIColor colorWithRed:196.f/255.f green:201.f/255.f blue:209.f/255.f alpha:1];
    }
}


#pragma mark  ---键盘控制
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.accountTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
}


#pragma MARK - notifacation --登陆成功
- (void)changeVC:(NSNotification*)sender{
    
    //存账号-密码
    
    
    
    [[NSUserDefaults standardUserDefaults] setObject:[self.accountTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"account"];
    [[NSUserDefaults standardUserDefaults] setObject:self.passwordTF.text forKey:@"password"];
    
    //NSLog(@"self.accountTF.text--%@self.passwordTF.text--%@",[self.accountTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]],self.passwordTF.text);
    
    
    
    Glb_M_VC * VC =[[Glb_M_VC alloc]init];
    [self.navigationController pushViewController:VC animated:YES];

}
- (void)loginfail:(NSNotification *)sender {
//    NSLog(@"loginfailloginfailloginfailloginfailloginfailloginfailloginfailloginfail");
    
    [AlertView alertViewWithText:@"您输入的账号或密码错误" withVC:self];
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"loginrspSUCCESS" object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"loginrspFAIL" object:nil];
}

@end


























