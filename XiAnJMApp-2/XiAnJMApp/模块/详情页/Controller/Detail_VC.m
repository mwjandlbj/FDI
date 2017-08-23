//
//  Detail_VC.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/22.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "Detail_VC.h"
#import "Detail_Header_Cell.h"
#import "Detail_Pic_Cell.h"
//#import "Tabbar_view.h"
#import "Common.h"

#import "FundView.h"

#import "BargainView.h"
#import "InquireView.h"


#define WIDTH_Lab  ScreenWidth/5.0
#define HEIGHT_Lab  15
#define WIDTH_ImgV  35
#define HEIGHT_Tabbar 50



@interface Detail_VC ()
<
UITableViewDelegate,
UITableViewDataSource
>{
    
//    NSInteger   count;
    UIView      *fundBGView;//资金背景view
    UIView      *bargainBGView;//成交背景view
    UIView      *transactionBGView;//交易背景view
    UIView      *inquireBGView;//查询背景view
    UIView      *setBGView;//设置背景view
    
    NSInteger   fundCount;
    NSInteger   bargainCount;
    NSInteger   transactionCount;
    NSInteger   inquireCount;
    NSInteger   setCount;
}


/*
 * 资金
 */
@property(nonatomic,strong)UIButton    *btnFund;
@property(nonatomic,strong)UIImageView * imgV_Fund;
@property(nonatomic,strong)UILabel     * lab_Fund;

/*
 * 交易
 */
@property(nonatomic,strong)UIButton    *btnTransaction;
@property(nonatomic,strong)UIImageView * imgV_Transaction;
@property(nonatomic,strong)UILabel     * lab_Transaction;

/*
 * 成交
 */
@property(nonatomic,strong)UIButton    *btnBargain;
@property(nonatomic,strong)UIImageView * imgV_Bargain;
@property(nonatomic,strong)UILabel     * lab_Bargain;

/*
 * 查询
 */
@property(nonatomic,strong)UIButton    *btnInquire;
@property(nonatomic,strong)UIImageView * imgV_Inquire;
@property(nonatomic,strong)UILabel     * lab_Inquire;

/*
 * 设置
 */
@property(nonatomic,strong)UIButton    *btnSet;
@property(nonatomic,strong)UIImageView * imgV_Set;
@property(nonatomic,strong)UILabel     * lab_Set;




@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray*marr_Section;
@property(nonatomic, strong)NSMutableArray*marr_Data;

//@property (nonatomic,strong)Tabbar_view * view_tabbar;

@property (nonatomic,strong)UIView      * view_tabbar;

@end

@implementation Detail_VC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = RGB(30,36,46);
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];

    [self setProperty];
    [self createUI];
    [self Create_Marr_Section];
    
//    [self createUI];
    
//    count = 1;
    

    fundCount = 0;
    bargainCount = 0;
    transactionCount = 0;
    inquireCount = 0;
    setCount = 0;
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeForResult:) name:@"changeForResult" object:nil];
    
}

#pragma mark==================setProperty======================
-(void)setProperty{
    _marr_Data=[[NSMutableArray alloc]init];
    
//    self.view.backgroundColor = [UIColor blackColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        self.navigationController.navigationBar.clipsToBounds = NO;
    }
    _marr_Section=[[NSMutableArray alloc]init];
    
    
//    self.title=@"详情";//传值？？？
    
//    self.contractNameLabel = [[UILabel alloc] initWithFrame: CGRectMake(kScreenWidth/2+60, -30, 120, 30)];;
//    self.contractNameLabel.text = @"美原油07";
//    self.contractNameLabel.textAlignment = NSTextAlignmentCenter;
//    self.contractNameLabel.textColor = RGB(255,255,255);
//    self.contractNameLabel.font = [UIFont systemFontOfSize:14];
////    self.contractNameLabel.backgroundColor = [UIColor redColor];
////    self.navigationItem.titleView = self.contractNameLabel;
//    [self.navigationItem.titleView addSubview:self.contractNameLabel];
//
//    self.contractIDLabel = [[UILabel alloc] initWithFrame: CGRectMake(kScreenWidth/2+60, 0, 120, 30)];;
//    self.contractIDLabel.text = @"CLNNJEJ";
//    self.contractIDLabel.textAlignment = NSTextAlignmentCenter;
//    self.contractIDLabel.textColor = RGB(255,255,255);
//    self.contractIDLabel.font = [UIFont systemFontOfSize:14];
//    //    self.contractIDLabel.backgroundColor = [UIColor redColor];
////    self.navigationItem.titleView = self.contractIDLabel;
//    [self.navigationItem.titleView addSubview:self.contractIDLabel];
    
    
    UIView   *titleview = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2+60, -50, 120, 40)];
//    titleview.backgroundColor = [UIColor redColor];
    
    self.contractNameLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 120, 20)];;
//    self.contractNameLabel.text = @"美原油07";
    self.contractNameLabel.textAlignment = NSTextAlignmentCenter;
    self.contractNameLabel.textColor = RGB(255,255,255);
    self.contractNameLabel.font = [UIFont systemFontOfSize:15];
//        self.contractNameLabel.backgroundColor = [UIColor yellowColor];
    //    self.navigationItem.titleView = self.contractNameLabel;
    [titleview addSubview:self.contractNameLabel];

    self.contractIDLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 17, 120, 20)];;
//    self.contractIDLabel.text = @"CLNNJEJ";
    self.contractIDLabel.textAlignment = NSTextAlignmentCenter;
    self.contractIDLabel.textColor = RGB(255,255,255);
    self.contractIDLabel.font = [UIFont systemFontOfSize:15];
//    self.contractIDLabel.backgroundColor = [UIColor blueColor];
    //    self.navigationItem.titleView = self.contractNameLabel;
    [titleview addSubview:self.contractIDLabel];
    
    
    self.navigationItem.titleView = titleview;
    
    
//    self.navigationController.navigationBar.barTintColor = RGB(29,38,48);
    
    
}
-(void)createUI{
//    self.view.backgroundColor=RGB(30, 36, 46);
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
//    _tableView.isScrollEnabled;
//    _tableView.userInteractionEnabled = NO;
    _tableView.scrollEnabled = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-50);
    }];

    _view_tabbar=[[UIView alloc]init];
    _view_tabbar.backgroundColor = RGB(29,38,48);
    [self.view addSubview:_view_tabbar];
    [_view_tabbar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(50);
        
    }];
    
    
    
//    CGFloat centerY_ImgV=(HEIGHT_Tabbar-HEIGHT_Lab)/2.0;
    /*
     * 资金
     */
//    _lab_Fund=[[UILabel alloc]init];
//    _lab_Fund.text=@"资金";
//    _lab_Fund.textAlignment=NSTextAlignmentCenter;
//    _lab_Fund.textColor = RGB(222,224,227);
//    _lab_Fund.font = [UIFont systemFontOfSize:11];
//    [self.view_tabbar addSubview:_lab_Fund];
//    [_lab_Fund mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.bottom.equalTo(self.view_tabbar.mas_bottom).offset(-2);
//        make.left.equalTo(self.view_tabbar.mas_left).offset(0);
//        make.width.mas_equalTo(WIDTH_Lab);
//        make.height.mas_equalTo(HEIGHT_Lab);
//        
//    }];
//    
//    
//    _imgV_Fund=[[UIImageView alloc]init];
////    _imgV_Fund.backgroundColor=[UIColor  redColor];
//    _imgV_Fund.image=[UIImage imageNamed:@"zijin"];
//    
//    UITapGestureRecognizer *imgFundTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgFundClick)];
//    // 2. 将点击事件添加到label上
//    [_imgV_Fund addGestureRecognizer:imgFundTapGestureRecognizer];
//    _imgV_Fund.userInteractionEnabled = YES; // 可以理解为设置label可被点击
//    
//    
//    [self.view_tabbar addSubview:_imgV_Fund];
//    [_imgV_Fund mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.centerX.equalTo(self.view_tabbar.mas_left).offset(WIDTH_Lab/2.0);
//        make.centerY.equalTo(self.view_tabbar.mas_top).offset(centerY_ImgV);
//        make.width.mas_equalTo(WIDTH_ImgV);
//        make.height.mas_equalTo(WIDTH_ImgV);
//        
//    }];
    
    
    _btnFund = [UIButton new];
    _btnFund.frame = CGRectMake(0, 0, kScreenWidth/5, HEIGHT_Tabbar);
    [_btnFund addTarget:self action:@selector(btnFundClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view_tabbar addSubview:_btnFund];
    
    
    _imgV_Fund=[[UIImageView alloc]init];
//    _imgV_Fund.backgroundColor=[UIColor  yellowColor];
    _imgV_Fund.bounds = CGRectMake(0, 0, kScreenWidth*0.064, kScreenWidth*0.064);
    _imgV_Fund.center = CGPointMake(_btnFund.center.x*1.25, _btnFund.center.y/1.5);
    _imgV_Fund.image=[UIImage imageNamed:@"11110000"];
    [_btnFund addSubview:_imgV_Fund];
//    [_imgV_Fund mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view_tabbar).offset(5);
//        make.bottom.equalTo(self.view_tabbar).offset(-22);
//        make.left.equalTo(self.view_tabbar).offset(35);
//        make.right.equalTo(self.view_tabbar).offset(-316);
//    }];
    
    _lab_Fund=[[UILabel alloc]init];
    _lab_Fund.bounds = CGRectMake(0, 0, kScreenWidth*0.064, kScreenWidth*0.0347);
    _lab_Fund.center = CGPointMake(_btnFund.center.x*1.25, _btnFund.center.y*1.5);
    _lab_Fund.text=@"资金";
    _lab_Fund.textAlignment=NSTextAlignmentCenter;
    _lab_Fund.textColor = RGB(222,224,227);
    _lab_Fund.font = [UIFont systemFontOfSize:10];
//    _lab_Fund.backgroundColor = [UIColor blueColor];
    [_btnFund addSubview:_lab_Fund];
//    [_lab_Fund mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(self.view_tabbar).offset(33);
//        make.bottom.equalTo(self.view_tabbar).offset(-6);
//        make.left.equalTo(self.view_tabbar).offset(35);
//        make.right.equalTo(self.view_tabbar).offset(-316);
//    }];
    
    
    
    /*
     * 交易
     */
//    _lab_Bargain=[[UILabel alloc]init];
//    _lab_Bargain.text=@"成交";
//    _lab_Bargain.textAlignment=NSTextAlignmentCenter;
//    _lab_Bargain.textColor = RGB(222,224,227);
//    _lab_Bargain.font = [UIFont systemFontOfSize:12];
//    [self.view_tabbar addSubview:_lab_Bargain];
//    [_lab_Bargain mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.bottom.equalTo(self.view_tabbar.mas_bottom).offset(-2);
//        make.left.equalTo(_lab_Fund.mas_right).offset(0);
//        make.width.mas_equalTo(WIDTH_Lab);
//        make.height.mas_equalTo(HEIGHT_Lab);
//        
//    }];
//    
//    _imgV_Bargain=[[UIImageView alloc]init];
//    _imgV_Bargain.image=[UIImage imageNamed:@"chengjiao"];
////    _imgV_Bargain.backgroundColor = [UIColor redColor];
//    
//    UITapGestureRecognizer *imgBargainTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgBargainClick)];
//    // 2. 将点击事件添加到label上
//    [_imgV_Bargain addGestureRecognizer:imgBargainTapGestureRecognizer];
//    _imgV_Bargain.userInteractionEnabled = YES; // 可以理解为设置label可被点击
//    
//    
//    [self.view_tabbar addSubview:_imgV_Bargain];
//    [_imgV_Bargain mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view_tabbar.mas_left).offset(WIDTH_Lab/2.0+WIDTH_Lab);
//        make.centerY.equalTo(self.view_tabbar.mas_top).offset(centerY_ImgV);
//        make.width.mas_equalTo(WIDTH_ImgV);
//        make.height.mas_equalTo(WIDTH_ImgV);
//        
//    }];
    
    _btnTransaction = [UIButton new];
    _btnTransaction.frame = CGRectMake(kScreenWidth/5, 0, kScreenWidth/5, HEIGHT_Tabbar);
//    _btnTransaction.backgroundColor = [UIColor redColor];
    [_btnTransaction addTarget:self action:@selector(btnTransactionClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view_tabbar addSubview:_btnTransaction];
    
    
    _imgV_Transaction=[[UIImageView alloc]init];
//    _imgV_Transaction.backgroundColor=[UIColor  yellowColor];
    _imgV_Transaction.bounds = CGRectMake(0, 0, kScreenWidth*0.064, kScreenWidth*0.064);
    _imgV_Transaction.center = CGPointMake(_btnTransaction.center.x/2.5, _btnTransaction.center.y/1.5);
    _imgV_Transaction.image=[UIImage imageNamed:@"jiaoyi"];
    [_btnTransaction addSubview:_imgV_Transaction];
//    [_imgV_Transaction mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view_tabbar).offset(6);
//        make.bottom.equalTo(self.view_tabbar).offset(-22);
//        make.left.equalTo(self.view_tabbar).offset(105);
//        make.right.equalTo(self.view_tabbar).offset(-243);
//    }];
    
    _lab_Transaction=[[UILabel alloc]init];
    _lab_Transaction.bounds = CGRectMake(0, 0, kScreenWidth*0.064, kScreenWidth*0.0347);
    _lab_Transaction.center = CGPointMake(_btnTransaction.center.x/2.5, _btnTransaction.center.y*1.5);
    _lab_Transaction.text=@"交易";
    _lab_Transaction.textAlignment=NSTextAlignmentCenter;
    _lab_Transaction.textColor = RGB(222,224,227);
    _lab_Transaction.font = [UIFont systemFontOfSize:10];
    //    _lab_Fund.backgroundColor = [UIColor blueColor];
    [_btnTransaction addSubview:_lab_Transaction];
//    [_lab_Transaction mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(self.view_tabbar).offset(33);
//        make.bottom.equalTo(self.view_tabbar).offset(-6);
//        make.left.equalTo(self.view_tabbar).offset(105);
//        make.right.equalTo(self.view_tabbar).offset(-243);
//    }];
    
    
    
    /*
     * 成交
     */
//    _lab_Transaction=[[UILabel alloc]init];
//    _lab_Transaction.text=@"交易";
//    _lab_Transaction.textAlignment=NSTextAlignmentCenter;
//    _lab_Transaction.textColor = RGB(222,224,227);
//    _lab_Transaction.font = [UIFont systemFontOfSize:12];
//    [self.view_tabbar addSubview:_lab_Transaction];
//    [_lab_Transaction mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.bottom.equalTo(self.view_tabbar.mas_bottom).offset(-2);
//        make.left.equalTo(_lab_Bargain.mas_right).offset(0);
//        make.width.mas_equalTo(WIDTH_Lab);
//        make.height.mas_equalTo(HEIGHT_Lab);
//        
//    }];
//    
//    _imgV_Transaction=[[UIImageView alloc]init];
//    _imgV_Transaction.image=[UIImage imageNamed:@"jiaoyi"];
//    
//    UITapGestureRecognizer *imgTransactionTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTransactionClick)];
//    // 2. 将点击事件添加到label上
//    [_imgV_Transaction addGestureRecognizer:imgTransactionTapGestureRecognizer];
//    _imgV_Transaction.userInteractionEnabled = YES; // 可以理解为设置label可被点击
//    
//    
//    [self.view_tabbar addSubview:_imgV_Transaction];
//    [_imgV_Transaction mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view_tabbar.mas_left).offset(WIDTH_Lab/2.0+WIDTH_Lab*2);
//        make.centerY.equalTo(self.view_tabbar.mas_top).offset(centerY_ImgV);
//        make.width.mas_equalTo(WIDTH_ImgV);
//        make.height.mas_equalTo(WIDTH_ImgV);
//        
//    }];
    
    _btnBargain = [UIButton new];
    _btnBargain.frame = CGRectMake(kScreenWidth/5*2, 0, kScreenWidth/5, HEIGHT_Tabbar);
//    _btnBargain.backgroundColor = [UIColor redColor];
    [_btnBargain addTarget:self action:@selector(btnBargainClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view_tabbar addSubview:_btnBargain];
    
    
    _imgV_Bargain=[[UIImageView alloc]init];
//    _imgV_Bargain.backgroundColor=[UIColor  yellowColor];
    _imgV_Bargain.bounds = CGRectMake(0, 0, kScreenWidth*0.064, kScreenWidth*0.064);
    _imgV_Bargain.center = CGPointMake(_btnBargain.center.x/4.8, _btnBargain.center.y/1.5);
    _imgV_Bargain.image=[UIImage imageNamed:@"chengjiao"];
    [_btnBargain addSubview:_imgV_Bargain];
//    [_imgV_Bargain mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view_tabbar).offset(6);
//        make.bottom.equalTo(self.view_tabbar).offset(-22);
//        make.left.equalTo(self.view_tabbar).offset(177);
//        make.right.equalTo(self.view_tabbar).offset(-174);
//    }];
    
    _lab_Bargain=[[UILabel alloc]init];
    _lab_Bargain.bounds = CGRectMake(0, 0, kScreenWidth*0.064, kScreenWidth*0.0347);
    _lab_Bargain.center = CGPointMake(_btnBargain.center.x/4.8, _btnBargain.center.y*1.5);
    _lab_Bargain.text=@"成交";
    _lab_Bargain.textAlignment=NSTextAlignmentCenter;
    _lab_Bargain.textColor = RGB(222,224,227);
    _lab_Bargain.font = [UIFont systemFontOfSize:10];
    //    _lab_Fund.backgroundColor = [UIColor blueColor];
    [_btnBargain addSubview:_lab_Bargain];
//    [_lab_Bargain mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(self.view_tabbar).offset(33);
//        make.bottom.equalTo(self.view_tabbar).offset(-6);
//        make.left.equalTo(self.view_tabbar).offset(177);
//        make.right.equalTo(self.view_tabbar).offset(-174);
//    }];
    
    
    /*
     * 查询
     */
//    _lab_Inquire=[[UILabel alloc]init];
//    _lab_Inquire.text=@"查询";
//    _lab_Inquire.textAlignment=NSTextAlignmentCenter;
//    _lab_Inquire.textColor = RGB(222,224,227);
//    _lab_Inquire.font = [UIFont systemFontOfSize:12];
//    [self.view_tabbar addSubview:_lab_Inquire];
//    [_lab_Inquire mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.bottom.equalTo(self.view_tabbar.mas_bottom).offset(-2);
//        make.left.equalTo(_lab_Transaction.mas_right).offset(0);
//        make.width.mas_equalTo(WIDTH_Lab);
//        make.height.mas_equalTo(HEIGHT_Lab);
//        
//    }];
//    
//    _imgV_Inquire=[[UIImageView alloc]init];
//    _imgV_Inquire.image=[UIImage imageNamed:@"chaxun"];
//    
//    UITapGestureRecognizer *imgInquireTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgInquireClick)];
//    // 2. 将点击事件添加到label上
//    [_imgV_Inquire addGestureRecognizer:imgInquireTapGestureRecognizer];
//    _imgV_Inquire.userInteractionEnabled = YES; // 可以理解为设置label可被点击
//    
//    
//    [self.view_tabbar addSubview:_imgV_Inquire];
//    [_imgV_Inquire mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view_tabbar.mas_left).offset(WIDTH_Lab/2.0+WIDTH_Lab*3);
//        make.centerY.equalTo(self.view_tabbar.mas_top).offset(centerY_ImgV);
//        make.width.mas_equalTo(WIDTH_ImgV);
//        make.height.mas_equalTo(WIDTH_ImgV);
//        
//    }];
    
    _btnInquire = [UIButton new];
    _btnInquire.frame = CGRectMake(kScreenWidth/5*3, 0, kScreenWidth/5, HEIGHT_Tabbar);
    //    _btnFund.backgroundColor = [UIColor redColor];
    [_btnInquire addTarget:self action:@selector(btnInquireClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view_tabbar addSubview:_btnInquire];
    
    
    _imgV_Inquire=[[UIImageView alloc]init];
//    _imgV_Inquire.backgroundColor=[UIColor  yellowColor];
    _imgV_Inquire.bounds = CGRectMake(0, 0, kScreenWidth*0.064, kScreenWidth*0.064);
    _imgV_Inquire.center = CGPointMake(_btnInquire.center.x/7.6, _btnInquire.center.y/1.5);
    _imgV_Inquire.image=[UIImage imageNamed:@"chaxun"];
    [_btnInquire addSubview:_imgV_Inquire];
//    [_imgV_Inquire mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view_tabbar).offset(5);
//        make.bottom.equalTo(self.view_tabbar).offset(-22);
//        make.left.equalTo(self.view_tabbar).offset(247);
//        make.right.equalTo(self.view_tabbar).offset(-105);
//    }];
    
    _lab_Inquire=[[UILabel alloc]init];
    _lab_Inquire.bounds = CGRectMake(0, 0, kScreenWidth*0.064, kScreenWidth*0.0347);
    _lab_Inquire.center = CGPointMake(_btnInquire.center.x/7.6, _btnInquire.center.y*1.5);
    _lab_Inquire.text=@"查询";
    _lab_Inquire.textAlignment=NSTextAlignmentCenter;
    _lab_Inquire.textColor = RGB(222,224,227);
    _lab_Inquire.font = [UIFont systemFontOfSize:10];
    //    _lab_Fund.backgroundColor = [UIColor blueColor];
    [_btnInquire addSubview:_lab_Inquire];
//    [_lab_Inquire mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(self.view_tabbar).offset(33);
//        make.bottom.equalTo(self.view_tabbar).offset(-6);
//        make.left.equalTo(self.view_tabbar).offset(247);
//        make.right.equalTo(self.view_tabbar).offset(-105);
//    }];
    
    
    /*
     * 设置
     */
//    _lab_Set=[[UILabel alloc]init];
//    _lab_Set.text=@"设置";
//    _lab_Set.textAlignment=NSTextAlignmentCenter;
//    _lab_Set.textColor = RGB(222,224,227);
//    _lab_Set.font = [UIFont systemFontOfSize:12];
//    [self.view_tabbar addSubview:_lab_Set];
//    [_lab_Set mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.bottom.equalTo(self.view_tabbar.mas_bottom).offset(-2);
//        make.left.equalTo(_lab_Inquire.mas_right).offset(0);
//        make.width.mas_equalTo(WIDTH_Lab);
//        make.height.mas_equalTo(HEIGHT_Lab);
//        
//    }];
//    
//    _imgV_Set=[[UIImageView alloc]init];
//    _imgV_Set.image=[UIImage imageNamed:@"shezhi"];
//    
//    UITapGestureRecognizer *imgSetTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgSetClick)];
//    // 2. 将点击事件添加到label上
//    [_imgV_Set addGestureRecognizer:imgSetTapGestureRecognizer];
//    _imgV_Set.userInteractionEnabled = YES; // 可以理解为设置label可被点击
//    
//    
//    
//    [self.view_tabbar addSubview:_imgV_Set];
//    [_imgV_Set mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view_tabbar.mas_left).offset(WIDTH_Lab/2.0+WIDTH_Lab*4);
//        make.centerY.equalTo(self.view_tabbar.mas_top).offset(centerY_ImgV);
//        make.width.mas_equalTo(WIDTH_ImgV);
//        make.height.mas_equalTo(WIDTH_ImgV);
//        
//    }];
    _btnSet = [UIButton new];
    _btnSet.frame = CGRectMake(kScreenWidth/5*4, 0, kScreenWidth/5, HEIGHT_Tabbar);
    //    _btnFund.backgroundColor = [UIColor redColor];
    [_btnSet addTarget:self action:@selector(btnSetClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view_tabbar addSubview:_btnSet];
    
    
    _imgV_Set=[[UIImageView alloc]init];
//    _imgV_Set.backgroundColor=[UIColor  yellowColor];
    _imgV_Set.bounds = CGRectMake(0, 0, kScreenWidth*0.064, kScreenWidth*0.064);
    _imgV_Set.center = CGPointMake(_btnSet.center.x/11.6, _btnSet.center.y/1.5);
    _imgV_Set.image=[UIImage imageNamed:@"shezhi"];
    [_btnSet addSubview:_imgV_Set];
//    [_imgV_Set mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view_tabbar).offset(5);
//        make.bottom.equalTo(self.view_tabbar).offset(-22);
//        make.left.equalTo(self.view_tabbar).offset(317);
//        make.right.equalTo(self.view_tabbar).offset(-35);
//    }];
    
    _lab_Set=[[UILabel alloc]init];
    _lab_Set.bounds = CGRectMake(0, 0, kScreenWidth*0.064, kScreenWidth*0.0347);
    _lab_Set.center = CGPointMake(_btnSet.center.x/11.6, _btnSet.center.y*1.5);
    _lab_Set.text=@"设置";
    _lab_Set.textAlignment=NSTextAlignmentCenter;
    _lab_Set.textColor = RGB(222,224,227);
    _lab_Set.font = [UIFont systemFontOfSize:10];
    //    _lab_Fund.backgroundColor = [UIColor blueColor];
    [_btnSet addSubview:_lab_Set];
//    [_lab_Set mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(self.view_tabbar).offset(34);
//        make.bottom.equalTo(self.view_tabbar).offset(-6);
//        make.left.equalTo(self.view_tabbar).offset(317);
//        make.right.equalTo(self.view_tabbar).offset(-35);
//    }];
    
    
}

#pragma mark  --资金点击触发方法
- (void)btnFundClick {
    
    NSLog(@"资金点击触发方法");
    [bargainBGView removeFromSuperview];
    [transactionBGView removeFromSuperview];
    [inquireBGView removeFromSuperview];
    [setBGView removeFromSuperview];
    
    fundCount += 1;
    
    
    
    if (fundCount%2 == 1) {
        _imgV_Fund.image=[UIImage imageNamed:@"3333"];
        _imgV_Bargain.image=[UIImage imageNamed:@"chengjiao"];
        _imgV_Transaction.image=[UIImage imageNamed:@"jiaoyi"];
        _imgV_Inquire.image=[UIImage imageNamed:@"chaxun"];
        _imgV_Set.image=[UIImage imageNamed:@"shezhi"];
        
        bargainCount = 0;
        transactionCount = 0;
        inquireCount = 0;
        setCount = 0;
        
        
        FundView  *fundview = [[FundView alloc] initWithFrame:CGRectMake(4, kScreenHeight, kScreenWidth-8, kScreenHeight*0.487)];
        
        fundBGView = fundview;
    
        
        fundview.layer.cornerRadius = 5;
        fundview.layer.borderWidth = 2;
        fundview.layer.borderColor = [RGB(42,55,68) CGColor];
        
        [self.view addSubview:fundBGView];
        
        // 状态栏(statusbar)
        CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
        
        if (rectStatus.size.width > 375) {
            [UIView animateWithDuration:1 animations:^{
                fundview.bounds = CGRectMake(4, 0, kScreenWidth-8, kScreenWidth*0.863);
                fundview.center = CGPointMake(self.view.center.x, self.view.center.y+kScreenWidth*0.0747);
                
            } completion:^(BOOL finished) {
                
            }];
        }else {
    
        [UIView animateWithDuration:1 animations:^{
           fundview.bounds = CGRectMake(4, 0, kScreenWidth-8, kScreenWidth*0.863);
           fundview.center = CGPointMake(self.view.center.x, self.view.center.y+kScreenWidth*0.056);
        
          } completion:^(BOOL finished) {
        
        }];
            
        }
        
        [self.view bringSubviewToFront:self.view_tabbar];//把界面提高层级
        
    }else {
        
        _imgV_Fund.image=[UIImage imageNamed:@"zijin"];
        
//        [fodview removeFromSuperview];
        
        [UIView animateWithDuration:0.3 animations:^{
            fundBGView.frame = CGRectMake(2, kScreenHeight, kScreenWidth-4, kScreenWidth*0.867);
        } completion:^(BOOL finished) {
//            [fodview removeFromSuperview];
            [fundBGView removeFromSuperview];
            
            fundCount = 0;
        }];
        
    }
}

//#pragma mark  --资金点击触发方法
//- (void)btnffFundClick {
//    NSLog(@"资金点击触发方法");
//    [bargainBGView removeFromSuperview];
//    [transactionBGView removeFromSuperview];
//    [inquireBGView removeFromSuperview];
//    [setBGView removeFromSuperview];
//    
//    
//    fundCount += 1;
//    
//    if (fundCount%2 == 1) {
//        
//        
//        _imgV_Fund.image=[UIImage imageNamed:@"3333"];
//        _imgV_Bargain.image=[UIImage imageNamed:@"chengjiao"];
//        _imgV_Transaction.image=[UIImage imageNamed:@"jiaoyi"];
//        _imgV_Inquire.image=[UIImage imageNamed:@"chaxun"];
//        _imgV_Set.image=[UIImage imageNamed:@"shezhi"];
//        
//        bargainCount = 0;
//        transactionCount = 0;
//        inquireCount = 0;
//        setCount = 0;
//
//        
//        fundBGView = [UIView new];
//        fundBGView.frame = CGRectMake(4, kScreenHeight, kScreenWidth-8, kScreenHeight*0.487);
//        fundBGView.layer.cornerRadius = 5;
//        [self.view addSubview:fundBGView];
//        
//        [UIView animateWithDuration:1 animations:^{
//            fundBGView.bounds = CGRectMake(4, 0, kScreenWidth-8, kScreenHeight*0.487);
//            fundBGView.center = CGPointMake(self.view.center.x, self.view.center.y+kScreenWidth*0.056);
//            
//        } completion:^(BOOL finished) {
//
//        }];
//
//        fundBGView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
//        
//        [self.view bringSubviewToFront:self.view_tabbar];//把界面提高层级
//        
//    }else {
//        
//        
//        _imgV_Fund.image=[UIImage imageNamed:@"zijin"];
//        
//        
//        
//        [UIView animateWithDuration:0.3 animations:^{
//            fundBGView.frame = CGRectMake(2, kScreenHeight, kScreenWidth-4, kScreenHeight*0.487);
//        } completion:^(BOOL finished) {
//            [fundBGView removeFromSuperview];
//            
//            fundCount = 0;
//        }];
//    }
//    
//}

#pragma mark  --交易点击触发方法
- (void)btnTransactionClick {
    NSLog(@"交易点击触发方法");
    
    [fundBGView removeFromSuperview];
    [transactionBGView removeFromSuperview];
    [inquireBGView removeFromSuperview];
    [setBGView removeFromSuperview];
    
    bargainCount += 1;
    
    if (bargainCount%2 == 1) {
        
        _imgV_Transaction.image=[UIImage imageNamed:@"jiaoyi_1"];
        
        _imgV_Fund.image=[UIImage imageNamed:@"zijin"];
//        _imgV_Bargain.image=[UIImage imageNamed:@"chengjiao"];
        _imgV_Bargain.image=[UIImage imageNamed:@"chengjiao"];
        _imgV_Inquire.image=[UIImage imageNamed:@"chaxun"];
        _imgV_Set.image=[UIImage imageNamed:@"shezhi"];
        
        fundCount = 0;
        transactionCount = 0;
        inquireCount = 0;
        setCount = 0;
        
        bargainBGView = [UIView new];
        bargainBGView.frame = CGRectMake(2, self.view.frame.size.height, self.view.frame.size.width-4, self.view.frame.size.height/2);
        
        [UIView animateWithDuration:1 animations:^{
            bargainBGView.bounds = CGRectMake(0, 0, self.view.frame.size.width-4, self.view.frame.size.height/2);
            bargainBGView.center = CGPointMake(self.view.center.x, self.view.center.y+25);
            
        } completion:^(BOOL finished) {
            
        }];
        
        bargainBGView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        
        [self.view addSubview:bargainBGView];
        [self.view bringSubviewToFront:self.view_tabbar];//把界面提高层级
        
    }else {
        
        _imgV_Transaction.image=[UIImage imageNamed:@"jiaoyi"];
        
        [UIView animateWithDuration:0.3 animations:^{
            bargainBGView.frame = CGRectMake(2, self.view.frame.size.height, self.view.frame.size.width-4, self.view.frame.size.height/2);
        } completion:^(BOOL finished) {
            [bargainBGView removeFromSuperview];
            
            bargainCount = 0;
            
        }];
    }
}

#pragma mark  --成交点击触发方法
- (void)btnBargainClick {
    NSLog(@"成交点击触发方法");
    
    [fundBGView removeFromSuperview];
    [transactionBGView removeFromSuperview];
//    [bargainBGView removeFromSuperview];
    [inquireBGView removeFromSuperview];
    [setBGView removeFromSuperview];

    bargainCount += 1;
    
    if (bargainCount%2 == 1) {
        
        _imgV_Bargain.image=[UIImage imageNamed:@"chengjiao_1"];
        
        _imgV_Fund.image=[UIImage imageNamed:@"zijin"];
        _imgV_Transaction.image=[UIImage imageNamed:@"jiaoyi"];
//        _imgV_Transaction.image=[UIImage imageNamed:@"jiaoyi"];
        _imgV_Inquire.image=[UIImage imageNamed:@"chaxun"];
        _imgV_Set.image=[UIImage imageNamed:@"shezhi"];
        
        fundCount = 0;
//        bargainCount = 0;
        transactionCount = 0;
        inquireCount = 0;
        setCount = 0;
        
        BargainView  *bargainView = [[BargainView alloc] initWithFrame:CGRectMake(4, kScreenHeight, kScreenWidth-8, kScreenWidth*1.2213)];
        
        bargainBGView = bargainView;
        
//        transactionBGView = [UIView new];
//        transactionBGView.frame = CGRectMake(2, self.view.frame.size.height, self.view.frame.size.width-4, self.view.frame.size.height/2);
        
        bargainView.layer.cornerRadius = 5;
        bargainView.layer.borderWidth = 2;
        bargainView.layer.borderColor = [RGB(42,55,68) CGColor];
        
        // 状态栏(statusbar)
        CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
        
        if (rectStatus.size.width > 375) {
            [UIView animateWithDuration:1 animations:^{
                bargainView.bounds = CGRectMake(0, 0, self.view.frame.size.width-8, kScreenWidth*1.2213);
                bargainView.center = CGPointMake(self.view.center.x, self.view.center.y/1.123);
                
            } completion:^(BOOL finished) {
                
            }];
        }else {
        
        [UIView animateWithDuration:1 animations:^{
            bargainView.bounds = CGRectMake(0, 0, self.view.frame.size.width-8, kScreenWidth*1.2213);
            bargainView.center = CGPointMake(self.view.center.x, self.view.center.y/1.14);
            
        } completion:^(BOOL finished) {
            
        }];
            
        }
        
//        transactionBGView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        
        [self.view addSubview:bargainBGView];
        [self.view bringSubviewToFront:self.view_tabbar];//把界面提高层级
        
    }else {
        
        _imgV_Bargain.image=[UIImage imageNamed:@"chengjiao"];
        
        [UIView animateWithDuration:0.3 animations:^{
            bargainBGView.frame = CGRectMake(2, self.view.frame.size.height, self.view.frame.size.width-8, kScreenWidth*1.2213);
        } completion:^(BOOL finished) {
            [bargainBGView removeFromSuperview];
            
            bargainCount = 0;

        }];
    }
}


#pragma mark  --查询点击触发方法
- (void)btnInquireClick {
    NSLog(@"查询点击触发方法");
    
    [fundBGView removeFromSuperview];
    [bargainBGView removeFromSuperview];
    [transactionBGView removeFromSuperview];
    [setBGView removeFromSuperview];
    
    inquireCount += 1;
    
    if (inquireCount%2 == 1) {
        
        _imgV_Inquire.image=[UIImage imageNamed:@"chaxun_1"];
        
        _imgV_Fund.image=[UIImage imageNamed:@"zijin"];
        _imgV_Bargain.image=[UIImage imageNamed:@"chengjiao"];
        _imgV_Transaction.image=[UIImage imageNamed:@"jiaoyi"];
//        _imgV_Inquire.image=[UIImage imageNamed:@"chaxun"];
        _imgV_Set.image=[UIImage imageNamed:@"shezhi"];
        
        fundCount = 0;
        bargainCount = 0;
        transactionCount = 0;
        setCount = 0;
        
        InquireView  *inquireView = [[InquireView alloc] initWithFrame:CGRectMake(4, kScreenHeight, kScreenWidth-8, kScreenWidth*1.2213)];
        
        inquireBGView = inquireView;
        
        inquireView.layer.cornerRadius = 5;
        inquireView.layer.borderWidth = 2;
        inquireView.layer.borderColor = [RGB(42,55,68) CGColor];
        
        // 状态栏(statusbar)
        CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
        
        if (rectStatus.size.width > 375) {
            [UIView animateWithDuration:1 animations:^{
                inquireView.bounds = CGRectMake(0, 0, self.view.frame.size.width-8, kScreenWidth*1.2213);
                inquireView.center = CGPointMake(self.view.center.x, self.view.center.y/1.123);
                
            } completion:^(BOOL finished) {
                
            }];
            
        }else {
        [UIView animateWithDuration:1 animations:^{
            inquireView.bounds = CGRectMake(0, 0, self.view.frame.size.width-8, kScreenWidth*1.2213);
            inquireView.center = CGPointMake(self.view.center.x, self.view.center.y/1.14);
            
        } completion:^(BOOL finished) {
            
        }];
        }
        
        [self.view addSubview:inquireBGView];
        [self.view bringSubviewToFront:self.view_tabbar];//把界面提高层级
        
    }else {
        
        _imgV_Inquire.image=[UIImage imageNamed:@"chaxun"];
        
        [UIView animateWithDuration:0.3 animations:^{
            inquireBGView.frame = CGRectMake(2, self.view.frame.size.height, self.view.frame.size.width-8, kScreenWidth*1.2213);
        } completion:^(BOOL finished) {
            [inquireBGView removeFromSuperview];
            
            inquireCount = 0;
        }];
    }
}


#pragma mark  --设置点击触发方法
- (void)btnSetClick {
    NSLog(@"设置点击触发方法");
    [fundBGView removeFromSuperview];
    [bargainBGView removeFromSuperview];
    [transactionBGView removeFromSuperview];
    [inquireBGView removeFromSuperview];

    setCount += 1;
    
    if (setCount%2 == 1) {
        
        _imgV_Set.image=[UIImage imageNamed:@"shezhi_1"];
        
        _imgV_Fund.image=[UIImage imageNamed:@"zijin"];
        _imgV_Bargain.image=[UIImage imageNamed:@"chengjiao"];
        _imgV_Transaction.image=[UIImage imageNamed:@"jiaoyi"];
        _imgV_Inquire.image=[UIImage imageNamed:@"chaxun"];
//        _imgV_Set.image=[UIImage imageNamed:@"shezhi"];
        
        fundCount = 0;
        bargainCount = 0;
        transactionCount = 0;
        inquireCount = 0;
        
        setBGView = [UIView new];
        setBGView.frame = CGRectMake(2, self.view.frame.size.height, self.view.frame.size.width-4, self.view.frame.size.height/2);
        
        [UIView animateWithDuration:1 animations:^{
            setBGView.bounds = CGRectMake(0, 0, self.view.frame.size.width-4, self.view.frame.size.height/2);
            setBGView.center = CGPointMake(self.view.center.x, self.view.center.y+25);
            
        } completion:^(BOOL finished) {
            
        }];
        
        setBGView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        
        [self.view addSubview:setBGView];
        [self.view bringSubviewToFront:self.view_tabbar];//把界面提高层级
        
    }else {
        
        _imgV_Set.image=[UIImage imageNamed:@"shezhi"];
//        _imgV_Bargain.image=[UIImage imageNamed:@"chengjiao"];
//        _imgV_Transaction.image=[UIImage imageNamed:@"jiaoyi"];
//        _imgV_Inquire.image=[UIImage imageNamed:@"chaxun"];
//        _imgV_Set.image=[UIImage imageNamed:@"shezhi"];
        
        [UIView animateWithDuration:0.3 animations:^{
            setBGView.frame = CGRectMake(2, self.view.frame.size.height, self.view.frame.size.width-4, self.view.frame.size.height/2);
        } completion:^(BOOL finished) {
            [setBGView removeFromSuperview];
            
            setCount = 0;
            
        }];
    }
}



-(void)Create_Marr_Section{
    
    [_marr_Section removeAllObjects];
    
    
    
    CellModel* cell_model1 =[[CellModel alloc]init];
    cell_model1.reuseIdentifier = NSStringFromClass([Detail_Header_Cell class]);
    cell_model1.className=NSStringFromClass([Detail_Header_Cell class]);
    cell_model1.height = [Detail_Header_Cell computeHeight:nil];
    cell_model1.selectionStyle=UITableViewCellSelectionStyleNone;
    cell_model1.accessoryType=UITableViewCellAccessoryNone;
    
    
    
    /*
     * 传递参数
     */
    cell_model1.userInfo = nil;
    SectionModel *model0=[SectionModel sectionModelWithTitle:@"" cells:@[cell_model1]];
    model0.headerhHeight=0.0001;
    model0.footerHeight=0.0001;
    [_marr_Section addObject:model0];

    
    CellModel* cell_model2 =[[CellModel alloc]init];
    cell_model2.reuseIdentifier = NSStringFromClass([Detail_Pic_Cell class]);
    cell_model2.className=NSStringFromClass([Detail_Pic_Cell class]);
    cell_model2.height = [Detail_Pic_Cell computeHeight:nil];
    cell_model2.selectionStyle=UITableViewCellSelectionStyleNone;
    cell_model2.accessoryType=UITableViewCellAccessoryNone;
    
    /*
     * 传递参数
     */
    cell_model2.userInfo = nil;
    SectionModel *model1=[SectionModel sectionModelWithTitle:@"" cells:@[cell_model2]];
    model1.headerhHeight=0.0001;
    model1.footerHeight=0.0001;
    [_marr_Section addObject:model1];
    
    
    
    [_tableView reloadData];
    
}
#pragma mark tableView 代理相关
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _marr_Section.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    SectionModel *sm = _marr_Section[section];
    return sm.cells.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    SectionModel *sm = _marr_Section[section];
    return sm.headerhHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    SectionModel *sm = _marr_Section[section];
    return sm.footerHeight;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SectionModel *sm = _marr_Section[indexPath.section];
    CellModel *cm = sm.cells[indexPath.row];
    
    return cm.height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SectionModel *sm = _marr_Section[indexPath.section];
    CellModel *cm = sm.cells[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cm.reuseIdentifier];
    if (!cell) {
        cell = [[NSClassFromString(cm.className) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cm.reuseIdentifier];
    }
    cell.selectionStyle = cm.selectionStyle;
    
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}



- (void)changeForResult:(NSNotification*)sender {
  
    NSArray *results = (NSArray*)sender.object;
    
//    NSLog(@"通知改变--内容%@",results);
    
    NSDictionary  *dic = (NSDictionary *)sender.object;
    
    if (results.count == 23) {
        
        for (NSString  *str in [dic allKeys]) {
            
            if ([str isEqualToString:@"ContractID"]) {
                
                NSString  *abd = [dic valueForKey:@"ContractID"];
                
                if ([self.contractIDLabel.text isEqualToString:abd]) {
                    
                
                
                NSLog(@"开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----");
                    
                    NSLog(@"%@",NSThread.currentThread);
                    
//                    Detail_Header_Cell  *detailHeaderCell = [Detail_Header_Cell new];
                    
                    
                    
                    Detail_Header_Cell  *detailHeaderCell = [[Detail_Header_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([Detail_Header_Cell class])];
                    
                    
//                    detailHeaderCell.backgroundColor = RGB(30, 36, 46);
                    detailHeaderCell.lab_left_number1.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"NewestPrice"]];
                    
//                    [_tableView reloadData];
                    
//                    CellModel  *cellmodel = [CellModel new];
//                    cellmodel.title = [NSString stringWithFormat:@"%@",[dic valueForKey:@"NewestPrice"]];
                    
//                    [_tableView reloadSectionIndexTitles];
                    
                    NSLog(@"detailHeaderCell.lab_left_number1.text----------%@",detailHeaderCell.lab_left_number1.text);
                    
//                    [detailHeaderCell reloadInputViews];
                    
                    CellModel  *cell_model1 = [[CellModel alloc] init];
                    cell_model1.reuseIdentifier = NSStringFromClass([Detail_Header_Cell class]);
                    cell_model1.className=NSStringFromClass([Detail_Header_Cell class]);
                    cell_model1.userInfo = nil;
                    SectionModel *model0=[SectionModel sectionModelWithTitle:@"" cells:@[cell_model1]];
                    [_marr_Section addObject:model0];
                }
            }
        }
    }
    
    
    
    
    
    [_tableView reloadData];
}



- (void)dealloc{

    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"changeForResult" object:nil];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
















































