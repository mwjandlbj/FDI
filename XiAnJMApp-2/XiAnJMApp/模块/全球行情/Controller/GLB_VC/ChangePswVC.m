//
//  ChangePswVC.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/7/14.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "ChangePswVC.h"

#import "Common.h"

#import "AlertView.h"

#import "GCDSocketManager.h"




@interface ChangePswVC ()

@property(nonatomic,strong)UITextField  *oldPswTF;
@property(nonatomic,strong)UITextField  *newsPswTF;
@property(nonatomic,strong)UITextField  *surePswTF;

@property (nonatomic,strong)GCDSocketManager * manager;

@end

@implementation ChangePswVC


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.oldPswTF resignFirstResponder];
    [self.newsPswTF resignFirstResponder];
    [self.surePswTF resignFirstResponder];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGB(224,224,224);
    //导航栏设置黑色
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.title = @"修改密码";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:14],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    _manager = [GCDSocketManager sharedSocketManager];
    
    [self createView];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePasswordrspSUCCESS:) name:@"changePasswordrspSUCCESS" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePasswordrspFAIL:) name:@"changePasswordrspFAIL" object:nil];
}

/*
 * 修改密码成功
 */
- (void)changePasswordrspSUCCESS:(NSNotification *)sender {
    
    [AlertView alertViewWithText:@"修改密码成功" withVC:self];
}

/*
 * 修改密码失败
 */
- (void)changePasswordrspFAIL:(NSNotification *)sender {
    [AlertView alertViewWithText:@"修改密码失败！用户名密码验证失败!" withVC:self];
}

- (void)createView {
    
    NSArray  *titleArr = @[@"旧密码:",@"新密码:",@"确认密码:"];
    
    for (int i = 0; i < 3; i++) {
        UILabel  *lab = [UILabel new];
        lab.frame = CGRectMake(38, 198+i*45, 80, 16);
        lab.text = titleArr[i];
        lab.font = [UIFont systemFontOfSize:16];
        lab.textColor = [UIColor blackColor];
        lab.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:lab];
        
        
        UIImageView  *img = [UIImageView new];
        img.frame = CGRectMake(37, 221+i*45, kScreenWidth-74, 0.5);
        img.backgroundColor = RGB(194,194,194);
        [self.view addSubview:img];
        
        
    }
    
    
    _oldPswTF = [UITextField new];
    _oldPswTF.frame = CGRectMake(120, 198, kScreenWidth/2, 20);
//    _oldPswTF.backgroundColor = [UIColor redColor];
    [self.view addSubview:_oldPswTF];
    
    _newsPswTF = [UITextField new];
    _newsPswTF.frame = CGRectMake(120, 243, kScreenWidth/2, 20);
//    _newsPswTF.backgroundColor = [UIColor redColor];
    [self.view addSubview:_newsPswTF];
    
    _surePswTF = [UITextField new];
    _surePswTF.frame = CGRectMake(120, 288, kScreenWidth/2, 20);
//    _surePswTF.backgroundColor = [UIColor redColor];
    [self.view addSubview:_surePswTF];
    
    
    UIButton  *btn = [UIButton new];
    btn.frame = CGRectMake(37, 384, kScreenWidth-74, 50);
    btn.backgroundColor = RGB(227,74,80);
    btn.layer.cornerRadius = 5;
    btn.clipsToBounds = YES;
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)btnClick:(UIButton *)sender {
    
    if (self.oldPswTF.text.length >0 && self.newsPswTF.text.length > 0 ) {
        if ([self.newsPswTF.text isEqualToString:self.surePswTF.text]) {
            
            //发请求
            NSLog(@"发请求----发请求----发请求----");
            
            NSString  *account = [[NSUserDefaults standardUserDefaults] objectForKey:@"account"];
            
            [_manager requestForUniversalWithName:@"ChangePassword" WithOldPsw:_oldPswTF.text WithNewPsw:_newsPswTF.text WithAccount:account withTag:750];
            
            _oldPswTF.text = @"";
            _newsPswTF.text = @"";
            _surePswTF.text = @"";
            
        }else {
           [AlertView alertViewWithText:@"您输入的新密码和确认密码不一致" withVC:self];
        }
    }else {
        [AlertView alertViewWithText:@"请输入旧密码和新密码" withVC:self];
    }
    
}

#pragma mark  ---键盘控制
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.oldPswTF resignFirstResponder];
    [self.newsPswTF resignFirstResponder];
    [self.surePswTF resignFirstResponder];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changePasswordrspSUCCESS" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changePasswordrspFAIL" object:nil];
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
