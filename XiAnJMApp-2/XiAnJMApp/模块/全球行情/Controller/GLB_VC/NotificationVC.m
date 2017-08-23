//
//  NotificationVC.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/7/13.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "NotificationVC.h"

#import "Common.h"

#import "GCDSocketManager.h"

#import "NotificationModel.h"
#import "NotificationView.h"

@interface NotificationVC ()<UITableViewDataSource,UITableViewDelegate> {
    
    UITableView      *myTableView;
    NSMutableArray   *notificationArr;//通知通告--所有
    
    
    UIView           *detialView;
    
    UILabel          *titleLab;
    UILabel          *contentLab;
    UILabel          *dateLab;
}

@property (nonatomic,strong)GCDSocketManager * manager;

@end

@implementation NotificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGB(224,224,224);
    //导航栏设置黑色
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.title = @"通知通告";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:14],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    _manager = [GCDSocketManager sharedSocketManager];
    [_manager requestForUniversalWithName:@"NewsMessageList" WithContent:@"1" withTag:740];//账单查询
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newsMessageListrsp:) name:@"newsMessageListrsp" object:nil];
    
    myTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:myTableView];
    
    myTableView.delegate = self;
    myTableView.dataSource = self;
    
}

#pragma mark ---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return notificationArr.count;
}

#pragma mark ---
- (UITableViewCell  *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NotificationView   *oldView = [cell viewWithTag:VIEWTAG];
    [oldView removeFromSuperview];
    
    NotificationView  *view = [[NotificationView alloc] initWithPeople:notificationArr[indexPath.row]];
    [cell addSubview:view];
    
    return cell;
}

#pragma mark----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self creatDetailView];
    
    
    NotificationModel  *mol = notificationArr[indexPath.row];
//    NSLog(@"%@",mol.Title);
    
    titleLab.text = mol.Title;
    contentLab.text = mol.Content;
    dateLab.text = mol.CreateDate;
    
    
    CGSize  msgSize = [contentLab.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width-58, 1000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} context:nil].size;
    
    
    contentLab.frame = CGRectMake(12, 98, msgSize.width, msgSize.height);
    
}

- (void)creatDetailView {
    
    detialView = [UIView new];
    detialView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight);
    detialView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:detialView];
    
    
    UIView  *view = [UIView new];
    view.bounds = CGRectMake(0, 0, kScreenWidth-34, kScreenWidth*0.744);
    view.center = CGPointMake(self.view.center.x, self.view.center.y*0.8);
    view.layer.cornerRadius = 5;
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor whiteColor];
    [detialView addSubview:view];
    
    UIView  *topView = [UIView new];
    topView.frame = CGRectMake(0, 0, kScreenWidth-34, 41);
    topView.backgroundColor = RGB(47,59,73);
    [view addSubview:topView];
    
    UIImageView  *img = [UIImageView new];
    img.frame = topView.frame;
    img.image = [UIImage imageNamed:@"dianjit"];
    [view addSubview:img];
    
    UIButton  *closeBtn = [UIButton new];
    closeBtn.frame = CGRectMake(topView.frame.size.width-50, 5, 40, 30);
    closeBtn.backgroundColor = [UIColor clearColor];
    [closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:closeBtn];
    
    titleLab = [UILabel new];
    titleLab.frame = CGRectMake(55, 55, view.frame.size.width-110, 14);
    titleLab.textColor = RGB(51,51,51);
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:13];
    [view addSubview:titleLab];
    
    UIImageView  *image = [UIImageView new];
    image.frame = CGRectMake(0, 82, view.frame.size.width, 0.5);
    image.backgroundColor = RGB(77,95,117);
    [view addSubview:image];
    
    
    
    
    
    contentLab = [UILabel new];
    contentLab.frame = CGRectMake(12, 80, view.frame.size.width-24, 140);
    contentLab.textColor = RGB(68,68,68);
    contentLab.font = [UIFont systemFontOfSize:11];
    contentLab.numberOfLines = 0;
    [view addSubview:contentLab];
    
    
    
    dateLab = [UILabel new];
    dateLab.frame = CGRectMake(view.frame.size.width-83, 256, 70, 8);
    dateLab.textColor = RGB(153,153,153);
    dateLab.textAlignment = NSTextAlignmentRight;
    dateLab.font = [UIFont systemFontOfSize:9];
    [view addSubview:dateLab];
    
    
    
}

- (void)closeBtnClick:(UIButton *)sender {
    
    [detialView removeFromSuperview];
}

#pragma mark  ---通知--成交纪录
- (void)newsMessageListrsp:(NSNotification*)sender {
    
    NSArray      *array = (NSArray *)sender.object;
    NSLog(@"newsMessageListrsp----------------------------------------%@",array);
    
//    NSLog(@"%lu",(unsigned long)array.count);
    
    notificationArr = @[].mutableCopy;
    
    if (array.count >0) {
        
        for (NSDictionary  *dic in array) {
//            NSString  *content = [NSString stringWithFormat:@"%@",dic[@"Content"]];;
            
//            NSLog(@"%@",content);
            NotificationModel  *model = [NotificationModel dicInitWithDic:dic];
            
            
            [notificationArr addObject:model];
        }
        
        [myTableView reloadData];
    }
}
#pragma mark  ---dealloc
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"newsMessageListrsp" object:nil];
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
