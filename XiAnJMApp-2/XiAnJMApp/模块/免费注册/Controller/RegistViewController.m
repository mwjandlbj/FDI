//
//  RegistViewController.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/7/11.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "RegistViewController.h"

#import "Common.h"
#import "AlertView.h"
#import "HttpRequest.h"

@interface RegistViewController ()

@property(nonatomic,strong)UITextField  *phoneNumTF;
@property(nonatomic,strong)UITextField  *codeNumTF;
@property(nonatomic,strong)UITextField  *nicknameTF;

@property(nonatomic,strong)UIButton     *getCodeBtn;

@property(nonatomic,strong)NSTimer      *timer;
@property(nonatomic,assign)NSInteger     timerCount;

@property(nonatomic,assign)NSString     *codeStr;

@end

@implementation RegistViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    [self.timer invalidate];
    self.timer = nil;
    
    self.codeNumTF.text = @"";
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.phoneNumTF resignFirstResponder];
    [self.codeNumTF resignFirstResponder];
    [self.nicknameTF resignFirstResponder];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    //导航栏设置黑色
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.title = @"注册";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    //背景图
    UIImageView  *img = [UIImageView new];
    img.frame = self.view.frame;
//    img.backgroundColor = [UIColor redColor];
    img.image = [UIImage imageNamed:@""];
    [self.view addSubview:img];
    
    [self createView];
}

- (void)createView {
    
    for (int i = 0; i < 3; i++) {
        UIImageView  *img = [UIImageView new];
        img.frame= CGRectMake(ScreenWidth*0.099, ScreenWidth*0.523+i*(ScreenWidth*0.152), ScreenWidth*0.061, ScreenWidth*0.061);
        img.backgroundColor = [UIColor redColor];
        [self.view addSubview:img];
        
        UIImageView  *lineImg = [UIImageView new];
        lineImg.frame = CGRectMake(ScreenWidth*0.099, ScreenWidth*0.592+i*(ScreenWidth*0.152), ScreenWidth*0.803, 1);
        lineImg.backgroundColor = RGB(146,156,169);
        [self.view addSubview:lineImg];
    }
    
    _phoneNumTF = [UITextField new];
    _phoneNumTF.frame = CGRectMake(ScreenWidth*0.187, ScreenWidth*0.531, ScreenWidth*0.4, ScreenWidth*0.053);
    _phoneNumTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入您的手机号" attributes:@{NSForegroundColorAttributeName: RGB(196,201,209)}];
    _phoneNumTF.font = [UIFont systemFontOfSize:13];
    _phoneNumTF.textColor = [UIColor whiteColor];
    _phoneNumTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_phoneNumTF];
    
    _codeNumTF = [UITextField new];
    _codeNumTF.frame = CGRectMake(ScreenWidth*0.187, ScreenWidth*0.678, ScreenWidth*0.4, ScreenWidth*0.053);
    _codeNumTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName: RGB(196,201,209)}];
    _codeNumTF.font = [UIFont systemFontOfSize:13];
    _codeNumTF.textColor = [UIColor whiteColor];
    _codeNumTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_codeNumTF];
    
    _nicknameTF = [UITextField new];
    _nicknameTF.frame = CGRectMake(ScreenWidth*0.187, ScreenWidth*0.835, ScreenWidth*0.66, ScreenWidth*0.053);
    _nicknameTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入昵称(10位以内字母、汉字、数字)" attributes:@{NSForegroundColorAttributeName: RGB(196,201,209)}];
    _nicknameTF.font = [UIFont systemFontOfSize:13];
    _nicknameTF.textColor = [UIColor whiteColor];
    [_nicknameTF addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_nicknameTF];
    
    
    _getCodeBtn = [UIButton new];
    _getCodeBtn.frame = CGRectMake(ScreenWidth*0.685, ScreenWidth*0.667, ScreenWidth*0.213, ScreenWidth*0.069);
    _getCodeBtn.backgroundColor = RGB(44,179,120);
    _getCodeBtn.layer.cornerRadius = 4;
    _getCodeBtn.clipsToBounds = YES;
    [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_getCodeBtn addTarget:self action:@selector(getCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_getCodeBtn];
    
    
    UIButton  *registBtn = [UIButton new];
    registBtn.frame = CGRectMake(ScreenWidth*0.099, ScreenWidth*1.04, ScreenWidth*0.803, ScreenWidth*0.136);
    registBtn.backgroundColor = RGB(227,74,80);
    registBtn.layer.cornerRadius = 5;
    registBtn.clipsToBounds = YES;
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    registBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [registBtn addTarget:self action:@selector(registBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
}

#pragma mark  ---限制昵称长度
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (self.nicknameTF.text.length > 10) {
        [AlertView alertViewWithText:@"请输入10位以内的昵称" withVC:self];
        self.nicknameTF.text = @"";
    }
}

#pragma mark  ---获取验证码
- (void)getCodeBtnClick:(UIButton *)sender {
    
    if (self.phoneNumTF.text.length == 11 &&[self isMobileNumber:self.phoneNumTF.text]) {
        
        [AlertView alertViewWithText:@"验证码已发送，请注意查收" withVC:self];
        
        [self.codeNumTF isFirstResponder];
        
        //请求
        
        NSString  *url = @"http://www.wxgjjr.com/appServlet";
        
//        [HttpRequest requestForPostWithBlock:^(NSArray *dataArr) {
//            NSLog(@"----------验证码已发送----------------------%@",dataArr);
//        } withURL:url withPhoneNum:self.phoneNumTF.text withDictionary:@{@"phoneNumber":self.phoneNumTF.text}];
        [HttpRequest requestForPostWithBlock:^(NSArray *dataArr) {
            NSLog(@"----------验证码已发送----------------------%@",dataArr);
//            _codeStr = [dataArr firstObject];
            NSString  *str = [dataArr firstObject];
            NSArray  *arr = [str componentsSeparatedByString:@"\n"];
            _codeStr = [arr firstObject];
            
            NSLog(@"_codeStr---%@",_codeStr);
            
        } withURL:url withState:@"1" withPhoneNum:self.phoneNumTF.text withNickName:@"" withDictionary:@{@"state":@"1",@"phoneNumber":self.phoneNumTF.text}];

        
        sender.userInteractionEnabled = NO;
        self.timerCount = 60;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceTime:) userInfo:sender repeats:YES];
        
    }else {
        [AlertView alertViewWithText:@"请输入正确的手机号" withVC:self];
    }
}

#pragma mark  ---注册
- (void)registBtnClick:(UIButton *)sender {
    
    if (self.phoneNumTF.text.length == 11 && self.codeNumTF.text.length == 6 && self.nicknameTF.text.length > 0) {
        
        if ([self.codeNumTF.text isEqualToString:[NSString stringWithFormat:@"%@",self.codeStr]]) {
            
            
            NSString  *url = @"http://www.wxgjjr.com/appServlet";
            
            [HttpRequest requestForPostWithBlock:^(NSArray *dataArr) {
                
//                NSLog(@"------dataArr----验证码已发送----------------------%@",dataArr);
                
                
                
            } withURL:url withState:@"2" withPhoneNum:self.phoneNumTF.text withNickName:self.nicknameTF.text withDictionary:@{@"state":@"2",@"phoneNumber":self.phoneNumTF.text,@"nickName":self.nicknameTF.text}];
            
            [AlertView alertViewWithText:@"您的请求已受理，请注意查收短信" withVC:self];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else {
            [AlertView alertViewWithText:@"您输入的验证码有误" withVC:self];
            return;
        }
        
    }else {
        [AlertView alertViewWithText:@"请输入正确的手机号、验证码或昵称" withVC:self];
    }
    
}
#pragma mark  ---重新获得验证码
- (void)reduceTime:(NSTimer *)codeTimer {
    
    self.timerCount--;
    if (self.timerCount == 0) {
        [self.getCodeBtn setTitle:@"重获验证码" forState:UIControlStateNormal];
        self.getCodeBtn.userInteractionEnabled = YES;
        [self.timer invalidate];
    }else {
        NSString  *str = [NSString stringWithFormat:@"%lds重新获取",(long)self.timerCount];
        [self.getCodeBtn setTitle:str forState:UIControlStateNormal];
        self.getCodeBtn.userInteractionEnabled = NO;
    }
}

#pragma mark  ---检测手机号真伪
- (BOOL)isMobileNumber:(NSString *)mobileNum {
    //正则表达式匹配11位手机号码
    NSString *regex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:mobileNum];
    if(isMatch) { //有效手机号
        return YES;
    }else//无效手机号
    {
        [AlertView alertViewWithText:@"请输入正确的手机号" withVC:self];
        return NO;
    }
}

#pragma mark  ---键盘控制
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.phoneNumTF resignFirstResponder];
    [self.codeNumTF resignFirstResponder];
    [self.nicknameTF resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
