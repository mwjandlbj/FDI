//
//  InformationQueryVC.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/7/12.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "InformationQueryVC.h"

#import "Common.h"

#import "BillQueryVC.h"
#import "OutIntoGoldQueryVC.h"

@interface InformationQueryVC ()

@end

@implementation InformationQueryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGB(224,224,224);
    //导航栏设置黑色
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.title = @"信息查询";
    [self.navigationController.navigationBar setTitleTextAttributes:
  @{NSFontAttributeName:[UIFont systemFontOfSize:14],
    NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    [self createView];
}

- (void)createView {
    
    
    /*
     * 账单查询,出入金查询
     */
//    UIView  *view = [UIView new];
//    view.frame = CGRectMake(0, 94, kScreenWidth, kScreenWidth*0.237);
//    view.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:view];
//
//    
//    
//    
//    NSArray  *labArr = @[@"账单查询",@"出入金查询"];
//    
//    
//    for (int i = 0; i < 2; i++) {
//        UIButton  *btn = [UIButton new];
//        btn.frame = CGRectMake(0, i*view.frame.size.height/2, kScreenWidth, view.frame.size.height/2);
//        btn.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0f green:arc4random()%255/255.0f blue:arc4random()%255/255.0f alpha:1];
//        btn.tag = i;
//        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//        
//        
//        UIImageView  *img = [UIImageView new];
//        img.frame = CGRectMake(5, 9, 28, 28);
//        img.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0f green:arc4random()%255/255.0f blue:arc4random()%255/255.0f alpha:1];
//        img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
//        [btn addSubview:img];
//        
//        UILabel  *lab = [UILabel new];
//        lab.frame = CGRectMake(58, 15, 100, 16);
//        lab.textColor = RGB(29,38,48);
//        lab.textAlignment = NSTextAlignmentLeft;
//        lab.font = [UIFont systemFontOfSize:16];
//        lab.text = [NSString stringWithFormat:@"%@",labArr[i]];
//        [btn addSubview:lab];
//        
//        
//        
//        UIImageView  *image = [UIImageView new];
//        image.frame = CGRectMake(kScreenWidth-22, 17, 7, 11);
//        image.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0f green:arc4random()%255/255.0f blue:arc4random()%255/255.0f alpha:1];
//        image.image = [UIImage imageNamed:@""];
//        [btn addSubview:image];
//        
    
        
        
//        [view addSubview:btn];
//    }
//    
//    UIImageView  *lineImg = [UIImageView new];
//    lineImg.frame = CGRectMake(58, 44, kScreenWidth-58, 1);
//    lineImg.backgroundColor = RGB(204,204,204);
//    [view addSubview:lineImg];
    
    /*
     * 账单查询
     */
    UIView  *view = [UIView new];
    view.frame = CGRectMake(0, 94, kScreenWidth, kScreenWidth*0.237/2);
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    
    UIButton  *btn = [UIButton new];
    btn.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth*0.237/2);
//    btn.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0f green:arc4random()%255/255.0f blue:arc4random()%255/255.0f alpha:1];
    btn.backgroundColor = [UIColor whiteColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImageView  *img = [UIImageView new];
    img.frame = CGRectMake(5, 9, 28, 28);
    img.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0f green:arc4random()%255/255.0f blue:arc4random()%255/255.0f alpha:1];
    img.image = [UIImage imageNamed:@""];
    [btn addSubview:img];
    
    UILabel  *lab = [UILabel new];
    lab.frame = CGRectMake(58, 15, 100, 16);
    lab.textColor = RGB(29,38,48);
    lab.textAlignment = NSTextAlignmentLeft;
    lab.font = [UIFont systemFontOfSize:16];
    lab.text = @"账单查询";
    [btn addSubview:lab];
    
    
    
    UIImageView  *image = [UIImageView new];
    image.frame = CGRectMake(kScreenWidth-22, 17, 7, 11);
    image.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0f green:arc4random()%255/255.0f blue:arc4random()%255/255.0f alpha:1];
    image.image = [UIImage imageNamed:@""];
    [btn addSubview:image];
    
    
    
    
    [view addSubview:btn];
    
    
}

- (void)btnClick:(UIButton *)sender {
//    if (sender.tag == 0) {
//        NSLog(@"账单查询账单查询账单查询账单查询账单查询");
        BillQueryVC  *billVC = [BillQueryVC new];
        [self.navigationController pushViewController:billVC animated:YES];
//    }else {
////        NSLog(@"出入金查询出入金查询出入金查询出入金查询出入金查询");
//        OutIntoGoldQueryVC  *outIntoGoldVC = [OutIntoGoldQueryVC new];
//        [self.navigationController pushViewController:outIntoGoldVC animated:YES];
//    }
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
