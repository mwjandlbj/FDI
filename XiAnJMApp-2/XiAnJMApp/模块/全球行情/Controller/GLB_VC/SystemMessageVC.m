//
//  SystemMessageVC.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/7/13.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "SystemMessageVC.h"

#import "Common.h"

@interface SystemMessageVC ()

@end

@implementation SystemMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGB(224,224,224);
    //导航栏设置黑色
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.title = @"系统信息";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:14],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self createView];
}

- (void)createView {
    UIImageView *img = [UIImageView new];
    img.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-64);
    img.backgroundColor = [UIColor redColor];
    [self.view addSubview:img];
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
