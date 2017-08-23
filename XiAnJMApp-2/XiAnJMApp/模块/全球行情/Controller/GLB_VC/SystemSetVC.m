//
//  SystemSetVC.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/7/13.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "SystemSetVC.h"

#import "Common.h"

#import "ChangePswVC.h"

@interface SystemSetVC ()

@end

@implementation SystemSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGB(224,224,224);
    //导航栏设置黑色
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.title = @"系统设置";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:14],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self createView];
    
}

- (void)createView {
    
    UIView  *view = [UIView new];
    view.frame = CGRectMake(0, 94, kScreenWidth, 225);
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    NSArray  *titleArr = @[@"密码修改",@"下单声音",@"下单确认",@"撤单声音",@"撤单确认",];
    
    for (int i = 0; i < 5; i++) {
        UILabel  *lab = [UILabel new];
        lab.frame = CGRectMake(15, 15+i*45, 80, 16);
        lab.text = titleArr[i];
        lab.font = [UIFont systemFontOfSize:16];
        lab.textColor = [UIColor blackColor];
        lab.textAlignment = NSTextAlignmentLeft;
        [view addSubview:lab];
        
        UIImageView  *img = [UIImageView new];
        img.frame = CGRectMake(15, 44+i*45, kScreenWidth-15, 0.5);
        img.backgroundColor = RGB(204,204,204);
        [view addSubview:img];
        
        
        UISwitch  *swil = [UISwitch new];
        swil.frame = CGRectMake(kScreenWidth-67, 7+i*45, 52, 30);
//        swil.backgroundColor = [UIColor whiteColor];//背景颜色
//        swil.onTintColor = [UIColor greenColor];//ON一边的背景颜色
//        swil.tintColor = [UIColor redColor];//OFF一边的背景颜色
//        swil.thumbTintColor = [UIColor redColor];//滑块颜色
        [swil setOn:YES animated:YES];//
        swil.tag = i;
        [swil addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
        [view addSubview:swil];
        
        
        if (i == 0) {
            swil.hidden = YES;
            
            UIImageView  *image = [UIImageView new];
            image.frame = CGRectMake(kScreenWidth-22, 17, 7, 11);
            image.backgroundColor = [UIColor redColor];
            image.image = [UIImage imageNamed:@""];
            [view addSubview:image];
            
        }
    }
    
    
    UIButton  *btn = [UIButton new];
    btn.frame = CGRectMake(0, 0, kScreenWidth, 44);
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(changePswBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
}

#pragma mark  --swich 控制
- (void)valueChange:(UISwitch *)sender {
    
    UISwitch  *swi2 = (UISwitch *)sender;
    if (sender.tag == 1) {
        if (swi2.isOn) {
            NSLog(@"按钮 1 开---");
        }else {
            NSLog(@"按钮 1 关---");
        }
    }else if (sender.tag == 2){
        if (swi2.isOn) {
            NSLog(@"按钮 2 开---");
        }else {
            NSLog(@"按钮 2 关---");
        }
    }else if (sender.tag == 3){
        if (swi2.isOn) {
            NSLog(@"按钮 3 开---");
        }else {
            NSLog(@"按钮 3 关---");
        }
    }else if (sender.tag == 4){
        if (swi2.isOn) {
            NSLog(@"按钮 4 开---");
        }else {
            NSLog(@"按钮 4 关---");
        }
    }else {
        NSLog(@"无反应-------无反应-------无反应-------");
    }
    
}

#pragma mark  ---修改密码
- (void)changePswBtn:(UIButton *)sender {
//    NSLog(@"修改密码");
    ChangePswVC *changePswVC = [ChangePswVC new];
    [self.navigationController pushViewController:changePswVC animated:YES];
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
