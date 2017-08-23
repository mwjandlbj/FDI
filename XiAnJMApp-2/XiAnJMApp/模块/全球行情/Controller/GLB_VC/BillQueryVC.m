//
//  BillQueryVC.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/7/12.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "BillQueryVC.h"

#import "Common.h"
#import "GCDSocketManager.h"

#import "UIView+customView.h"


#import "MetaDataTool.h"


#import "BillQueryModel.h"
#import "BillQueryTableViewCell.h"


@interface BillQueryVC ()<UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray   *billQueryCloseoutBidArr;//账单查询--所有
    NSMutableArray   *billQueryCloseoutBidNeedArr;//账单查询--需要的
}

@property (nonatomic,strong)GCDSocketManager * manager;

@property(nonatomic,strong)UIView      *datePickerBGview;
@property(nonatomic,strong)UIDatePicker    *datePicker;//日期选择
@property(nonatomic,strong)UIButton  *dateBtn;

@property(nonatomic,strong)UITableView  *tableView;
@property (nonatomic,strong) NSMutableArray *tableViewTitles;

@end

@implementation BillQueryVC

-(NSArray *)tableViewTitles{
    if (!_tableViewTitles) {
        _tableViewTitles = @[ @"合约",@"手数",@"盈亏"].mutableCopy;
    }
    return _tableViewTitles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGB(224,224,224);
    //导航栏设置黑色
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.title = @"账单查询";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:14],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self createChooseDateView];
    [self createTableView];
    
    NSString  *account = [[NSUserDefaults standardUserDefaults] objectForKey:@"account"];
    
    _manager = [GCDSocketManager sharedSocketManager];
    [_manager requestForUniversalWithName:@"CloseOutBidListrsp" WithContent:account withTag:730];//账单查询
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeoutbidListrsp:) name:@"closeoutbidListrsp" object:nil];
    
    
//    NSString *str =  @"2017-07-18 16:30:31.65";
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss:SSS"];
////    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CH"]];
//    NSDate *date = [dateFormatter dateFromString:str];
////    NSTimeInterval  dis = [date timeIntervalSince1970];
////    NSString  *disstr =  [NSString stringWithFormat:@"%i", (int)dis];
//    NSLog(@"date-----%@",date);
    
    
//
//    NSString *str =  @"2017-07-18 16:30:31.65";
////    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
////    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss.SSS"];
////    NSDate *date11 = [dateFormatter dateFromString:str];
////    NSTimeInterval  dis = [date11 timeIntervalSince1970];
////    NSLog(@"date--%f",dis);
//    
//    NSLog(@"date--%ld",(long)[self returnDate:str]);
//    
//    NSString *str1 =  @"2017-07-18T06:30:31.65";
//    [MetaDataTool changeDateWithCompareDay:str1 WithCurrentDay:@"2017-07-18"];
    
}


- (NSInteger)returnDate:(NSString *)str {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss.SSS"];
    NSDate *date11 = [dateFormatter dateFromString:str];
    NSTimeInterval  dis = [date11 timeIntervalSince1970];
    return dis;
}

#pragma mark  ---通知--账单查询
- (void)closeoutbidListrsp:(NSNotification*)sender {
    
    NSArray      *array = (NSArray *)sender.object;
    NSLog(@"closeoutbidListrsp----------------------------------------%@",array);
    
    billQueryCloseoutBidArr = @[].mutableCopy;
    
    if (array.count > 0) {
        for (NSDictionary  *dic in array) {
            
            BillQueryModel  *model = [BillQueryModel dicInitWithDic:dic];
            
//            NSLog(@"date----%@",model.CloseTime);
            
            
            
            [billQueryCloseoutBidArr addObject:model];
        }
        
        NSLog(@"billQueryCloseoutBidArr----------------------------------------%@",billQueryCloseoutBidArr);
    }
    
//    [_tableView reloadData];
}

- (void)createChooseDateView {
    
    UIView  *dateBGView = [UIView new];
    dateBGView.frame = CGRectMake(0, 64, kScreenWidth, 71);
//    dateBGView.backgroundColor = [UIColor redColor];
    [self.view addSubview:dateBGView];
    
    UILabel  *lab = [UILabel new];
    lab.frame = CGRectMake(27, 31, 50, 12);
    lab.text = @"选择日期";
    lab.font = [UIFont systemFontOfSize:12];
    lab.textColor = RGB(29,38,48);
    lab.textAlignment = NSTextAlignmentCenter;
    [dateBGView addSubview:lab];
    
    _dateBtn = [UIButton new];
    _dateBtn.frame = CGRectMake(84, 20, kScreenWidth*0.573, 32);
    NSDate *select = [NSDate date]; // 获取当前的时间
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"yyyy-MM-dd"; // 设置时间和日期的格式
    NSString *date = [selectDateFormatter stringFromDate:select]; // 把date类型转为设置好格式的string类型
    [_dateBtn setTitle:date forState:UIControlStateNormal];
    [_dateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _dateBtn.layer.cornerRadius = 2;
    _dateBtn.clipsToBounds = YES;
    _dateBtn.layer.borderWidth = 1;
    _dateBtn.layer.borderColor = [RGB(122,132,148) CGColor ];
    [_dateBtn addTarget:self action:@selector(dateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [dateBGView addSubview:_dateBtn];
    
    
    UIButton  *queryBtn = [UIButton new];
    queryBtn.frame = CGRectMake(kScreenWidth-68, 20, 41, 32);
    queryBtn.layer.cornerRadius = 2;
    queryBtn.clipsToBounds = YES;
    queryBtn.layer.borderWidth = 1;
    queryBtn.layer.borderColor = [RGB(122,132,148) CGColor ];
    [queryBtn addTarget:self action:@selector(queryBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [dateBGView addSubview:queryBtn];
    
    UIImageView  *img = [UIImageView new];
    img.bounds = CGRectMake(0, 0, 20, 20);
    img.center = queryBtn.center;
    img.image = [UIImage imageNamed:@"icon1"];
    
    [dateBGView addSubview:img];
    
}

- (void)createTableView {
    
    _tableView = [UITableView new];
    _tableView.frame = CGRectMake(0, 135, kScreenWidth, kScreenHeight-135);
    _tableView.backgroundColor = RGB(224,224,224);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.rowHeight = 35.0f;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark  ---日期选择按钮
- (void)dateBtnClick:(UIButton *)sender {
    
    _datePickerBGview = [UIView new];
    _datePickerBGview.frame = CGRectMake(34, 0, kScreenWidth-68, kScreenWidth/1.5);
    _datePickerBGview.center = self.view.center;
    _datePickerBGview.layer.cornerRadius = 5;
    _datePickerBGview.clipsToBounds = YES;
    _datePickerBGview.backgroundColor = [UIColor whiteColor];
    
    UILabel   *label = [UILabel new];
    label.frame = CGRectMake(0, 0, kScreenWidth-68, 40);
    label.text = @"选择日期";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    label.backgroundColor = RGB(232,232,232);
    [_datePickerBGview addSubview:label];
    
    
    UIButton  *cancelBtn = [UIButton new];
    cancelBtn.frame = CGRectMake(23, (kScreenWidth/1.5)-50, ((kScreenWidth-68)/2)-35, 40);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:RGB(44,179,120) forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    cancelBtn.backgroundColor = [UIColor whiteColor];
    cancelBtn.layer.cornerRadius = 4;
    cancelBtn.clipsToBounds = YES;
    cancelBtn.layer.borderWidth = 0.5;
    cancelBtn.layer.borderColor = [RGB(44,179,120) CGColor];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_datePickerBGview addSubview:cancelBtn];
    
    
    UIButton  *sureBtn = [UIButton new];
    sureBtn.frame = CGRectMake(((kScreenWidth-68)/2)+11, (kScreenWidth/1.5)-50, ((kScreenWidth-68)/2)-35, 40);
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:RGB(227,74,80) forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    sureBtn.backgroundColor = [UIColor whiteColor];
    sureBtn.layer.cornerRadius = 4;
    sureBtn.clipsToBounds = YES;
    sureBtn.layer.borderWidth = 0.5;
    sureBtn.layer.borderColor = [RGB(227,74,80) CGColor];
    [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_datePickerBGview addSubview:sureBtn];
    
    _datePicker = [UIDatePicker new];
    _datePicker.frame = CGRectMake(-23, 40, kScreenWidth-8, (kScreenWidth/1.5)-90);
    _datePicker.backgroundColor = [UIColor whiteColor];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    
    _datePicker.date = [NSDate date];
    [_datePicker setLocale:[NSLocale localeWithLocaleIdentifier:@"zh-CN"]];
    
    [_datePicker addTarget:self action:@selector(oneDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged]; // 添加监听器
    
    //    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setDateFormat:@"yy-MM-dd"];
    
    [_datePickerBGview addSubview:_datePicker];
    
    [self.view addSubview:_datePickerBGview];
    
}

#pragma mark - 实现oneDatePicker的监听方法
- (void)oneDatePickerValueChanged:(UIDatePicker *) sender {
    
    NSDate *select = [sender date]; // 获取被选中的时间
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"yyyy-MM-dd"; // 设置时间和日期的格式
    NSString *date = [selectDateFormatter stringFromDate:select]; // 把date类型转为设置好格式的string类型
    
    [_dateBtn setTitle:date forState:UIControlStateNormal];
    
}

#pragma mark ---取消选择日期
- (void)cancelBtnClick:(UIButton *)sender {
    
    NSDate *select = [NSDate date]; // 获取当前的时间
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"yyyy-MM-dd"; // 设置时间和日期的格式
    NSString *date = [selectDateFormatter stringFromDate:select]; // 把date类型转为设置好格式的string类型
    [_dateBtn setTitle:date forState:UIControlStateNormal];
    
    [_datePickerBGview removeFromSuperview];//移除日期选择
}

#pragma mark ---确定选择日期
- (void)sureBtnClick:(UIButton *)sender {
    [_datePickerBGview removeFromSuperview];//移除日期选择
}

#pragma mark  ---日期查询按钮
- (void)queryBtnClick:(UIButton *)sender {
    
//    NSLog(@"date----%@",_dateBtn.titleLabel.text);
    
    billQueryCloseoutBidNeedArr = @[].mutableCopy;
    if (billQueryCloseoutBidArr.count>0) {
        for (BillQueryModel  *model in billQueryCloseoutBidArr) {
            BillQueryModel  *modell = model;
            
            NSLog(@"date----%@",modell.CloseTime);
            
            if ([MetaDataTool changeDateWithCompareDay:modell.CloseTime WithCurrentDay:_dateBtn.titleLabel.text] == YES) {
                [billQueryCloseoutBidNeedArr addObject:model];
            }
            
        }
        
        [_tableView reloadData];
    }
    
}

#pragma mark  ---delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    BillQueryTableViewCell *cell = [BillQueryTableViewCell cellWithTableView:tableView WithNumberOfLabels:self.tableViewTitles.count];
    if (billQueryCloseoutBidNeedArr.count>0) { 
         cell.model = billQueryCloseoutBidNeedArr[indexPath.row];
      }

    
    return cell;
}

#pragma mark -- 设置table View的自定义头部View
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *rightHeaderView = [UIView viewWithLabelNumber:self.tableViewTitles.count];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/3, 35)];
    for (int i = 0; i < self.tableViewTitles.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/3 * i, 0, kScreenWidth/3, 35)];
        
        label.numberOfLines = 0;
        label.tag = i;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = RGB(29,38,48);
        label.font = [UIFont systemFontOfSize:12];
        //        label.backgroundColor = [UIColor clearColor];
        label.text = self.tableViewTitles[i];//
        
        label.layer.borderWidth = 1;
        label.layer.borderColor = [RGB(73,84,102) CGColor];
        
        
        [view addSubview:label];
        
    }

    
    view.backgroundColor = RGB(224,224,224);
    return view;
}

//必须实现以下方法才可以使用自定义头部
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}

//设置cell分割线顶格
- (void)resetSeparatorInsetForCell:(UITableViewCell *)cell {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 20;
    if (billQueryCloseoutBidNeedArr.count > 0) {
        return billQueryCloseoutBidNeedArr.count;
    }else {
        return 0;
    }
}


#pragma mark  ---dealloc
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"closeoutbidListrsp" object:nil];
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
