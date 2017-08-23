//
//  DetailVC.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/6/27.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "DetailVC.h"

#import "AlertView.h"

#import "DetailTopView.h"
#import "DetailMiddleView.h"
#import "UIView+customView.h"
#import "BargainRightTableViewCell.h"

#import "GCDSocketManager.h"

#import "Common.h"

#import "MetaDataTool.h"

#import "FundView.h"


#import "WaitBidReportrspModel.h"
#import "WaitBidReportrspTableViewCell.h"
#import "TransactionPresetBidListrspModel.h"
#import "TransactionPresetBidListrspTableViewCell.h"
#import "TransactionLimitBidListrspModel.h"
#import "TransactionLimitBidListrspTableViewCell.h"
#import "TransactionBidListrspModel.h"
#import "TransactionBidListrspTableViewCell.h"
#import "StopLossAndWinModel.h"
#import "StopLossAndWinTableViewCell.h"

#import "BargainView.h"

#import "BargainCloseOutBidListrspModel.h"


#import "InquireView.h"
#import "BidListrspModel.h"
#import "InquireBidListrspTableViewCell.h"
#import "PresetBidListrspModel.h"
#import "InquirePresetBidListrspTableViewCell.h"
#import "LimitBidListrspModel.h"
#import "InquireLimitBidListrspTableViewCell.h"
#import "CloseoutBidListrspModel.h"
#import "InquireCloseoutBidListrspTableViewCell.h"


#import "LMJDropdownMenu.h"


#define WIDTH_Lab  ScreenWidth/5.0
//#define HEIGHT_Lab  15
//#define WIDTH_ImgV  35
#define HEIGHT_Tabbar 50

#define BargainLeftTableViewWidth 85
#define BargainRightLabelWidth 85


@interface DetailVC ()<UITableViewDelegate,UITableViewDataSource,LMJDropdownMenuDelegate> {
    
    
    NSMutableArray     *chooseByMyselfIDArray;//自选合约数组
    
    NSArray     *contractIDarr;//所有合约id
    NSArray     *contractNamearr;//所有合约名称
    
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
    
//    NSDate      * date;
    
    NSInteger   selectCount;//纪录选择的表
    NSInteger   addContractCount;// 加自选按钮计数
    
    /*
     * 交易 ---
     */
    
    
    LMJDropdownMenu  *dropdownMenu;//合约选择列表
    
    NSString         *pingcangDirection;//平仓方向
    
    NSMutableArray   *waitBidArr;//交易--持仓合计
    NSMutableArray   *transactionPresetBidArr;//交易--限价委托
    NSMutableArray   *transactionLimitBidArr;//交易--止损止盈
    NSMutableArray   *transactionBidArr;//交易--交易明细
    
    UITableView      *stopLossTV;//交易--止损止盈-表
    UIView           *stopLossBGView;//交易--止损止盈界面
    UILabel          *contractLable;//交易--止损止盈-合约名称
    UILabel          *directionLable;//交易--止损止盈-合约方向
    UITextField      *lotTextField;//交易--止损止盈-手数
    UIImageView      *stopLossImg;//交易--止损止盈-止损图片
    UITextField      *stopLossTF;//交易--止损止盈-止损-tf
    UIImageView      *stopWinImg;//交易--止损止盈-止盈图片
    UITextField      *stopWinTF;//交易--止损止盈-止盈-tf
    
    NSMutableArray   *stopLossArr;//交易---止损止盈-持仓合计
    NSInteger        count1;//止损
    NSInteger        count2;//止盈
    
    /*
     * 查询 ---
     */
    NSMutableArray   *inquireBidDateArr;//交易明细-按日期
    NSMutableArray   *inquireBidArr;//交易明细--所有
    
    NSMutableArray   *inquirePresetBidDateArr;//委托记录-按日期
    NSMutableArray   *inquirePresetBidArr;//委托记录--所有
    
    NSMutableArray   *inquireLimitBidDateArr;//止损止盈-按日期
    NSMutableArray   *inquireLimitBidArr;//止损止盈--所有
    
    NSMutableArray   *inquireCloseoutBidDateArr;//成交纪录-按日期
    NSMutableArray   *inquireCloseoutBidArr;//成交纪录--所有
}



@property (nonatomic,strong)UIView      * view_tabbar;//


@property (nonatomic,strong)DetailTopView  *detailTView;

@property (nonatomic,strong)UIButton  *addContract;//加自选

@property (nonatomic,strong)GCDSocketManager * manager;

@property (nonatomic,strong)FundView  *fundView;

@property (nonatomic,strong)NSMutableArray  *closeoutbidListrspArr;


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

@property(nonatomic,strong)UIButton    *buyIn;//买入
@property(nonatomic,strong)UIButton    *sellOut;//卖出
@property(nonatomic,strong)UIButton    *balance;//平仓


@property(nonatomic,strong)UITextField  *lotTF;//手数
@property(nonatomic,strong)UILabel      *typeLabel;//类型
@property(nonatomic,strong)UITextField  *typeTFCount;//类型价格

@property(nonatomic,strong)UIButton     *stopLossButten;//止损止盈界面按钮

@property(nonatomic,strong)UILabel      *useFundLab;//可用资金
@property(nonatomic,strong)UILabel      *quanyiLab;//动态权益
@property(nonatomic,strong)UILabel      *yingkuiLab;//持仓盈亏


@property(nonatomic,strong)UIButton     *sumBtn;//持仓合计
@property(nonatomic,strong)UIButton     *delegateBtn;//限价委托
@property(nonatomic,strong)UIButton     *stopLossBtn;//止损止盈
@property(nonatomic,strong)UIButton     *transactionClearBtn;//交易明细

@property(nonatomic,strong)UITableView  *transactionTV;//交易--表
@property(nonatomic,strong)UIScrollView *transactionScrollview;//


@property (nonatomic,strong)NSArray     *transactionTitlesForSum;
@property (nonatomic,strong)NSArray     *transactionTitlesForDelegate;
@property (nonatomic,strong)NSArray     *transactionTitlesForStopLoss;
@property (nonatomic,strong)NSArray     *transactionTitlesForBargain;


/*
 * 成交
 */
@property(nonatomic,strong)UIButton    *btnBargain;
@property(nonatomic,strong)UIImageView * imgV_Bargain;
@property(nonatomic,strong)UILabel     * lab_Bargain;

@property(nonatomic,strong)BargainView     *bargainView;

//@property (nonatomic,strong) UITableView *bargainTV_left;
@property (nonatomic,strong) UITableView *bargainTV_right;
@property (nonatomic,strong) UIScrollView *bargainScrollView; 
@property (nonatomic,strong) NSArray     *bargainTitles;


/*
 * 查询
 */
@property(nonatomic,strong)UIButton    *btnInquire;
@property(nonatomic,strong)UIImageView * imgV_Inquire;
@property(nonatomic,strong)UILabel     * lab_Inquire;

@property(nonatomic,strong)UIButton    *detailBtnInquire;//交易明细
@property(nonatomic,strong)UIButton    *entrustBtnInquire;//委托记录
@property(nonatomic,strong)UIButton    *profitBtnInquire;//止损止盈
@property(nonatomic,strong)UIButton    *bargainBtnInquire;//成交纪录

@property(nonatomic,strong)UIView      *datePickerBGview;
@property(nonatomic,strong)UIDatePicker    *datePicker;//日期选择
@property(nonatomic,strong)UIButton    *dateBtn;


@property (nonatomic,strong) UITableView *inquireTV_right;
@property (nonatomic,strong) UIScrollView *inquireScrollView;
@property (nonatomic,strong) NSArray     *inquireTitlesForDetail;
@property (nonatomic,strong) NSArray     *inquireTitlesForEntrust;
@property (nonatomic,strong) NSArray     *inquireTitlesForProfit;
@property (nonatomic,strong) NSArray     *inquireTitlesForBargain;

/*
 * 设置
 */
@property(nonatomic,strong)UIButton    *btnSet;
@property(nonatomic,strong)UIImageView * imgV_Set;
@property(nonatomic,strong)UILabel     * lab_Set;

@property(nonatomic,strong)UIButton    *kLineBtn;//K线
@property(nonatomic,strong)UIButton    *timeDivisionBtn;//分时

@property(nonatomic,strong)UIButton    *threeMinuteBtn;//3分钟
@property(nonatomic,strong)UIButton    *fiveMinuteBtn;//5分钟
@property(nonatomic,strong)UIButton    *tenMinuteBtn;//10分钟

@property(nonatomic,strong)UIButton    *MACD_Btn;//MACD
@property(nonatomic,strong)UIButton    *KDJ_Btn;//KDJ
@property(nonatomic,strong)UIButton    *VOL_Btn;//VOL


@end

@implementation DetailVC

#pragma mark   ---成交---表头
-(NSArray *)bargainTitles{
    if (!_bargainTitles) {
        _bargainTitles = @[ @"合约",@"方向",@"手数", @"开仓价", @"平仓价", @"平仓盈亏", @"手续费", @"成交时间", @"编号",];
    }
    return _bargainTitles;
}

#pragma mark  ---查询 --
-(NSArray *)inquireTitlesForDetail{
    if (!_inquireTitlesForDetail) {
        _inquireTitlesForDetail = @[ @"编号",@"合约",@"方向",@"开平", @"手数", @"价格", @"成交类型", @"成交时间"];
    }
    return _inquireTitlesForDetail;
}
-(NSArray *)inquireTitlesForEntrust{
    if (!_inquireTitlesForEntrust) {
        _inquireTitlesForEntrust = @[ @"编号",@"合约",@"方向", @"委托手数", @"委托价格", @"委托状态", @"结果", @"创建时间", @"处理时间", @"对应单号"];
    }
    return _inquireTitlesForEntrust;
}
-(NSArray *)inquireTitlesForProfit{
    if (!_inquireTitlesForProfit) {
        _inquireTitlesForProfit = @[ @"编号",@"合约",@"方向", @"委托手数", @"类型", @"止损价格", @"止盈价格", @"状态", @"结果", @"创建时间", @"处理时间", @"对应单号"];
    }
    return _inquireTitlesForProfit;
}
-(NSArray *)inquireTitlesForBargain{
    if (!_inquireTitlesForBargain) {
        _inquireTitlesForBargain = @[ @"编号",@"合约",@"方向", @"手数", @"开仓价", @"平仓价", @"平仓盈亏", @"手续费", @"成交时间"];
    }
    return _inquireTitlesForBargain;
}

#pragma mark  --交易 ---
-(NSArray *)transactionTitlesForSum{
    if (!_transactionTitlesForSum) {
        _transactionTitlesForSum = @[@"合约",@"方向",@"手数",@"均价",@"盈亏"];
    }
    return _transactionTitlesForSum;
}
-(NSArray *)transactionTitlesForDelegate{
    if (!_transactionTitlesForDelegate) {
        _transactionTitlesForDelegate = @[ @"合约",@"方向", @"手数", @"价格", @"状态(挂单)", @"时间",@"编号"];
    }
    return _transactionTitlesForDelegate;
}
-(NSArray *)transactionTitlesForStopLoss{
    if (!_transactionTitlesForStopLoss) {
        _transactionTitlesForStopLoss = @[@"合约",@"方向", @"手数", @"止损价格", @"止盈价格", @"状态(挂单)", @"时间", @"编号",];
    }
    return _transactionTitlesForStopLoss;
}
-(NSArray *)transactionTitlesForBargain{
    if (!_transactionTitlesForBargain) {
        _transactionTitlesForBargain = @[ @"合约",@"方向", @"手数", @"价格", @"成交类型", @"成交时间",@"编号",];
    }
    return _transactionTitlesForBargain;
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = RGB(30,36,46);
    
    self.view.backgroundColor = RGB(24,26,30);
    
    _addContract = [UIButton new];
    _addContract.frame = CGRectMake(kScreenWidth*0.016, kScreenWidth*0.165, kScreenWidth*0.32, kScreenWidth*0.072);
    _addContract.backgroundColor = [UIColor clearColor];
    _addContract.titleLabel.font = [UIFont systemFontOfSize:13];
    [_addContract setTitle:@"添加自选" forState:UIControlStateNormal];
    [_addContract setTitleColor:RGB(227,74,80) forState:UIControlStateNormal];
    [_addContract addTarget:self action:@selector(addContractClick:) forControlEvents:UIControlEventTouchUpInside];
    [_detailTView addSubview:_addContract];
    
    
    chooseByMyselfIDArray = @[].mutableCopy;
    
    
    NSArray  *arr1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"chooseByMyselfIDArr"];
    [chooseByMyselfIDArray addObjectsFromArray:arr1];
    
    NSLog(@"self.contractIDLabel.text---%@chooseByMyselfIDArray.count---%ld",self.contractIDLabel.text,chooseByMyselfIDArray.count);
    
    
    for (int i = 0; i < chooseByMyselfIDArray.count; i++) {
        
        if ([self.contractIDLabel.text isEqualToString:chooseByMyselfIDArray[i]]) {
            addContractCount = 1;
            [_addContract setTitle:@"删除自选" forState:UIControlStateNormal];
        }
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.lotTF resignFirstResponder];
    [self.typeTFCount resignFirstResponder];
    [lotTextField resignFirstResponder];
    [stopLossTF resignFirstResponder];
    [stopWinTF resignFirstResponder];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    selectCount = 0;
    
    addContractCount = 0;
    
    [self setNavigationBar];
    
    [self createTopView];
    
    [self createMiddleView];
    
    [self setTabbar];
    
    
    _manager = [GCDSocketManager sharedSocketManager];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeForResult:) name:@"changeForResult" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accountInfoReportrsp:) name:@"accountInfoReportrsp" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bidListrsp:) name:@"bidListrsp" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presetBidListrsp:) name:@"presetBidListrsp" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(limitBidListrsp:) name:@"limitBidListrsp" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeoutbidListrsp:) name:@"closeoutbidListrsp" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(waitBidReportrsp:) name:@"waitBidReportrsp" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presetBidAddrspSUCCESS:) name:@"presetBidAddrspSUCCESS" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bidTraderspSUCCESS:) name:@"bidTraderspSUCCESS" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bidTraderspFAIL:) name:@"bidTraderspFAIL" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(limitBidAddrspFAIL:) name:@"limitBidAddrspFAIL" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(limitBidAddrspSUCCESS:) name:@"limitBidAddrspSUCCESS" object:nil];
    
    //合约名称 和id
    //[[NSUserDefaults standardUserDefaults] setObject:self.contractIDArray forKey:@"contractID"];
    //[[NSUserDefaults standardUserDefaults] setObject:self.contractNameArray forKey:@"contractName"];
    
    contractIDarr =  [[NSUserDefaults standardUserDefaults] objectForKey:@"contractID"];
    contractNamearr =  [[NSUserDefaults standardUserDefaults] objectForKey:@"contractName"];
    
    NSLog(@"contractIDarr---%@contractNamearr---%@",contractIDarr,contractNamearr);
}

#pragma mark  ---导航栏
- (void)setNavigationBar {
    
    UIView   *titleview = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2+60, -50, 120, 40)];
    self.contractNameLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 120, 20)];;
    //    self.contractNameLabel.text = @"美原油07";
    self.contractNameLabel.textAlignment = NSTextAlignmentCenter;
    self.contractNameLabel.textColor = RGB(255,255,255);
    self.contractNameLabel.font = [UIFont systemFontOfSize:15];
    //        self.contractNameLabel.backgroundColor = [UIColor yellowColor];
    [titleview addSubview:self.contractNameLabel];
    
    self.contractIDLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 17, 120, 20)];;
    //    self.contractIDLabel.text = @"CLNNJEJ";
    self.contractIDLabel.textAlignment = NSTextAlignmentCenter;
    self.contractIDLabel.textColor = RGB(255,255,255);
    self.contractIDLabel.font = [UIFont systemFontOfSize:15];
    //    self.contractIDLabel.backgroundColor = [UIColor blueColor];
    [titleview addSubview:self.contractIDLabel];
    
    
    self.navigationItem.titleView = titleview;
    
}

- (void)createTopView {
    
    self.detailTView = [[DetailTopView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight*0.139)];
    [self.view addSubview:self.detailTView];
    
    
    
    
}
#pragma mark  --加自选 按钮控制
- (void)addContractClick:(UIButton *)sender{

    addContractCount +=1;
    if (addContractCount%2 == 1) {
        [_addContract setTitle:@"删除自选" forState:UIControlStateNormal];
        
        [chooseByMyselfIDArray addObject:self.contractIDLabel.text];
        [[NSUserDefaults standardUserDefaults] setObject:chooseByMyselfIDArray forKey:@"chooseByMyselfIDArr"];
        
        
        NSLog(@"self.contractIDLabel.text-11--%@chooseByMyselfIDArray.count---%@",self.contractIDLabel.text,chooseByMyselfIDArray);
    }else{
        [_addContract setTitle:@"添加自选" forState:UIControlStateNormal];
        
        [chooseByMyselfIDArray removeObject:self.contractIDLabel.text];
        [[NSUserDefaults standardUserDefaults] setObject:chooseByMyselfIDArray forKey:@"chooseByMyselfIDArr"];
        
        
        
        NSLog(@"self.contractIDLabel.text-22--%@chooseByMyselfIDArray.count---%@",self.contractIDLabel.text,chooseByMyselfIDArray);
        
    }
}

- (void)createMiddleView {
    
    DetailMiddleView  *detailMV = [[DetailMiddleView alloc] initWithFrame:CGRectMake(0, 64+kScreenHeight*0.139, ScreenWidth, ScreenHeight-ScreenHeight*0.139-114)];
    
    [self.view addSubview:detailMV];
    
}

- (void)setTabbar {
    
    _view_tabbar=[[UIView alloc]init];
    _view_tabbar.backgroundColor = RGB(29,38,48);
    [self.view addSubview:_view_tabbar];
    [_view_tabbar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(50);
        
    }];

    
    /*
     * 资金
     */
    
    _btnFund = [UIButton new];
    _btnFund.frame = CGRectMake(0, 0, kScreenWidth/5, HEIGHT_Tabbar);
    [_btnFund addTarget:self action:@selector(btnFundClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view_tabbar addSubview:_btnFund];
    
    
    _imgV_Fund=[[UIImageView alloc]init];
    //    _imgV_Fund.backgroundColor=[UIColor  yellowColor];
    _imgV_Fund.bounds = CGRectMake(0, 0, kScreenWidth*0.085, kScreenWidth*0.085);
    _imgV_Fund.center = CGPointMake(_btnFund.center.x*1.25, _btnFund.center.y/1.5);
    _imgV_Fund.image=[UIImage imageNamed:@"zijin"];
    [_btnFund addSubview:_imgV_Fund];
    
    _lab_Fund=[[UILabel alloc]init];
    _lab_Fund.bounds = CGRectMake(0, 0, kScreenWidth*0.064, kScreenWidth*0.0347);
    _lab_Fund.center = CGPointMake(_btnFund.center.x*1.25, _btnFund.center.y*1.5);
    _lab_Fund.text=@"资金";
    _lab_Fund.textAlignment=NSTextAlignmentCenter;
    _lab_Fund.textColor = RGB(222,224,227);
    _lab_Fund.font = [UIFont systemFontOfSize:10];
    //    _lab_Fund.backgroundColor = [UIColor blueColor];
    [_btnFund addSubview:_lab_Fund];
    
    
    /*
     * 交易
     */
    
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
    
    _lab_Transaction=[[UILabel alloc]init];
    _lab_Transaction.bounds = CGRectMake(0, 0, kScreenWidth*0.064, kScreenWidth*0.0347);
    _lab_Transaction.center = CGPointMake(_btnTransaction.center.x/2.5, _btnTransaction.center.y*1.5);
    _lab_Transaction.text=@"交易";
    _lab_Transaction.textAlignment=NSTextAlignmentCenter;
    _lab_Transaction.textColor = RGB(222,224,227);
    _lab_Transaction.font = [UIFont systemFontOfSize:10];
    [_btnTransaction addSubview:_lab_Transaction];
    
    
    /*
     * 成交
     */
    
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
    
    _lab_Bargain=[[UILabel alloc]init];
    _lab_Bargain.bounds = CGRectMake(0, 0, kScreenWidth*0.064, kScreenWidth*0.0347);
    _lab_Bargain.center = CGPointMake(_btnBargain.center.x/4.8, _btnBargain.center.y*1.5);
    _lab_Bargain.text=@"成交";
    _lab_Bargain.textAlignment=NSTextAlignmentCenter;
    _lab_Bargain.textColor = RGB(222,224,227);
    _lab_Bargain.font = [UIFont systemFontOfSize:10];
    //    _lab_Fund.backgroundColor = [UIColor blueColor];
    [_btnBargain addSubview:_lab_Bargain];
    
    /*
     * 查询
     */
    
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
    
    _lab_Inquire=[[UILabel alloc]init];
    _lab_Inquire.bounds = CGRectMake(0, 0, kScreenWidth*0.064, kScreenWidth*0.0347);
    _lab_Inquire.center = CGPointMake(_btnInquire.center.x/7.6, _btnInquire.center.y*1.5);
    _lab_Inquire.text=@"查询";
    _lab_Inquire.textAlignment=NSTextAlignmentCenter;
    _lab_Inquire.textColor = RGB(222,224,227);
    _lab_Inquire.font = [UIFont systemFontOfSize:10];
    //    _lab_Fund.backgroundColor = [UIColor blueColor];
    [_btnInquire addSubview:_lab_Inquire];
    
    /*
     * 设置
     */
    
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
    
    _lab_Set=[[UILabel alloc]init];
    _lab_Set.bounds = CGRectMake(0, 0, kScreenWidth*0.064, kScreenWidth*0.0347);
    _lab_Set.center = CGPointMake(_btnSet.center.x/11.6, _btnSet.center.y*1.5);
    _lab_Set.text=@"设置";
    _lab_Set.textAlignment=NSTextAlignmentCenter;
    _lab_Set.textColor = RGB(222,224,227);
    _lab_Set.font = [UIFont systemFontOfSize:10];
    //    _lab_Fund.backgroundColor = [UIColor blueColor];
    [_btnSet addSubview:_lab_Set];
}

#pragma mark  --资金点击触发方法
- (void)btnFundClick {
    
    NSString  *account = [[NSUserDefaults standardUserDefaults] objectForKey:@"account"];
    
    
    
    NSLog(@"资金点击触发方法");
    [bargainBGView removeFromSuperview];
    [transactionBGView removeFromSuperview];
    [inquireBGView removeFromSuperview];
    [setBGView removeFromSuperview];
    
    fundCount += 1;
    
    
    
    if (fundCount%2 == 1) {
        
        [_manager requestForUniversalWithName:@"AccountInfoReport" WithContent:account withTag:600];
        
        _imgV_Fund.image=[UIImage imageNamed:@"zijin_1"];
        _imgV_Bargain.image=[UIImage imageNamed:@"chengjiao"];
        _imgV_Transaction.image=[UIImage imageNamed:@"jiaoyi"];
        _imgV_Inquire.image=[UIImage imageNamed:@"chaxun"];
        _imgV_Set.image=[UIImage imageNamed:@"shezhi"];
        
        _lab_Fund.textColor = RGB(227,74,80);
        _lab_Transaction.textColor = RGB(222,224,227);
        _lab_Bargain.textColor = RGB(222,224,227);
        _lab_Inquire.textColor = RGB(222,224,227);
        _lab_Set.textColor = RGB(222,224,227);
        
        
        bargainCount = 0;
        transactionCount = 0;
        inquireCount = 0;
        setCount = 0;
        
        
        self.fundView = [[FundView alloc] initWithFrame:CGRectMake(4, kScreenHeight, kScreenWidth-8, kScreenHeight*0.487)];
        
        fundBGView = self.fundView;
        
        
        
        self.fundView.layer.cornerRadius = 5;
        self.fundView.layer.borderWidth = 2;
        self.fundView.layer.borderColor = [RGB(42,55,68) CGColor];
        
        [self.view addSubview:fundBGView];
        
        // 状态栏(statusbar)
        CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
        
        if (rectStatus.size.width > 375) {
            [UIView animateWithDuration:1 animations:^{
                self.fundView.bounds = CGRectMake(4, 0, kScreenWidth-8, kScreenWidth*0.863);
                self.fundView.center = CGPointMake(self.view.center.x, self.view.center.y*1.365);
                
            } completion:^(BOOL finished) {
                
            }];
        }else {
            
            [UIView animateWithDuration:1 animations:^{
                self.fundView.bounds = CGRectMake(4, 0, kScreenWidth-8, kScreenWidth*0.863);
                self.fundView.center = CGPointMake(self.view.center.x, self.view.center.y*1.29+kScreenWidth*0.056);
                
            } completion:^(BOOL finished) {
                
            }];
            
        }
        
        [self.view bringSubviewToFront:self.view_tabbar];//把界面提高层级
        
    }else {
        
        _imgV_Fund.image=[UIImage imageNamed:@"zijin"];
        
        _lab_Fund.textColor = RGB(222,224,227);
        
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

#pragma mark  --交易点击触发方法
- (void)btnTransactionClick {
    NSLog(@"交易点击触发方法");
    
    NSString  *account = [[NSUserDefaults standardUserDefaults] objectForKey:@"account"];
    
    
    
    
    [fundBGView removeFromSuperview];
    [bargainBGView removeFromSuperview];
    [inquireBGView removeFromSuperview];
    [setBGView removeFromSuperview];
    
    selectCount = 30;
    
    transactionCount += 1;
    
    if (transactionCount%2 == 1) {
        
        [_manager requestForUniversalWithName:@"WaitBidInfoReport" WithContent:account withTag:760];//持仓合计
        [_manager requestForUniversalWithName:@"PreseBidReport" WithContent:account withTag:710];//限价委托
        [_manager requestForUniversalWithName:@"LimitBidReport" WithContent:account withTag:720];//止损止盈
        [_manager requestForUniversalWithName:@"BidListrsp" WithContent:account withTag:700];//交易明细
        
        _imgV_Transaction.image=[UIImage imageNamed:@"jiaoyi_1"];
        
        _imgV_Fund.image=[UIImage imageNamed:@"zijin"];
        //        _imgV_Bargain.image=[UIImage imageNamed:@"chengjiao"];
        _imgV_Bargain.image=[UIImage imageNamed:@"chengjiao"];
        _imgV_Inquire.image=[UIImage imageNamed:@"chaxun"];
        _imgV_Set.image=[UIImage imageNamed:@"shezhi"];
        
        
        _lab_Fund.textColor = RGB(222,224,227);
        _lab_Transaction.textColor = RGB(227,74,80);
        _lab_Bargain.textColor = RGB(222,224,227);
        _lab_Inquire.textColor = RGB(222,224,227);
        _lab_Set.textColor = RGB(222,224,227);
        
        
        
        fundCount = 0;
        bargainCount = 0;
        inquireCount = 0;
        setCount = 0;
        
        transactionBGView = [UIView new];
        transactionBGView.frame = CGRectMake(4, kScreenHeight, kScreenWidth-8, kScreenWidth*1.2213);
        
        
        
        [self loadTransactionBottomView];
        [self loadTransactionTopView];
        
        // 状态栏(statusbar)
        CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
        
        if (rectStatus.size.width > 375) {
            [UIView animateWithDuration:1 animations:^{
                transactionBGView.bounds = CGRectMake(0, 0, kScreenWidth-8, kScreenWidth*1.244);
                transactionBGView.center = CGPointMake(self.view.center.x, self.view.center.y*1.155);
                
            } completion:^(BOOL finished) {
                
            }];
        
        }else {
        
          [UIView animateWithDuration:1 animations:^{
            transactionBGView.bounds = CGRectMake(0, 0, kScreenWidth-8, kScreenWidth*1.2213);
            transactionBGView.center = CGPointMake(self.view.center.x, self.view.center.y*1.155);
            
        } completion:^(BOOL finished) {
            
         }];
            
        }
        
        transactionBGView.backgroundColor = RGB(30,36,41);
        
        [self.view addSubview:transactionBGView];
        [self.view bringSubviewToFront:self.view_tabbar];//把界面提高层级
        
    }else {
        
        _imgV_Transaction.image=[UIImage imageNamed:@"jiaoyi"];
        
        _lab_Transaction.textColor = RGB(222,224,227);
        
        [UIView animateWithDuration:0.3 animations:^{
            transactionBGView.frame = CGRectMake(4, kScreenHeight, kScreenWidth-8, kScreenWidth*1.2213);
        } completion:^(BOOL finished) {
            [transactionBGView removeFromSuperview];
            
            transactionCount = 0;
            
        }];
    }
}

#pragma mark  ---交易界面的top-view
- (void)loadTransactionTopView {
    
    UIView  *transactionTopView = [UIView new];
    transactionTopView.frame = CGRectMake(0, 0, kScreenWidth-8, kScreenWidth*0.656);
    transactionTopView.backgroundColor = RGB(30,36,46);
    [transactionBGView addSubview:transactionTopView];
    
    UILabel  *contractLab = [[UILabel alloc] init];
    contractLab.bounds = CGRectMake(0, 0, 25, 12);
    contractLab.center = CGPointMake(transactionTopView.center.x*0.15, transactionTopView.center.y*0.25);
    contractLab.backgroundColor = [UIColor clearColor];
    contractLab.text = @"合约";
    contractLab.textColor = [UIColor whiteColor];
    contractLab.textAlignment = NSTextAlignmentCenter;
    contractLab.font = [UIFont systemFontOfSize:12];
    [transactionTopView addSubview:contractLab];
    
    // 控件的创建
    dropdownMenu = [[LMJDropdownMenu alloc] init];
    dropdownMenu.backgroundColor = RGB(24,26,30);
    [dropdownMenu setFrame:CGRectMake(kScreenWidth*0.12, kScreenWidth*0.029, kScreenWidth*0.565, kScreenWidth*0.107)];
    [dropdownMenu setMenuTitles:contractNamearr rowHeight:40];
    [dropdownMenu.mainBtn setTitle:self.contractNameLabel.text forState:UIControlStateNormal];
    dropdownMenu.delegate = self;
    
    [transactionTopView addSubview:dropdownMenu];
    
    
    UILabel  *shoushuLab = [[UILabel alloc] init];
    shoushuLab.bounds = CGRectMake(0, 0, 25, 12);
    shoushuLab.center = CGPointMake(transactionTopView.center.x*0.15, transactionTopView.center.y*0.75);
    shoushuLab.backgroundColor = [UIColor clearColor];
    shoushuLab.text = @"手数";
    shoushuLab.textColor = [UIColor whiteColor];
    shoushuLab.textAlignment = NSTextAlignmentCenter;
    shoushuLab.font = [UIFont systemFontOfSize:12];
    [transactionTopView addSubview:shoushuLab];
    
    _lotTF = [UITextField new];
    _lotTF.bounds = CGRectMake(0, 0, kScreenWidth*0.461, kScreenWidth*0.107);
    _lotTF.center = CGPointMake(transactionTopView.center.x*0.73, transactionTopView.center.y*0.75);
    _lotTF.backgroundColor = RGB(24,26,30);
    _lotTF.text = @"1";
    _lotTF.textColor = [UIColor whiteColor];
    _lotTF.textAlignment = NSTextAlignmentCenter;
    _lotTF.font = [UIFont systemFontOfSize:12];
    _lotTF.keyboardType = UIKeyboardTypeNumberPad;
    _lotTF.layer.cornerRadius = 4;
    _lotTF.clipsToBounds = YES;
    _lotTF.layer.borderWidth = 0.5;
    _lotTF.layer.borderColor = [RGB(101,110,124) CGColor];
    [transactionTopView addSubview:_lotTF];
    
    UIButton  *tfLeftBtn = [UIButton new];
    tfLeftBtn.frame = CGRectMake(0, 0, 40, _lotTF.frame.size.height);
    [tfLeftBtn setImage:[UIImage imageNamed:@"ic_left_but"] forState:UIControlStateNormal];
    tfLeftBtn.backgroundColor = RGB(45,51,61);
    [tfLeftBtn addTarget:self action:@selector(tfLeftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_lotTF addSubview:tfLeftBtn];
    
    
    UIButton  *tfRightBtn = [UIButton new];
    tfRightBtn.frame = CGRectMake(_lotTF.frame.size.width-40, 0, 40, _lotTF.frame.size.height);
    [tfRightBtn setImage:[UIImage imageNamed:@"ic_right_but"] forState:UIControlStateNormal];
    tfRightBtn.backgroundColor = RGB(45,51,61);
    [tfRightBtn addTarget:self action:@selector(tfRightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_lotTF addSubview:tfRightBtn];
    
    
    _stopLossButten = [UIButton buttonWithType:UIButtonTypeCustom];
    _stopLossButten.bounds = CGRectMake(0, 0, kScreenWidth*0.344, kScreenWidth*0.107);
    _stopLossButten.center = CGPointMake(transactionTopView.center.x*1.6, transactionTopView.center.y*0.75);
    _stopLossButten.backgroundColor = RGB(30,36,46);
    [_stopLossButten setBackgroundImage:[UIImage imageNamed:@"s"] forState:UIControlStateNormal];
    [_stopLossButten addTarget:self action:@selector(stopLossBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [transactionTopView addSubview:_stopLossButten];
    
    
    
    
    
    UILabel  *typeLab = [[UILabel alloc] init];
    typeLab.bounds = CGRectMake(0, 0, 25, 12);
    typeLab.center = CGPointMake(transactionTopView.center.x*0.15, transactionTopView.center.y*1.23);
    typeLab.backgroundColor = [UIColor clearColor];
    typeLab.text = @"类型";
    typeLab.textColor = [UIColor whiteColor];
    typeLab.textAlignment = NSTextAlignmentCenter;
    typeLab.font = [UIFont systemFontOfSize:12];
    [transactionTopView addSubview:typeLab];
    
    
    _typeLabel = [UILabel new];
    _typeLabel.bounds = CGRectMake(0, 0, kScreenWidth*0.461, kScreenWidth*0.107);
    _typeLabel.center = CGPointMake(transactionTopView.center.x*0.73, transactionTopView.center.y*1.25);
    _typeLabel.backgroundColor = RGB(24,26,30);
    _typeLabel.text = @"市价";
    _typeLabel.textColor = [UIColor whiteColor];
    _typeLabel.textAlignment = NSTextAlignmentCenter;
    _typeLabel.font = [UIFont systemFontOfSize:12];
    _typeLabel.layer.cornerRadius = 4;
    _typeLabel.clipsToBounds = YES;
    _typeLabel.layer.borderWidth = 0.5;
    _typeLabel.layer.borderColor = [RGB(101,110,124) CGColor];
    _typeLabel.userInteractionEnabled = YES;
    [transactionTopView addSubview:_typeLabel];
    
    UIButton  *typeLeftBtn = [UIButton new];
    typeLeftBtn.frame = CGRectMake(0, 0, 40, _lotTF.frame.size.height);
    [typeLeftBtn setImage:[UIImage imageNamed:@"ic_left_but"] forState:UIControlStateNormal];
    typeLeftBtn.backgroundColor = RGB(45,51,61);
    [typeLeftBtn addTarget:self action:@selector(typeLeftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_typeLabel addSubview:typeLeftBtn];
    
    
    UIButton  *typeRightBtn = [UIButton new];
    typeRightBtn.frame = CGRectMake(_lotTF.frame.size.width-40, 0, 40, _lotTF.frame.size.height);
    [typeRightBtn setImage:[UIImage imageNamed:@"ic_right_but"] forState:UIControlStateNormal];
    typeRightBtn.backgroundColor = RGB(45,51,61);
    [typeRightBtn addTarget:self action:@selector(typeRightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_typeLabel addSubview:typeRightBtn];

    
    _typeTFCount = [UITextField new];
    _typeTFCount.bounds = CGRectMake(0, 0, kScreenWidth*0.344, kScreenWidth*0.107);
    _typeTFCount.center = CGPointMake(transactionTopView.center.x*1.6, transactionTopView.center.y*1.25);
    _typeTFCount.backgroundColor = RGB(45,51,61);
    _typeTFCount.keyboardType = UIKeyboardTypeDecimalPad;
    //float   aa = 49.99;
    //_typeTFCount.text = [NSString stringWithFormat:@"%.5f",aa];
    _typeTFCount.text = @"跟盘价";
    _typeTFCount.textColor = [UIColor whiteColor];
    _typeTFCount.textAlignment = NSTextAlignmentCenter;
    _typeTFCount.font = [UIFont systemFontOfSize:12];
    _typeTFCount.layer.cornerRadius = 4;
    _typeTFCount.clipsToBounds = YES;
    _typeTFCount.layer.borderWidth = 0.5;
    _typeTFCount.layer.borderColor = [RGB(101,110,124) CGColor];
    _typeTFCount.userInteractionEnabled = NO;
    [transactionTopView addSubview:_typeTFCount];
    
    
    _buyIn = [UIButton new];
    _buyIn.bounds = CGRectMake(0, 0, kScreenWidth*0.28, kScreenWidth*0.107);
    _buyIn.center = CGPointMake(transactionTopView.center.x*0.35, transactionTopView.center.y*1.72);
    [_buyIn setTitle:@"买  入" forState:UIControlStateNormal];
    [_buyIn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _buyIn.titleLabel.font = [UIFont systemFontOfSize:12];
    _buyIn.backgroundColor = RGB(227,74,80);
    _buyIn.layer.cornerRadius = 2;
    _buyIn.clipsToBounds = YES;
    [_buyIn addTarget:self action:@selector(buyInBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [transactionTopView addSubview:_buyIn];
    
    
    _sellOut = [UIButton new];
    _sellOut.bounds = CGRectMake(0, 0, kScreenWidth*0.28, kScreenWidth*0.107);
    _sellOut.center = CGPointMake(transactionTopView.center.x, transactionTopView.center.y*1.72);
    [_sellOut setTitle:@"卖  出" forState:UIControlStateNormal];
    [_sellOut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _sellOut.titleLabel.font = [UIFont systemFontOfSize:12];
    _sellOut.backgroundColor = RGB(44,179,120);
    _sellOut.layer.cornerRadius = 2;
    _sellOut.clipsToBounds = YES;
    [_sellOut addTarget:self action:@selector(sellOutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [transactionTopView addSubview:_sellOut];
    
    
    _balance = [UIButton new];
    _balance.bounds = CGRectMake(0, 0, kScreenWidth*0.28, kScreenWidth*0.107);
    _balance.center = CGPointMake(transactionTopView.center.x*1.65, transactionTopView.center.y*1.72);
    [_balance setTitle:@"平  仓" forState:UIControlStateNormal];
    [_balance setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _balance.titleLabel.font = [UIFont systemFontOfSize:12];
    _balance.backgroundColor = RGB(182,187,194);
    _balance.layer.cornerRadius = 2;
    _balance.clipsToBounds = YES;
    [_balance addTarget:self action:@selector(balanceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [transactionTopView addSubview:_balance];
    
    //[self.view bringSubviewToFront:transactionTopView];
}

#pragma mark  ---交易界面的bottom-view
- (void)loadTransactionBottomView {
   
    UIView  *labView = [UIView new];
    labView.frame = CGRectMake(0, kScreenWidth*0.656, kScreenWidth-8, 40);
    labView.backgroundColor = [UIColor clearColor];
    labView.layer.borderWidth = 0.5;
    labView.layer.borderColor = [RGB(42,55,68) CGColor];
    [transactionBGView addSubview:labView];
    
    _useFundLab = [UILabel new];
    _useFundLab.frame = CGRectMake(kScreenWidth*0.032, 10, kScreenWidth*0.294, 20);
    _useFundLab.text = @"可用资金:10000.00";
    _useFundLab.textColor = [UIColor whiteColor];
    _useFundLab.font = [UIFont systemFontOfSize:11];
    [labView addSubview:_useFundLab];
    
    _quanyiLab = [UILabel new];
    _quanyiLab.frame = CGRectMake(kScreenWidth*0.064+kScreenWidth*0.294, 10, kScreenWidth*0.294, 20);
    _quanyiLab.text = @"动态权益:10000.00";
    _quanyiLab.textColor = [UIColor whiteColor];
    _quanyiLab.font = [UIFont systemFontOfSize:11];
    [labView addSubview:_quanyiLab];
    
    _yingkuiLab = [UILabel new];
    _yingkuiLab.frame = CGRectMake(kScreenWidth*0.096+kScreenWidth*0.587, 10, kScreenWidth*0.294, 20);
    _yingkuiLab.text = @"持仓盈亏:100000.00";
    _yingkuiLab.textColor = [UIColor whiteColor];
    _yingkuiLab.font = [UIFont systemFontOfSize:11];
    [labView addSubview:_yingkuiLab];
    
    
    _sumBtn = [UIButton new];
    _sumBtn.frame = CGRectMake(0, kScreenWidth*0.656+40, transactionBGView.frame.size.width/4, 40);
    _sumBtn.backgroundColor = RGB(24,26,30);
    [_sumBtn setTitle:@"持仓合计" forState:UIControlStateNormal];
    [_sumBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _sumBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    _sumBtn.layer.borderWidth = 0.5;
    _sumBtn.layer.borderColor = [RGB(42,55,68) CGColor];
    _sumBtn.tag = 1010;
    [_sumBtn addTarget:self action:@selector(transactionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [transactionBGView addSubview:_sumBtn];
    
    _delegateBtn = [UIButton new];
    _delegateBtn.frame = CGRectMake(transactionBGView.frame.size.width/4, kScreenWidth*0.656+40, transactionBGView.frame.size.width/4, 40);
    //_delegateBtn.backgroundColor = RGB(24,26,30);
    [_delegateBtn setTitle:@"限价委托" forState:UIControlStateNormal];
    [_delegateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _delegateBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    _delegateBtn.layer.borderWidth = 0.5;
    _delegateBtn.layer.borderColor = [RGB(42,55,68) CGColor];
    _delegateBtn.tag = 1011;
    [_delegateBtn addTarget:self action:@selector(transactionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [transactionBGView addSubview:_delegateBtn];
    
    
    _stopLossBtn = [UIButton new];
    _stopLossBtn.frame = CGRectMake(transactionBGView.frame.size.width/2, kScreenWidth*0.656+40, transactionBGView.frame.size.width/4, 40);
    //_stopLossBtn.backgroundColor = RGB(24,26,30);
    [_stopLossBtn setTitle:@"止损止盈" forState:UIControlStateNormal];
    [_stopLossBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _stopLossBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    _stopLossBtn.layer.borderWidth = 0.5;
    _stopLossBtn.layer.borderColor = [RGB(42,55,68) CGColor];
    _stopLossBtn.tag = 1012;
    [_stopLossBtn addTarget:self action:@selector(transactionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [transactionBGView addSubview:_stopLossBtn];
    
    
    _transactionClearBtn = [UIButton new];
    _transactionClearBtn.frame = CGRectMake(transactionBGView.frame.size.width/4*3, kScreenWidth*0.656+40, transactionBGView.frame.size.width/4, 40);
    //_transactionClearBtn.backgroundColor = RGB(24,26,30);
    [_transactionClearBtn setTitle:@"交易明细" forState:UIControlStateNormal];
    [_transactionClearBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _transactionClearBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    _transactionClearBtn.layer.borderWidth = 0.5;
    _transactionClearBtn.layer.borderColor = [RGB(42,55,68) CGColor];
    _transactionClearBtn.tag = 1013;
    [_transactionClearBtn addTarget:self action:@selector(transactionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [transactionBGView addSubview:_transactionClearBtn];
    
    
    
    
    self.transactionTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.transactionTitlesForSum.count * BargainRightLabelWidth, transactionBGView.frame.size.height-80-kScreenWidth*0.656) style:UITableViewStylePlain];
    //self.transactionTV.frame = CGRectMake(0, kScreenWidth*0.656+80, kScreenWidth-8, transactionBGView.frame.size.height-80-kScreenWidth*0.656);
    self.transactionTV.delegate = self;
    self.transactionTV.dataSource = self;
    self.transactionTV.backgroundColor = RGB(30,36,46);
    self.transactionTV.showsVerticalScrollIndicator = NO;
    self.transactionTV.separatorStyle = UITableViewCellSelectionStyleNone;
    self.transactionTV.rowHeight = 35;
    
    
    self.transactionScrollview = [[UIScrollView alloc] init];
    self.transactionScrollview.contentSize = CGSizeMake(self.transactionTV.bounds.size.width, 0);
    self.transactionScrollview.backgroundColor = RGB(30,36,46);
    self.transactionScrollview.bounces = NO;
    self.transactionScrollview.showsHorizontalScrollIndicator = NO;
    
    
    [self.transactionScrollview addSubview:self.transactionTV];
    [transactionBGView addSubview:self.transactionScrollview];
    
    
    [self.transactionScrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(transactionBGView.mas_top).offset(kScreenWidth*0.869);
        make.right.and.bottom.equalTo(transactionBGView);
        make.left.equalTo(transactionBGView.mas_left).offset(0);
    }];
    
    
    //[transactionBGView addSubview:_transactionTV];

}

#pragma mark  ---交易 --四个表头按钮
- (void)transactionBtnClick:(UIButton *)sender {
    
    if (sender.tag == 1010) {
       _sumBtn.backgroundColor = RGB(24,26,30);
       _delegateBtn.backgroundColor = RGB(30,36,41);
       _stopLossBtn.backgroundColor = RGB(30,36,41);
       _transactionClearBtn.backgroundColor = RGB(30,36,41);
        
       selectCount = 30;
       [_transactionTV reloadData];
        
    }else if (sender.tag == 1011){
        _sumBtn.backgroundColor = RGB(30,36,41);
        _delegateBtn.backgroundColor = RGB(24,26,30);
        _stopLossBtn.backgroundColor = RGB(30,36,41);
        _transactionClearBtn.backgroundColor = RGB(30,36,41);
        selectCount = 31;
        [_transactionTV reloadData];
    }else if (sender.tag == 1012){
        
        _sumBtn.backgroundColor = RGB(30,36,41);
        _delegateBtn.backgroundColor = RGB(30,36,41);
        _stopLossBtn.backgroundColor = RGB(24,26,30);
        _transactionClearBtn.backgroundColor = RGB(30,36,41);
        selectCount = 32;
        [_transactionTV reloadData];
    }else if (sender.tag == 1013){
        
        _sumBtn.backgroundColor = RGB(30,36,41);
        _delegateBtn.backgroundColor = RGB(30,36,41);
        _stopLossBtn.backgroundColor = RGB(30,36,41);
        _transactionClearBtn.backgroundColor = RGB(24,26,30);
        selectCount = 33;
        [_transactionTV reloadData];
    }
    
}

#pragma mark  ---交易 --买入
- (void)buyInBtnClick:(UIButton *)sender{
    NSLog(@"买入-----买入-----买入-----");
    
    NSString  *account = [[NSUserDefaults standardUserDefaults] objectForKey:@"account"];
    NSLog(@"--%@---%@",account,self.contractIDLabel.text);
    
    NSLog(@"shoushu---%@",self.lotTF.text);
    
    
    NSString  *type = [NSString new];
    NSString  *dealprice = [NSString new];
    if ([self.typeLabel.text isEqualToString:@"市价"]) {
        type = @"0";
        dealprice = @"0.0";
        //NSLog(@"type-%@dealprice--%@",type,dealprice);
    }else{
        
        type = @"1";
        dealprice = self.typeTFCount.text;
        //NSLog(@"type-%@dealprice--%@",type,dealprice);
    }
    
    NSLog(@"type-%@dealprice--%@",type,dealprice);
    
    [_manager requestForTransactionWithName:@"Trade" withNSDictionary:@{@"UserID":account,@"Order_Id":@"1",@"BidNumber":@"null",@"StockID":self.contractIDLabel.text,@"Trade_ID":@"0",@"TriggerMode":type,@"DealPrice":dealprice,@"BidLot":self.lotTF.text,@"CreateDate":@"0001-01-01T00:00:00"} withTag:770];//交易--买入
}

#pragma mark  ---交易 --卖出
- (void)sellOutBtnClick:(UIButton *)sender{
    NSLog(@"卖出-----卖出-----卖出-----");
    
    NSString  *account = [[NSUserDefaults standardUserDefaults] objectForKey:@"account"];
    NSLog(@"--%@---%@",account,self.contractIDLabel.text);
    
    NSLog(@"shoushu---%@",self.lotTF.text);
    
    
    NSString  *type = [NSString new];
    NSString  *dealprice = [NSString new];
    if ([self.typeLabel.text isEqualToString:@"市价"]) {
        type = @"0";
        dealprice = @"0.0";
        NSLog(@"type-%@dealprice--%@",type,dealprice);
    }else{
        
        type = @"1";
        dealprice = self.typeTFCount.text;
        NSLog(@"type-%@dealprice--%@",type,dealprice);
    }
    
    [_manager requestForTransactionWithName:@"Trade" withNSDictionary:@{@"UserID":account,@"Order_Id":@"1",@"BidNumber":@"null",@"StockID":self.contractIDLabel.text,@"Trade_ID":@"1",@"TriggerMode":type,@"DealPrice":dealprice,@"BidLot":self.lotTF.text,@"CreateDate":@"0001-01-01T00:00:00"} withTag:770];//交易--卖出
}

#pragma mark  ---交易 --平仓
- (void)balanceBtnClick:(UIButton *)sender{
    NSLog(@"平仓-----平仓-----平仓-----");
    
    
    NSLog(@"%@",pingcangDirection);
    
    if (pingcangDirection.length > 0) {
        
        NSString  *Trade_ID = [NSString new];
        
        if ([pingcangDirection intValue] == 0) {
            Trade_ID = @"1";
        }else {
            Trade_ID = @"0";
        }
        
        NSString  *account = [[NSUserDefaults standardUserDefaults] objectForKey:@"account"];
        NSLog(@"--%@---%@",account,self.contractIDLabel.text);
        
        NSLog(@"shoushu---%@",self.lotTF.text);
        
        
        [_manager requestForTransactionWithName:@"Trade" withNSDictionary:@{@"UserID":account,@"Order_Id":@"2",@"BidNumber":@"null",@"StockID":self.contractIDLabel.text,@"Trade_ID":Trade_ID,@"TriggerMode":@"0",@"BidLot":self.lotTF.text,@"CreateDate":@"0001-01-01T00:00:00"} withTag:790];//交易--平仓
        
    }else {
        [AlertView alertViewWithText:@"请选择你要平仓的合约" withVC:self];
    }
    
    
    
    
   
}

#pragma mark   ----交易 止损止盈
- (void)stopLossBtnClick:(UIButton *)sender{
    
    selectCount = 34;
    
    count1 = 0;
    count2 = 0;
    
    NSString  *account = [[NSUserDefaults standardUserDefaults] objectForKey:@"account"];
    [_manager requestForUniversalWithName:@"WaitBidInfoReport" WithContent:account withTag:760];//持仓合计
    
    
    stopLossBGView  = [UIView new];
    stopLossBGView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-50);
    stopLossBGView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:stopLossBGView];
    
    
    UIView  *view = [UIView new];
    //view.frame = CGRectMake(17, stopLossBGView.frame.size.height-kScreenWidth*0.917, kScreenWidth-34, kScreenWidth*0.917);
    view.bounds = CGRectMake(0, 0, kScreenWidth-34, kScreenWidth*0.917);
    view.center = stopLossBGView.center;
    view.backgroundColor = RGB(222,224,227);
    view.layer.cornerRadius = 2;
    view.clipsToBounds = YES;
    [stopLossBGView addSubview:view];
    
    
    UILabel  *titleLab = [UILabel new];
    titleLab.frame = CGRectMake(0, 0, view.frame.size.width, kScreenWidth*0.083);
    titleLab.text = @"止损止盈设置";
    titleLab.font = [UIFont systemFontOfSize:12];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [view addSubview:titleLab];
    
    
    UIImageView   *lineImg = [UIImageView new];
    lineImg.frame = CGRectMake(0, kScreenWidth*0.08, view.frame.size.width, 1);
    lineImg.backgroundColor = RGB(29,35,44);
    [view addSubview:lineImg];
    
    stopLossTV = [UITableView new];
    stopLossTV.frame = CGRectMake(0, kScreenWidth*0.085, view.frame.size.width, kScreenWidth*0.163);
    stopLossTV.backgroundColor = RGB(222,224,227);
    stopLossTV.rowHeight = 30;
    stopLossTV.delegate = self;
    stopLossTV.dataSource = self;
    stopLossTV.showsVerticalScrollIndicator = NO;
    
    [view addSubview:stopLossTV];
    
    
    for (int i = 0; i < 3; i++) {
        UIView  *lineView = [UIView new];
        lineView.frame = CGRectMake(0, kScreenWidth*0.248+i*kScreenWidth*0.267, view.frame.size.width, 1);
        lineView.backgroundColor = RGB(29,35,44);
        [view addSubview:lineView];
    }
    
    UILabel  *contractLab = [UILabel new];
    contractLab.frame = CGRectMake(kScreenWidth*0.133, kScreenWidth*0.3, kScreenWidth*0.067, kScreenWidth*0.032);
    contractLab.text = @"合约";
    contractLab.textAlignment = NSTextAlignmentCenter;
    contractLab.font = [UIFont systemFontOfSize:12];
    [view addSubview:contractLab];
    
    contractLable = [UILabel new];
    contractLable.frame = CGRectMake(kScreenWidth*0.205, kScreenWidth*0.275, kScreenWidth*0.243, kScreenWidth*0.083);
    contractLable.textAlignment = NSTextAlignmentCenter;
    contractLable.font = [UIFont systemFontOfSize:11];
    contractLable.layer.cornerRadius = 2;
    contractLable.clipsToBounds = YES;
    contractLable.layer.borderWidth = 0.5;
    contractLable.layer.borderColor = [RGB(19,21,24) CGColor];
    [view addSubview:contractLable];
    
    
    UILabel  *directionLab = [UILabel new];
    directionLab.frame = CGRectMake(kScreenWidth*0.461, kScreenWidth*0.3, kScreenWidth*0.067, kScreenWidth*0.032);
    directionLab.text = @"方向";
    directionLab.textAlignment = NSTextAlignmentCenter;
    directionLab.font = [UIFont systemFontOfSize:12];
    [view addSubview:directionLab];
    
    directionLable = [UILabel new];
    directionLable.frame = CGRectMake(kScreenWidth*0.5387, kScreenWidth*0.275, kScreenWidth*0.243, kScreenWidth*0.083);
    directionLable.textAlignment = NSTextAlignmentCenter;
    directionLable.font = [UIFont systemFontOfSize:11];
    directionLable.layer.cornerRadius = 2;
    directionLable.clipsToBounds = YES;
    directionLable.layer.borderWidth = 0.5;
    directionLable.layer.borderColor = [RGB(19,21,24) CGColor];
    [view addSubview:directionLable];
    
    
    UILabel  *lotLab = [UILabel new];
    lotLab.frame = CGRectMake(kScreenWidth*0.133, kScreenWidth*0.4347, kScreenWidth*0.067, kScreenWidth*0.032);
    lotLab.text = @"手数";
    lotLab.textAlignment = NSTextAlignmentCenter;
    lotLab.font = [UIFont systemFontOfSize:12];
    [view addSubview:lotLab];
    
    lotTextField = [UITextField new];
    lotTextField.frame = CGRectMake(kScreenWidth*0.205, kScreenWidth*0.4, kScreenWidth*0.5787, kScreenWidth*0.1013);
    lotTextField.backgroundColor = RGB(245,245,245);
    lotTextField.text = @"1";
    lotTextField.textAlignment = NSTextAlignmentCenter;
    lotTextField.font = [UIFont systemFontOfSize:11];
    lotTextField.keyboardType = UIKeyboardTypeNumberPad;
    lotTextField.layer.cornerRadius = 3;
    lotTextField.clipsToBounds = YES;
    lotTextField.layer.borderWidth = 0.5;
    lotTextField.layer.borderColor = [RGB(19,21,24) CGColor];
    [view addSubview:lotTextField];
    
    
    UIButton  *reduceBtn = [UIButton new];
    reduceBtn.frame = CGRectMake(0, 0, kScreenWidth*0.1093, kScreenWidth*0.1093);
    reduceBtn.backgroundColor = RGB(222,224,227);
    [reduceBtn setTitle:@"-" forState:UIControlStateNormal];
    [reduceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [reduceBtn addTarget:self action:@selector(reduceBtn:) forControlEvents:UIControlEventTouchUpInside];
    [lotTextField addSubview:reduceBtn];
    
    UIButton  *addBtn = [UIButton new];
    addBtn.frame = CGRectMake(lotTextField.frame.size.width-kScreenWidth*0.1093, 0, kScreenWidth*0.1093, kScreenWidth*0.1093);
    addBtn.backgroundColor = RGB(222,224,227);
    [addBtn setTitle:@"+" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtn:) forControlEvents:UIControlEventTouchUpInside];
    [lotTextField addSubview:addBtn];
    
    
    UIButton  *stopLossButtenn = [UIButton new];
    stopLossButtenn.frame = CGRectMake(kScreenWidth*0.133, kScreenWidth*0.56, kScreenWidth*0.123, kScreenWidth*0.053);
    [stopLossButtenn addTarget:self action:@selector(stopLossButtennClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:stopLossButtenn];
    
    stopLossImg = [UIImageView new];
    stopLossImg.frame = CGRectMake(0, 0, kScreenWidth*0.053, kScreenWidth*0.053);
    stopLossImg.image = [UIImage imageNamed:@"ic_checkbox_normal"];
    [stopLossButtenn addSubview:stopLossImg];
    
    UILabel  *stopLossLab = [UILabel new];
    stopLossLab.frame = CGRectMake(kScreenWidth*0.061, kScreenWidth*0.008, kScreenWidth*0.075, kScreenWidth*0.037);
    stopLossLab.text = @"止损";
    stopLossLab.textAlignment = NSTextAlignmentCenter;
    stopLossLab.font = [UIFont systemFontOfSize:12];
    stopLossLab.textColor = RGB(19,21,24);
    [stopLossButtenn addSubview:stopLossLab];
    
    stopLossTF = [UITextField new];
    stopLossTF.frame = CGRectMake(kScreenWidth*0.272, kScreenWidth*0.533, kScreenWidth*0.509, kScreenWidth*0.101);
    stopLossTF.backgroundColor = RGB(245,245,245);
    stopLossTF.textColor = RGB(28,34,43);
    stopLossTF.text = @"0";
    stopLossTF.textAlignment = NSTextAlignmentCenter;
    stopLossTF.font = [UIFont systemFontOfSize:11];
    stopLossTF.userInteractionEnabled = NO;
    stopLossTF.layer.borderWidth = 0.5;
    stopLossTF.layer.borderColor = [RGB(28,34,43) CGColor];
    stopLossTF.keyboardType = UIKeyboardTypeDecimalPad;
    [view addSubview:stopLossTF];
    
    UIButton  *stopWinButtenn = [UIButton new];
    stopWinButtenn.frame = CGRectMake(kScreenWidth*0.133, kScreenWidth*0.688, kScreenWidth*0.123, kScreenWidth*0.053);
    [stopWinButtenn addTarget:self action:@selector(stopWinButtennClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:stopWinButtenn];
    
    stopWinImg = [UIImageView new];
    stopWinImg.frame = CGRectMake(0, 0, kScreenWidth*0.053, kScreenWidth*0.053);
    stopWinImg.image = [UIImage imageNamed:@"ic_checkbox_normal"];
    [stopWinButtenn addSubview:stopWinImg];
    
    UILabel  *stopWinLab = [UILabel new];
    stopWinLab.frame = CGRectMake(kScreenWidth*0.061, kScreenWidth*0.008, kScreenWidth*0.075, kScreenWidth*0.037);
    stopWinLab.text = @"止盈";
    stopWinLab.textAlignment = NSTextAlignmentCenter;
    stopWinLab.font = [UIFont systemFontOfSize:12];
    stopWinLab.textColor = RGB(19,21,24);
    [stopWinButtenn addSubview:stopWinLab];
    
    stopWinTF = [UITextField new];
    stopWinTF.frame = CGRectMake(kScreenWidth*0.272, kScreenWidth*0.667, kScreenWidth*0.509, kScreenWidth*0.101);
    stopWinTF.backgroundColor = RGB(245,245,245);
    stopWinTF.textColor = RGB(28,34,43);
    stopWinTF.text = @"0";
    stopWinTF.textAlignment = NSTextAlignmentCenter;
    stopWinTF.font = [UIFont systemFontOfSize:11];
    stopWinTF.userInteractionEnabled = NO;
    stopWinTF.layer.borderWidth = 0.5;
    stopWinTF.layer.borderColor = [RGB(28,34,43) CGColor];
    stopWinTF.keyboardType = UIKeyboardTypeDecimalPad;
    [view addSubview:stopWinTF];
    
    
    UIButton  *cancelBtn = [UIButton new];
    cancelBtn.frame = CGRectMake(kScreenWidth*0.04, view.frame.size.height-kScreenWidth*0.12, kScreenWidth*0.392, kScreenWidth*0.1);
    cancelBtn.layer.cornerRadius = 2;
    cancelBtn.clipsToBounds = YES;
    cancelBtn.layer.borderWidth = 0.5;
    cancelBtn.layer.borderColor = [RGB(44,179,120) CGColor];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:RGB(19,21,24) forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [cancelBtn addTarget:self action:@selector(stopLossCancleBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:cancelBtn];
    
    UIButton  *sureBtn = [UIButton new];
    sureBtn.frame = CGRectMake(kScreenWidth*0.08+kScreenWidth*0.392, view.frame.size.height-kScreenWidth*0.12, kScreenWidth*0.392, kScreenWidth*0.1);
    sureBtn.layer.cornerRadius = 2;
    sureBtn.clipsToBounds = YES;
    sureBtn.layer.borderWidth = 0.5;
    sureBtn.layer.borderColor = [RGB(227,74,80) CGColor];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:RGB(19,21,24) forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [sureBtn addTarget:self action:@selector(stopLossSureBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:sureBtn];
    
}

#pragma mark  --交易--止损止盈-止损
- (void)stopLossButtennClick:(UIButton *)sender {
    count1 += 1;
    if (count1%2 == 1) {
        if (contractLable.text.length != 0) {
        stopLossImg.image = [UIImage imageNamed:@"ic_checkbox_check_green"];
        stopLossTF.userInteractionEnabled = YES;
        stopLossTF.text = self.detailTView.lab_left_number1.text;
        }else {
            [AlertView alertViewWithText:@"请选择您要操作的合约" withVC:self];
        }
        
    }else {
        stopLossImg.image = [UIImage imageNamed:@"ic_checkbox_normal"];
        stopLossTF.text = @"0";
        stopLossTF.userInteractionEnabled = NO;
    }
}

#pragma mark  --交易--止损止盈-止盈
- (void)stopWinButtennClick:(UIButton *)sender {
    count2 += 1;
    if (count2%2 == 1) {
        if (contractLable.text.length != 0) {
        stopWinImg.image = [UIImage imageNamed:@"ic_checkbox_check_red"];
        stopWinTF.userInteractionEnabled = YES;
        stopWinTF.text = self.detailTView.lab_left_number1.text;
        }else {
            [AlertView alertViewWithText:@"请选择您要操作的合约" withVC:self];
        }
    }else {
        stopWinImg.image = [UIImage imageNamed:@"ic_checkbox_normal"];
        stopWinTF.text = @"0";
        stopWinTF.userInteractionEnabled = NO;
    }
}

#pragma mark  --交易--止损止盈-手数减
- (void)reduceBtn:(UIButton *)sender {
    int  aaa;
    aaa = [lotTextField.text intValue];
    if (aaa > 1) {
        aaa -= 1;
        lotTextField.text = [NSString stringWithFormat:@"%d",aaa];
    }else {
        return;
    }
}

#pragma mark  --交易--止损止盈-手数加
- (void)addBtn:(UIButton *)sender {
    int  bbb;
    bbb = [lotTextField.text intValue];
    bbb +=1;
    lotTextField.text = [NSString stringWithFormat:@"%d",bbb];
}

#pragma mark  --交易--止损止盈-取消
- (void)stopLossCancleBtn:(UIButton *)sender {
    [stopLossBGView removeFromSuperview];
}

#pragma mark  --交易--止损止盈-获取止损止盈类型
- (NSString *)ReturnLimitType{
    if ([stopLossTF.text intValue] != 0 && [stopWinTF.text intValue] != 0) {
        return @"2";
    }else if ([stopLossTF.text intValue] != 0 ){
        return @"0";
    }else if ([stopWinTF.text intValue] != 0 ){
        return @"1";
    }else{
        return @"3";
    }
}

#pragma mark  --交易--止损止盈-发送止损止盈所需条件
-(BOOL)IsSendLimitBid{
    if(contractLable.text.length==0)
    {
        [AlertView alertViewWithText:@"请选择您要操作的合约" withVC:self];
        return NO;
    }
    else if([[self ReturnLimitType] isEqualToString:@"3"])
    {
        [AlertView alertViewWithText:@"请选择止损止盈类型" withVC:self];
        return NO;
    }
    else if ([[self ReturnLimitType] isEqualToString:@"0"])
    {
        if ([directionLable.text isEqualToString:@"卖"])
        {
            if ([stopLossTF.text doubleValue] >= [self.detailTView.lab_left_number1.text doubleValue]) {
                [AlertView alertViewWithText:@"止损价格应小于对应合约最新价" withVC:self];
                return NO;
            }else {
                return YES;
            }
        }
        else
        {
            if ([stopLossTF.text doubleValue] <= [self.detailTView.lab_left_number1.text doubleValue]) {
                [AlertView alertViewWithText:@"止损价格应大于对应合约最新价" withVC:self];
                return NO;
            }else {
                return YES;
            }
        }
    }
    else if([[self ReturnLimitType] isEqualToString:@"1"])
    {
        if ([directionLable.text isEqualToString:@"卖"])
        {
            if ([stopWinTF.text doubleValue] <= [self.detailTView.lab_left_number1.text doubleValue]) {
                [AlertView alertViewWithText:@"止盈价格应大于对应合约最新价" withVC:self];
                return NO;
            }else {
                return YES;
            }
        }
        else
        {
            if ([stopWinTF.text doubleValue] >= [self.detailTView.lab_left_number1.text doubleValue]) {
                [AlertView alertViewWithText:@"止盈价格应小于对应合约最新价" withVC:self];
                return NO;
            }else {
                return YES;
            }
        }
    }
    else{
        if ([directionLable.text isEqualToString:@"卖"])
        {
            if ([stopLossTF.text doubleValue] >= [self.detailTView.lab_left_number1.text doubleValue]) {
                [AlertView alertViewWithText:@"止损价格应小于对应合约最新价" withVC:self];
                return NO;
            }
            else if ([stopWinTF.text doubleValue] <= [self.detailTView.lab_left_number1.text doubleValue]) {
                [AlertView alertViewWithText:@"止盈价格应大于对应合约最新价" withVC:self];
                return NO;
            }else {
                return YES;
            }
        }
        else
        {
            if ([stopLossTF.text doubleValue] <= [self.detailTView.lab_left_number1.text doubleValue]) {
                [AlertView alertViewWithText:@"止损价格应大于对应合约最新价" withVC:self];
                return NO;
            }
            else if ([stopWinTF.text doubleValue] >= [self.detailTView.lab_left_number1.text doubleValue]) {
                [AlertView alertViewWithText:@"止盈价格应小于对应合约最新价" withVC:self];
                return NO;
            }else {
                return YES;
            }
        }
    }
}

#pragma mark  --交易--止损止盈-确定
- (void)stopLossSureBtn:(UIButton *)sender{
    if([self IsSendLimitBid] == YES)
    {
        NSString  *account = [[NSUserDefaults standardUserDefaults] objectForKey:@"account"];
        NSString  *direction = [NSString new];
        if ([directionLable.text isEqualToString:@"买"]) {
            direction = @"0";
        }else{
            direction = @"1";
        }
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSString *DateTime = [formatter stringFromDate:date];
        //NSLog(@"account--%@contractLable.text---%@",account,contractLable.text);
        
        [_manager requestForTransactionWithName:@"LimitBidAdd" withNSDictionary:@{@"UserID":account,@"StockID":contractLable.text,@"TradeType":direction,@"LimitType":[self ReturnLimitType],@"Lot":lotTextField.text,@"UpLimit":stopWinTF.text,@"DownLimit":stopLossTF.text,@"LimitStatus":@"0",@"LimitResult":@"0",@"CreateDate":DateTime,@"DealDate":DateTime,@"DealBidNumber":@"-"} withTag:795];//交易--止损止盈
    }
}

#pragma mark   ----交易 手数--- 减
- (void)tfLeftBtnClick:(UIButton *)sender{
    int  aaa;
    aaa = [self.lotTF.text intValue];
    if (aaa > 1) {
        aaa -= 1;
        self.lotTF.text = [NSString stringWithFormat:@"%d",aaa];
    }else {
        return;
    }
}

#pragma mark   ----交易 手数---  加
- (void)tfRightBtnClick:(UIButton *)sender {
    int  bbb;
    bbb = [self.lotTF.text intValue];
    bbb +=1;
    self.lotTF.text = [NSString stringWithFormat:@"%d",bbb];
    
}
#pragma mark   ----交易  类型
- (void)typeLeftBtnClick:(UIButton *)sender {
    self.typeLabel.text = @"限价";
    _typeTFCount.userInteractionEnabled = YES;
    _typeTFCount.backgroundColor = RGB(24,26,30);
    _typeTFCount.text = self.detailTView.lab_left_number1.text;
}
- (void)typeRightBtnClick:(UIButton *)sender {
    self.typeLabel.text = @"市价";
    _typeTFCount.userInteractionEnabled = NO;
    _typeTFCount.backgroundColor = RGB(45,51,61);
    _typeTFCount.text = @"跟盘价";
}

#pragma mark - LMJDropdownMenu Delegate
- (void)dropdownMenu:(LMJDropdownMenu *)menu selectedCellNumber:(NSInteger)number{
    NSLog(@"你选择了：%ld",number);
    self.contractNameLabel.text = contractNamearr[number];
    self.contractIDLabel.text = contractIDarr[number];
    self.detailTView.lab_left_number1.text = @"---";
    self.detailTView.lab_left_number2.text = @"-- --";
    self.detailTView.lab_Max_number.text = @"---";
    self.detailTView.lab_Sell_number.text = @"---";
    self.detailTView.lab_MaxSell_num.text = @"---";
    self.detailTView.lab_Min_number.text = @"---";
    self.detailTView.lab_Buy_number.text = @"---";
    self.detailTView.lab_MinBuy_num.text = @"---";
    
    
    [_addContract setTitle:@"添加自选" forState:UIControlStateNormal];
    
    for (int i = 0; i < chooseByMyselfIDArray.count; i++) {
        
        if ([self.contractIDLabel.text isEqualToString:chooseByMyselfIDArray[i]]) {
            addContractCount = 1;
            [_addContract setTitle:@"删除自选" forState:UIControlStateNormal];
        }
    }
    
}

- (void)dropdownMenuWillShow:(LMJDropdownMenu *)menu{
    NSLog(@"--将要显示--");
    _sumBtn.userInteractionEnabled = NO;
    _delegateBtn.userInteractionEnabled = NO;
    _stopLossBtn.userInteractionEnabled = NO;
    _transactionClearBtn.userInteractionEnabled = NO;
    _stopLossButten.userInteractionEnabled = NO;
    _transactionTV.userInteractionEnabled = NO;
}
- (void)dropdownMenuDidShow:(LMJDropdownMenu *)menu{
    NSLog(@"--已经显示--");
}

- (void)dropdownMenuWillHidden:(LMJDropdownMenu *)menu{
    NSLog(@"--将要隐藏--");
    _sumBtn.userInteractionEnabled = YES;
    _delegateBtn.userInteractionEnabled = YES;
    _stopLossBtn.userInteractionEnabled = YES;
    _transactionClearBtn.userInteractionEnabled = YES;
    _stopLossButten.userInteractionEnabled = YES;
    _transactionTV.userInteractionEnabled = YES;
}
- (void)dropdownMenuDidHidden:(LMJDropdownMenu *)menu{
    NSLog(@"--已经隐藏--");
}


#pragma mark  --成交点击触发方法
- (void)btnBargainClick {
    NSLog(@"成交点击触发方法");
    NSString  *account = [[NSUserDefaults standardUserDefaults] objectForKey:@"account"];
    [fundBGView removeFromSuperview];
    [transactionBGView removeFromSuperview];
    //    [bargainBGView removeFromSuperview];
    [inquireBGView removeFromSuperview];
    [setBGView removeFromSuperview];
    
    bargainCount += 1;
    
    selectCount = 10;
    
    if (bargainCount%2 == 1) {
        
        [_manager requestForUniversalWithName:@"CloseOutBidListrsp" WithContent:account withTag:730];//成交记录
        
//        selectCount = 10;
        
        _imgV_Bargain.image=[UIImage imageNamed:@"chengjiao_1"];
        
        _imgV_Fund.image=[UIImage imageNamed:@"zijin"];
        _imgV_Transaction.image=[UIImage imageNamed:@"jiaoyi"];
        //        _imgV_Transaction.image=[UIImage imageNamed:@"jiaoyi"];
        _imgV_Inquire.image=[UIImage imageNamed:@"chaxun"];
        _imgV_Set.image=[UIImage imageNamed:@"shezhi"];
        
        
        _lab_Fund.textColor = RGB(222,224,227);
        _lab_Transaction.textColor = RGB(222,224,227);
        _lab_Bargain.textColor = RGB(227,74,80);
        _lab_Inquire.textColor = RGB(222,224,227);
        _lab_Set.textColor = RGB(222,224,227);
        
        
        fundCount = 0;
        //        bargainCount = 0;
        transactionCount = 0;
        inquireCount = 0;
        setCount = 0;
        
        self.bargainView = [[BargainView alloc] initWithFrame:CGRectMake(4, kScreenHeight, kScreenWidth-8, kScreenWidth*1.2213)];
        
        bargainBGView = self.bargainView;
        self.bargainView.backgroundColor = [UIColor clearColor];
        
        [self loadBargainTableView];
        
        self.bargainView.layer.cornerRadius = 5;
        self.bargainView.layer.borderWidth = 2;
        self.bargainView.layer.borderColor = [RGB(42,55,68) CGColor];
        
        // 状态栏(statusbar)
        CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
        
        if (rectStatus.size.width > 375) {
            
            [UIView animateWithDuration:1 animations:^{
                self.bargainView.bounds = CGRectMake(0, 0, kScreenWidth-8, kScreenWidth*1.244);
                self.bargainView.center = CGPointMake(self.view.center.x, self.view.center.y*1.155);
                
            } completion:^(BOOL finished) {
                
            }];
        }else {
            
            [UIView animateWithDuration:1 animations:^{
                self.bargainView.bounds = CGRectMake(0, 0, kScreenWidth-8, kScreenWidth*1.2213);
                self.bargainView.center = CGPointMake(self.view.center.x, self.view.center.y*1.155);
                
            } completion:^(BOOL finished) {
                
            }];
            
        }
        
        
        [self.view addSubview:bargainBGView];
        [self.view bringSubviewToFront:self.view_tabbar];//把界面提高层级
        
    }else {
        
        _imgV_Bargain.image=[UIImage imageNamed:@"chengjiao"];
        
        _lab_Bargain.textColor = RGB(222,224,227);
        
        [UIView animateWithDuration:0.3 animations:^{
            bargainBGView.frame = CGRectMake(4, kScreenHeight, kScreenWidth-8, kScreenWidth*1.2213);
        } completion:^(BOOL finished) {
            [bargainBGView removeFromSuperview];
            
            bargainCount = 0;
            
        }];
    }
}

#pragma mark  ---成交界面的tableview
- (void)loadBargainTableView{
    
    self.bargainTV_right = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.bargainTitles.count * BargainRightLabelWidth, bargainBGView.frame.size.height-32) style:UITableViewStylePlain];
    self.bargainTV_right.delegate = self;
    self.bargainTV_right.dataSource = self;
    self.bargainTV_right.showsVerticalScrollIndicator = NO;
    self.bargainTV_right.separatorStyle = UITableViewCellSelectionStyleNone;
    self.bargainTV_right.backgroundColor = [UIColor clearColor];
    self.bargainTV_right.rowHeight = 35;
    
    
    self.bargainScrollView = [[UIScrollView alloc] init];
    self.bargainScrollView.contentSize = CGSizeMake(self.bargainTV_right.bounds.size.width, 0);
    self.bargainScrollView.backgroundColor = [UIColor clearColor];
    self.bargainScrollView.bounces = NO;
    self.bargainScrollView.showsHorizontalScrollIndicator = NO;
    
    
    [self.bargainScrollView addSubview:self.bargainTV_right];
    [bargainBGView addSubview:self.bargainScrollView];
    
    [self.bargainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bargainBGView.mas_top).offset(0);
        make.right.and.bottom.equalTo(bargainBGView);
        make.left.equalTo(bargainBGView.mas_left).offset(0);
    }];
}

#pragma mark - table view dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
            if (selectCount == 10) {//成交背景view存在
                
                
                BargainRightTableViewCell *cell = [BargainRightTableViewCell cellWithTableView:tableView WithNumberOfLabels:self.bargainTitles.count];
                

                
                if (self.closeoutbidListrspArr.count > 0) {
                    cell.model = self.closeoutbidListrspArr[indexPath.row];
                }
                
                cell.backgroundColor = RGB(30,36,46);
                cell.textLabel.font = [UIFont systemFontOfSize:11];
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
                
                cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
                cell.selectedBackgroundView.backgroundColor = RGB(24,26,30);
                
                return cell;
            }else {
                if (selectCount == 20) {//查询--交易明细
                    
                    InquireBidListrspTableViewCell *cell = [InquireBidListrspTableViewCell cellWithTableView:tableView WithNumberOfLabels:self.inquireTitlesForDetail.count];
                    
//                    cell.model = inquireBidArr[indexPath.row];
                    
                    if (inquireBidDateArr.count > 0) {
                        cell.model = inquireBidDateArr[indexPath.row];
                    }
                    
                    cell.backgroundColor = RGB(30,36,46);
                    cell.textLabel.font = [UIFont systemFontOfSize:11];
                    cell.textLabel.textAlignment = NSTextAlignmentCenter;
                    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
                    cell.selectedBackgroundView.backgroundColor = RGB(24,26,30);
                    
                    
                    
                    return cell;
                    
                }
                if (selectCount == 21) {//查询--委托记录
                    InquirePresetBidListrspTableViewCell *cell = [InquirePresetBidListrspTableViewCell cellWithTableView:tableView WithNumberOfLabels:self.inquireTitlesForEntrust.count];
                    
//                    cell.model = inquirePresetBidArr[indexPath.row];
                    if (inquirePresetBidDateArr.count>0) {
                        cell.model = inquirePresetBidDateArr[indexPath.row];
                    }
                    
                    cell.backgroundColor = RGB(30,36,46);
                    cell.textLabel.font = [UIFont systemFontOfSize:11];
                    cell.textLabel.textAlignment = NSTextAlignmentCenter;
                    
                    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
                    cell.selectedBackgroundView.backgroundColor = RGB(24,26,30);
                    
                    return cell;
                }
                if (selectCount == 22) {//查询--止损止盈
                    InquireLimitBidListrspTableViewCell *cell = [InquireLimitBidListrspTableViewCell cellWithTableView:tableView WithNumberOfLabels:self.inquireTitlesForProfit.count];
                    
//                    cell.model = inquireLimitBidArr[indexPath.row];
                    if (inquireLimitBidDateArr.count>0) {
                        cell.model = inquireLimitBidDateArr[indexPath.row];
                    }
                    
                    cell.backgroundColor = RGB(30,36,46);
                    cell.textLabel.font = [UIFont systemFontOfSize:11];
                    cell.textLabel.textAlignment = NSTextAlignmentCenter;
                    
                    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
                    cell.selectedBackgroundView.backgroundColor = RGB(24,26,30);
                    
                    return cell;
                }
                if (selectCount == 23) {//查询--成交纪录
                    InquireCloseoutBidListrspTableViewCell *cell = [InquireCloseoutBidListrspTableViewCell cellWithTableView:tableView WithNumberOfLabels:self.inquireTitlesForBargain.count];
                    
//                    cell.model = inquireCloseoutBidArr[indexPath.row];
                    if (inquireCloseoutBidDateArr.count>0) {
                        cell.model = inquireCloseoutBidDateArr[indexPath.row];
                    }
                    
                    cell.backgroundColor = RGB(30,36,46);
                    cell.textLabel.font = [UIFont systemFontOfSize:11];
                    cell.textLabel.textAlignment = NSTextAlignmentCenter;
                    
                    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
                    cell.selectedBackgroundView.backgroundColor = RGB(24,26,30);
                    
                    return cell;
                }
                
                if (selectCount == 30) {//交易--持仓合计
                    WaitBidReportrspTableViewCell *cell = [WaitBidReportrspTableViewCell cellWithTableView:tableView WithNumberOfLabels:self.transactionTitlesForSum.count];
                    
                    //                    cell.model = inquireCloseoutBidArr[indexPath.row];
                    if (waitBidArr.count>0) {
                        cell.model = waitBidArr[indexPath.row];
                        
                        NSLog(@"cell.model.StockID--%@cell.model.TradeType_Id----%@cell.model.Lot---%@cell.model.Price---%@",cell.model.StockID,cell.model.TradeType_Id,cell.model.Lot,cell.model.Price);
                        
                        
                    }
                    
                    cell.backgroundColor = RGB(30,36,46);
                    cell.textLabel.font = [UIFont systemFontOfSize:11];
                    cell.textLabel.textAlignment = NSTextAlignmentCenter;
                    
                    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
                    cell.selectedBackgroundView.backgroundColor = RGB(24,26,30);
                    
                    return cell;
                }
                if (selectCount == 31) {//交易--限价委托
                    TransactionPresetBidListrspTableViewCell *cell = [TransactionPresetBidListrspTableViewCell cellWithTableView:tableView WithNumberOfLabels:self.transactionTitlesForDelegate.count];
                    
                    //                    cell.model = inquireCloseoutBidArr[indexPath.row];
                    if (transactionPresetBidArr.count>0) {
                        cell.model = transactionPresetBidArr[indexPath.row];
                    }
                    
                    cell.backgroundColor = RGB(30,36,46);
                    cell.textLabel.font = [UIFont systemFontOfSize:11];
                    cell.textLabel.textAlignment = NSTextAlignmentCenter;
                    
                    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
                    cell.selectedBackgroundView.backgroundColor = RGB(24,26,30);
                    
                    return cell;
                }
                if (selectCount == 32) {//交易--止损止盈
                    TransactionLimitBidListrspTableViewCell *cell = [TransactionLimitBidListrspTableViewCell cellWithTableView:tableView WithNumberOfLabels:self.transactionTitlesForStopLoss.count];
                    
                    //                    cell.model = inquireCloseoutBidArr[indexPath.row];
                    if (transactionLimitBidArr.count>0) {
                        cell.model = transactionLimitBidArr[indexPath.row];
                    }
                    
                    cell.backgroundColor = RGB(30,36,46);
                    cell.textLabel.font = [UIFont systemFontOfSize:11];
                    cell.textLabel.textAlignment = NSTextAlignmentCenter;
                    
                    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
                    cell.selectedBackgroundView.backgroundColor = RGB(24,26,30);
                    
                    return cell;
                }
                if (selectCount == 33) {//交易--交易明细
                    TransactionBidListrspTableViewCell *cell = [TransactionBidListrspTableViewCell cellWithTableView:tableView WithNumberOfLabels:self.transactionTitlesForBargain.count];
                    
                    //                    cell.model = inquireCloseoutBidArr[indexPath.row];
                    if (transactionBidArr.count>0) {
                        cell.model = transactionBidArr[indexPath.row];
                    }
                    
                    cell.backgroundColor = RGB(30,36,46);
                    cell.textLabel.font = [UIFont systemFontOfSize:11];
                    cell.textLabel.textAlignment = NSTextAlignmentCenter;
                    
                    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
                    cell.selectedBackgroundView.backgroundColor = RGB(24,26,30);
                    
                    return cell;
                }
                if (selectCount == 34) {//交易--止损止盈
                    StopLossAndWinTableViewCell *cell = [StopLossAndWinTableViewCell cellWithTableView:tableView WithNumberOfLabels:4];

                    if (stopLossArr.count>0) {
                        cell.model = stopLossArr[indexPath.row];
                    }
                    
                    cell.backgroundColor = RGB(222,224,227);
                    cell.textLabel.font = [UIFont systemFontOfSize:11];
                    cell.textLabel.textAlignment = NSTextAlignmentCenter;
                    
                    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
                    cell.selectedBackgroundView.backgroundColor = RGB(182,187,194);
                    
                    return cell;
                }
            }
            
    UITableViewCell *cell = [UITableViewCell new];
    
    return cell;


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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (selectCount == 10) {//成交tableview
        if (self.closeoutbidListrspArr.count > 0) {
            return self.closeoutbidListrspArr.count;
        }else {
            return 0;
        }
    }else if (selectCount == 20){//查询 ---交易明细
        if (inquireBidDateArr.count > 0) {
            return inquireBidDateArr.count;
        }else {
            return 0;
        }
        
    }else if (selectCount == 21){//查询 ---委托记录
        if (inquirePresetBidDateArr.count>0) {
            return inquirePresetBidDateArr.count;
        }else {
            return 0;
        }
        
    }else if (selectCount == 22){//查询 ---止损止盈
        if (inquireLimitBidDateArr.count>0) {
            return inquireLimitBidDateArr.count;
        }else {
            return 0;
        }
        
    }else if (selectCount == 23){//查询 ---成交纪录
        if (inquireCloseoutBidDateArr.count>0) {
            return inquireCloseoutBidDateArr.count;
        }else {
            return 0;
        }
        
    }else if (selectCount == 30){//交易 ---持仓合计
        if (waitBidArr.count > 0) {
            return waitBidArr.count;
        }else {
            return 0;
        }
        
    }else if (selectCount == 31){//交易 ---限价委托
        if (transactionPresetBidArr.count > 0) {
            return transactionPresetBidArr.count;
        }else {
            return 0;
        }
        
    }else if (selectCount == 32){//交易 ---止损止盈
        if (transactionLimitBidArr.count > 0) {
            return transactionLimitBidArr.count;
        }else {
            return 0;
        }
        
    }else if (selectCount == 33){//交易 ---交易明细
        if (transactionBidArr.count > 0) {
            return transactionBidArr.count;
        }else {
            return 0;
        }
        
    }else if (selectCount == 34){//交易 ---止损止盈
        if (stopLossArr.count > 0) {
            return stopLossArr.count;
        }else {
            return 0;
        }
        
    }
    return 0;

}

#pragma mark -- 设置左右两个table View的自定义头部View
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (selectCount == 10) {//成交背景view存在
    
        UIView *rightHeaderView = [UIView viewWithLabelNumber:self.bargainTitles.count];
        int i = 0;
        
        for (UILabel *label in rightHeaderView.subviews) {
            label.text = self.bargainTitles[i++];
            label.layer.borderWidth = 1;
            label.layer.borderColor = [RGB(42,55,68) CGColor];
            label.backgroundColor = RGB(30,36,46);
        }
        
        rightHeaderView.backgroundColor = RGB(30,36,46);
        
        
        
        return rightHeaderView;
        
    }
    
    
            if (selectCount == 20) {
             
                
                UIView *rightHeaderView = [UIView viewWithLabelNumber:self.inquireTitlesForDetail.count];
                int i = 0;
                
                for (UILabel *label in rightHeaderView.subviews) {
                    label.text = self.inquireTitlesForDetail[i++];
                    label.layer.borderWidth = 1;
                    label.layer.borderColor = [RGB(42,55,68) CGColor];
                    label.backgroundColor = RGB(30,36,46);
                }
                
//                rightHeaderView.backgroundColor = RGB(30,36,46);
                
                
                return rightHeaderView;
            }
            
            if (selectCount == 21) {
               
                
                UIView *rightHeaderView = [UIView viewWithLabelNumber:self.inquireTitlesForEntrust.count];
                int i = 0;
                
                for (UILabel *label in rightHeaderView.subviews) {
                    label.text = self.inquireTitlesForEntrust[i++];
                    label.layer.borderWidth = 1;
                    label.layer.borderColor = [RGB(42,55,68) CGColor];
                    label.backgroundColor = RGB(30,36,46);
                }
                
//                rightHeaderView.backgroundColor = RGB(30,36,46);
                
                
                
                return rightHeaderView;
            }
            
            if (selectCount == 22) {
               
                UIView *rightHeaderView = [UIView viewWithLabelNumber:self.inquireTitlesForProfit.count];
                int i = 0;
                
                for (UILabel *label in rightHeaderView.subviews) {
                    label.text = self.inquireTitlesForProfit[i++];
                    label.layer.borderWidth = 1;
                    label.layer.borderColor = [RGB(42,55,68) CGColor];
                    label.backgroundColor = RGB(30,36,46);
                }
                
//                rightHeaderView.backgroundColor = RGB(30,36,46);
                
                
                
                return rightHeaderView;
            }
            
            if (selectCount == 23) {
               
                UIView *rightHeaderView = [UIView viewWithLabelNumber:self.inquireTitlesForBargain.count];
                int i = 0;
                
                for (UILabel *label in rightHeaderView.subviews) {
                    label.text = self.inquireTitlesForBargain[i++];
                    label.layer.borderWidth = 1;
                    label.layer.borderColor = [RGB(42,55,68) CGColor];
                    label.backgroundColor = RGB(30,36,46);
                }
                
//                rightHeaderView.backgroundColor = RGB(30,36,46);
                
                
                
                return rightHeaderView;
            }if (selectCount == 30) {
                
                UIView *rightHeaderView = [UIView viewWithLabelNumber:self.transactionTitlesForSum.count];
                int i = 0;
                
                for (UILabel *label in rightHeaderView.subviews) {
                    label.text = self.transactionTitlesForSum[i++];
                    label.layer.borderWidth = 1;
                    label.layer.borderColor = [RGB(42,55,68) CGColor];
                    label.backgroundColor = RGB(30,36,46);
                }
                
                //                rightHeaderView.backgroundColor = RGB(30,36,46);
                
                
                
                return rightHeaderView;
            }if (selectCount == 31) {
                
                UIView *rightHeaderView = [UIView viewWithLabelNumber:self.transactionTitlesForDelegate.count];
                int i = 0;
                
                for (UILabel *label in rightHeaderView.subviews) {
                    label.text = self.transactionTitlesForDelegate[i++];
                    label.layer.borderWidth = 1;
                    label.layer.borderColor = [RGB(42,55,68) CGColor];
                    label.backgroundColor = RGB(30,36,46);
                }
                
                //                rightHeaderView.backgroundColor = RGB(30,36,46);
                
                
                
                return rightHeaderView;
            }if (selectCount == 32) {
                
                UIView *rightHeaderView = [UIView viewWithLabelNumber:self.transactionTitlesForStopLoss.count];
                int i = 0;
                
                for (UILabel *label in rightHeaderView.subviews) {
                    label.text = self.transactionTitlesForStopLoss[i++];
                    label.layer.borderWidth = 1;
                    label.layer.borderColor = [RGB(42,55,68) CGColor];
                    label.backgroundColor = RGB(30,36,46);
                }
                
                //                rightHeaderView.backgroundColor = RGB(30,36,46);
                
                
                
                return rightHeaderView;
            }if (selectCount == 33) {
                
                UIView *rightHeaderView = [UIView viewWithLabelNumber:self.transactionTitlesForBargain.count];
                int i = 0;
                
                for (UILabel *label in rightHeaderView.subviews) {
                    label.text = self.transactionTitlesForBargain[i++];
                    label.layer.borderWidth = 1;
                    label.layer.borderColor = [RGB(42,55,68) CGColor];
                    label.backgroundColor = RGB(30,36,46);
                }
                
                //                rightHeaderView.backgroundColor = RGB(30,36,46);
                
                
                
                return rightHeaderView;
            }if (selectCount == 34) {
                UIView *rightHeaderView = [UIView new];
             
                return rightHeaderView;
            }
    
    
            UIView *rightHeaderView = [UIView new];
            rightHeaderView.backgroundColor = RGB(30,36,46);
    
            return rightHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    //return 35;
    
    if (selectCount == 34) {
        return 0;
    }else{
        return 35;
    }
}

#pragma mark - table view delegate
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    /*
    if (selectCount == 10) {//成交背景view存在
       [self.bargainTV_right selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
//       [self.bargainTV_left selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }else {//查询背景view存在
        [self.inquireTV_right selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
//        [self.inquireTV_left selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
     */

    

    
}

#pragma mark - 两个tableView联动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (selectCount == 10) {//成交背景view存在
//    if (scrollView == self.bargainTV_left) {
//        [self tableView:self.bargainTV_right scrollFollowTheOther:self.bargainTV_left];
//    }else{
//        [self tableView:self.bargainTV_left scrollFollowTheOther:self.bargainTV_right];
//     }
    }else {//查询背景view存在
//        if (scrollView == self.inquireTV_left) {
//            [self tableView:self.inquireTV_right scrollFollowTheOther:self.inquireTV_left];
//        }else{
//            [self tableView:self.inquireTV_left scrollFollowTheOther:self.inquireTV_right];
//        }
    }
    
//    if (scrollView == self.bargainTV_left) {
//       [self tableView:self.bargainTV_right scrollFollowTheOther:self.bargainTV_left];
//    }
//    if (scrollView == self.bargainTV_right) {
//       [self tableView:self.bargainTV_left scrollFollowTheOther:self.bargainTV_right];
//    }
//    if (scrollView == self.inquireTV_left) {
//        [self tableView:self.inquireTV_right scrollFollowTheOther:self.inquireTV_left];
//    }
//    if (scrollView == self.inquireTV_right) {
//        [self tableView:self.inquireTV_left scrollFollowTheOther:self.inquireTV_right];
//    }
    
}

- (void)tableView:(UITableView *)tableView scrollFollowTheOther:(UITableView *)other{
    CGFloat offsetY= other.contentOffset.y;
    CGPoint offset=tableView.contentOffset;
    offset.y=offsetY;
    tableView.contentOffset=offset;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (selectCount == 30) {
        
        if (waitBidArr.count > 0) {
            
            WaitBidReportrspModel  *model = waitBidArr[indexPath.row];
            NSLog(@"waitBidArr--row--%@",model);
            
            NSLog(@"%@--%@--%@",model.StockID,model.Lot,model.TradeType_Id);
            
            pingcangDirection = model.TradeType_Id; 
            
            self.lotTF.text = [NSString stringWithFormat:@"%@",model.Lot];
            
            
            
            NSString  *contractname = [NSString new];
            for (int i = 0; i < contractIDarr.count; i++) {
                NSString   *contractid = contractIDarr[i];
                
                if ([contractid isEqualToString:model.StockID]) {
                    
                    contractname = contractNamearr[i];
                    
                    
                    
                }
            }
            
            NSLog(@"contractname---%@",contractname);
            
            self.contractIDLabel.text = model.StockID;
            self.contractNameLabel.text = contractname;
            
            [dropdownMenu.mainBtn setTitle:self.contractNameLabel.text forState:UIControlStateNormal];
            
            [_addContract setTitle:@"添加自选" forState:UIControlStateNormal];
            
            for (int i = 0; i < chooseByMyselfIDArray.count; i++) {
                
                if ([self.contractIDLabel.text isEqualToString:chooseByMyselfIDArray[i]]) {
                    addContractCount = 1;
                    [_addContract setTitle:@"删除自选" forState:UIControlStateNormal];
                }
            }
            
        }
    }
    if (selectCount == 34) {
        
        if (stopLossArr.count > 0) {
            
            StopLossAndWinModel  *model = stopLossArr[indexPath.row];
            NSLog(@"stopLossArr--row--%@",model);
            
            NSLog(@"%@--%@--%@",model.StockID,model.Lot,model.TradeType_Id);
            
            contractLable.text = model.StockID;
            
            if ([model.TradeType_Id intValue] == 0) {
                directionLable.text = @"卖";
            }else{
                directionLable.text = @"买";
            }
            
            lotTextField.text = [NSString stringWithFormat:@"%@",model.Lot];
            
            
            
            NSString  *contractname = [NSString new];
            for (int i = 0; i < contractIDarr.count; i++) {
                NSString   *contractid = contractIDarr[i];
                
                if ([contractid isEqualToString:model.StockID]) {
                    
                    contractname = contractNamearr[i];
                    
                }
            }
            
            NSLog(@"contractname---%@",contractname);
            
            self.contractIDLabel.text = model.StockID;
            self.contractNameLabel.text = contractname;
            NSLog(@"self.contractIDLabel.text--%@self.contractNameLabel.text%@",self.contractIDLabel.text,self.contractNameLabel.text);
            [dropdownMenu.mainBtn setTitle:self.contractNameLabel.text forState:UIControlStateNormal];
            
            
            [_addContract setTitle:@"添加自选" forState:UIControlStateNormal];
            
            for (int i = 0; i < chooseByMyselfIDArray.count; i++) {
                
                if ([self.contractIDLabel.text isEqualToString:chooseByMyselfIDArray[i]]) {
                    addContractCount = 1;
                    [_addContract setTitle:@"删除自选" forState:UIControlStateNormal];
                }
            }
            
        }
    }
    
}

#pragma mark  ---查询点击触发方法
- (void)btnInquireClick {
    NSLog(@"查询点击触发方法");
    
    NSString  *account = [[NSUserDefaults standardUserDefaults] objectForKey:@"account"];
    
    
    
    
    [fundBGView removeFromSuperview];
    [bargainBGView removeFromSuperview];
    [transactionBGView removeFromSuperview];
    [setBGView removeFromSuperview];
    
    inquireCount += 1;
    
    selectCount = 20;
    
    if (inquireCount%2 == 1) {
        
        [_manager requestForUniversalWithName:@"BidListrsp" WithContent:account withTag:700];//交易明细
        [_manager requestForUniversalWithName:@"PreseBidReport" WithContent:account withTag:710];//委托记录
        [_manager requestForUniversalWithName:@"LimitBidReport" WithContent:account withTag:720];//止损止盈
        [_manager requestForUniversalWithName:@"CloseOutBidListrsp" WithContent:account withTag:730];//成交记录
        
//        selectCount = 20;
        
        _imgV_Inquire.image=[UIImage imageNamed:@"chaxun_1"];
        
        _imgV_Fund.image=[UIImage imageNamed:@"zijin"];
        _imgV_Bargain.image=[UIImage imageNamed:@"chengjiao"];
        _imgV_Transaction.image=[UIImage imageNamed:@"jiaoyi"];
        //        _imgV_Inquire.image=[UIImage imageNamed:@"chaxun"];
        _imgV_Set.image=[UIImage imageNamed:@"shezhi"];
        
        _lab_Fund.textColor = RGB(222,224,227);
        _lab_Transaction.textColor = RGB(222,224,227);
        _lab_Bargain.textColor = RGB(222,224,227);
        _lab_Inquire.textColor = RGB(227,74,80);
        _lab_Set.textColor = RGB(222,224,227);
        
        fundCount = 0;
        bargainCount = 0;
        transactionCount = 0;
        setCount = 0;
        
        InquireView  *inquireView = [[InquireView alloc] initWithFrame:CGRectMake(4, kScreenHeight, kScreenWidth-8, kScreenWidth*1.2213)];
        
        inquireBGView = inquireView;
        
        [self loadInquireTableView];
        
        inquireView.layer.cornerRadius = 5;
        inquireView.layer.borderWidth = 2;
        inquireView.layer.borderColor = [RGB(42,55,68) CGColor];
        
        // 状态栏(statusbar)
        CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
        
        if (rectStatus.size.width > 375) {
            [UIView animateWithDuration:1 animations:^{
                inquireView.bounds = CGRectMake(0, 0, self.view.frame.size.width-8, kScreenWidth*1.244);
                inquireView.center = CGPointMake(self.view.center.x, self.view.center.y*1.155);
                
            } completion:^(BOOL finished) {
                
            }];
            
        }else {
            [UIView animateWithDuration:1 animations:^{
                inquireView.bounds = CGRectMake(0, 0, self.view.frame.size.width-8, kScreenWidth*1.2213);
                inquireView.center = CGPointMake(self.view.center.x, self.view.center.y*1.155);
                
            } completion:^(BOOL finished) {
                
            }];
        }
        
        [self.view addSubview:inquireBGView];
        [self.view bringSubviewToFront:self.view_tabbar];//把界面提高层级
        
    }else {
        
        _imgV_Inquire.image=[UIImage imageNamed:@"chaxun"];
        
        _lab_Inquire.textColor = RGB(222,224,227);
        
        [UIView animateWithDuration:0.3 animations:^{
            inquireBGView.frame = CGRectMake(2, self.view.frame.size.height, self.view.frame.size.width-8, kScreenWidth*1.2213);
        } completion:^(BOOL finished) {
            [inquireBGView removeFromSuperview];
            
            inquireCount = 0;
        }];
    }
}


#pragma mark  ----查询界面的tableview
- (void)loadInquireTableView {
    
    _detailBtnInquire = [UIButton new];
    _detailBtnInquire.frame = CGRectMake(0, 0, (kScreenWidth-8)/4, 32);
//    _detailBtnInquire.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.f green:arc4random()%255/255.f blue:arc4random()%255/255.f alpha:1];
    _detailBtnInquire.backgroundColor = RGB(24,26,30);
    _detailBtnInquire.layer.borderWidth = 1;
    _detailBtnInquire.layer.borderColor = [RGB(42,55,68) CGColor];
    [_detailBtnInquire setTitle:@"交易明细" forState:UIControlStateNormal];
    _detailBtnInquire.titleLabel.font = [UIFont systemFontOfSize:11];
    [_detailBtnInquire addTarget:self action:@selector(inquireSubviewsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _detailBtnInquire.selected = YES;
    _detailBtnInquire.tag = 1050;
    [inquireBGView addSubview:_detailBtnInquire];

    
    _entrustBtnInquire = [UIButton new];
    _entrustBtnInquire.frame = CGRectMake((kScreenWidth-8)/4, 0, (kScreenWidth-8)/4, 32);
//    _entrustBtnInquire.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.f green:arc4random()%255/255.f blue:arc4random()%255/255.f alpha:1];
    _entrustBtnInquire.backgroundColor = [UIColor clearColor];
    _entrustBtnInquire.layer.borderWidth = 1;
    _entrustBtnInquire.layer.borderColor = [RGB(42,55,68) CGColor];
    [_entrustBtnInquire setTitle:@"委托记录" forState:UIControlStateNormal];
    _entrustBtnInquire.titleLabel.font = [UIFont systemFontOfSize:11];
    [_entrustBtnInquire addTarget:self action:@selector(inquireSubviewsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _entrustBtnInquire.selected = NO;
    _entrustBtnInquire.tag = 1051;
    [inquireBGView addSubview:_entrustBtnInquire];
    
    _profitBtnInquire = [UIButton new];
    _profitBtnInquire.frame = CGRectMake((kScreenWidth-8)/2, 0, (kScreenWidth-8)/4, 32);
//    _profitBtnInquire.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.f green:arc4random()%255/255.f blue:arc4random()%255/255.f alpha:1];
    _profitBtnInquire.backgroundColor = [UIColor clearColor];
    _profitBtnInquire.layer.borderWidth = 1;
    _profitBtnInquire.layer.borderColor = [RGB(42,55,68) CGColor];
    [_profitBtnInquire setTitle:@"止损止盈" forState:UIControlStateNormal];
    _profitBtnInquire.titleLabel.font = [UIFont systemFontOfSize:11];
    [_profitBtnInquire addTarget:self action:@selector(inquireSubviewsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _profitBtnInquire.selected = NO;
    _profitBtnInquire.tag = 1052;
    [inquireBGView addSubview:_profitBtnInquire];
    
    
    _bargainBtnInquire = [UIButton new];
    _bargainBtnInquire.frame = CGRectMake((kScreenWidth-8)/4*3, 0, (kScreenWidth-8)/4, 32);
//    _bargainBtnInquire.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.f green:arc4random()%255/255.f blue:arc4random()%255/255.f alpha:1];
    _bargainBtnInquire.backgroundColor = [UIColor clearColor];
    _bargainBtnInquire.layer.borderWidth = 1;
    _bargainBtnInquire.layer.borderColor = [RGB(42,55,68) CGColor];
    [_bargainBtnInquire setTitle:@"平仓纪录" forState:UIControlStateNormal];
    _bargainBtnInquire.titleLabel.font = [UIFont systemFontOfSize:11];
    [_bargainBtnInquire addTarget:self action:@selector(inquireSubviewsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _bargainBtnInquire.selected = NO;
    _bargainBtnInquire.tag = 1053;
    [inquireBGView addSubview:_bargainBtnInquire];
    
    
    UILabel   *chooseDate = [UILabel  new];
    chooseDate.frame = CGRectMake(kScreenWidth*0.061, kScreenWidth*0.139, kScreenWidth*0.139, kScreenWidth*0.035);
    chooseDate.text = @"选择日期";
    chooseDate.textColor = [UIColor whiteColor];
    chooseDate.textAlignment = NSTextAlignmentCenter;
    chooseDate.font = [UIFont systemFontOfSize:12];
    [inquireBGView addSubview:chooseDate];
    
    

    _dateBtn = [UIButton new];
    _dateBtn.frame = CGRectMake(kScreenWidth*0.24, kScreenWidth*0.112, kScreenWidth*0.533, kScreenWidth*0.085);
//    _dateBtn.backgroundColor = [UIColor redColor];
    _dateBtn.layer.borderWidth = 1;
    _dateBtn.layer.borderColor = [RGB(42,55,68) CGColor];
    
    NSDate *select = [NSDate date]; // 获取当前的时间
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"yyyy-MM-dd"; // 设置时间和日期的格式
    NSString *date = [selectDateFormatter stringFromDate:select]; // 把date类型转为设置好格式的string类型
    [_dateBtn setTitle:date forState:UIControlStateNormal];
    
    [_dateBtn addTarget:self action:@selector(datePick:) forControlEvents:UIControlEventTouchUpInside];
    [inquireBGView addSubview:_dateBtn];
    
    
    UIButton   *inquireBtn = [UIButton new];
    inquireBtn.frame = CGRectMake(kScreenWidth*0.813, kScreenWidth*0.112, kScreenWidth*0.109, kScreenWidth*0.085);
    inquireBtn.backgroundColor = RGB(30,36,46);
    inquireBtn.layer.borderWidth = 0.5;
    inquireBtn.layer.borderColor = [RGB(101,110,124) CGColor];
    [inquireBtn setBackgroundImage:[UIImage imageNamed:@"sous"] forState:UIControlStateNormal];
    [inquireBtn addTarget:self action:@selector(inquireBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [inquireBGView addSubview:inquireBtn];
    
    
//    self.inquireTV_left = [[UITableView alloc] init];
//    self.inquireTV_left.frame = CGRectMake(0, kScreenWidth*0.213, BargainLeftTableViewWidth, inquireBGView.frame.size.height-kScreenWidth*0.213);
//    self.inquireTV_left.delegate = self;
//    self.inquireTV_left.dataSource = self;
//    self.inquireTV_left.showsVerticalScrollIndicator = NO;
//    self.inquireTV_left.backgroundColor = RGB(30,36,46);
//    self.inquireTV_left.rowHeight = 35;
//    self.inquireTV_left.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [inquireBGView addSubview:self.inquireTV_left];
    
    
    self.inquireTV_right = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.inquireTitlesForDetail.count * BargainRightLabelWidth, inquireBGView.frame.size.height-kScreenWidth*0.213) style:UITableViewStylePlain];
    self.inquireTV_right.delegate = self;
    self.inquireTV_right.dataSource = self;
    self.inquireTV_right.showsVerticalScrollIndicator = NO;
    self.inquireTV_right.separatorStyle = UITableViewCellSelectionStyleNone;
    self.inquireTV_right.backgroundColor = RGB(30,36,46);
    self.inquireTV_right.rowHeight = 35;
    
    self.inquireScrollView = [[UIScrollView alloc] init];
    self.inquireScrollView.contentSize = CGSizeMake(self.inquireTV_right.bounds.size.width, 0);
    self.inquireScrollView.backgroundColor = RGB(30,36,46);
    self.inquireScrollView.bounces = NO;
    self.inquireScrollView.showsHorizontalScrollIndicator = NO;
    
    
    [self.inquireScrollView addSubview:self.inquireTV_right];
    [inquireBGView addSubview:self.inquireScrollView];
    
    [self.inquireScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(inquireBGView.mas_top).offset(kScreenWidth*0.213);
        make.right.and.bottom.equalTo(inquireBGView);
        make.left.equalTo(inquireBGView.mas_left).offset(0);
    }];
    
}

#pragma mark  ---日期查询按钮
- (void)inquireBtnClick:(UIButton *)sender{
    
//    NSLog(@"9807890-876543567890");
//    
//    NSLog(@"%@",_dateBtn.titleLabel.text);
    
    //交易明细
    inquireBidDateArr = @[].mutableCopy;
    if (inquireBidArr.count > 0) {
        
        for (BidListrspModel *model in inquireBidArr) {
            
            NSLog(@"model.CreateDate---%@",model.CreateDate);
            
            if ([MetaDataTool changeDateWithCompareDay:model.CreateDate WithCurrentDay:_dateBtn.titleLabel.text] == YES) {
                
                
                [inquireBidDateArr addObject:model];
            }
        }
    }
    
    
    //委托纪录
    inquirePresetBidDateArr = @[].mutableCopy;
    if (inquirePresetBidArr.count > 0) {
        
        for (PresetBidListrspModel *model in inquirePresetBidArr) {
            
            NSLog(@"model.CreateDate---%@",model.CreateDate);
            
            if ([MetaDataTool changeDateWithCompareDay:model.CreateDate WithCurrentDay:_dateBtn.titleLabel.text] == YES) {
                
                [inquirePresetBidDateArr addObject:model];
            }
        }
    }
    
    //止损止盈
    inquireLimitBidDateArr = @[].mutableCopy;
    if (inquireLimitBidArr.count > 0) {
        
        for (LimitBidListrspModel *model in inquireLimitBidArr) {
            
            NSLog(@"model.CreateDate---%@",model.CreateDate);
            
            if ([MetaDataTool changeDateWithCompareDay:model.CreateDate WithCurrentDay:_dateBtn.titleLabel.text] == YES) {
                
                [inquireLimitBidDateArr addObject:model];
            }
        }
    }
    
    //成交纪录
    inquireCloseoutBidDateArr = @[].mutableCopy;
    if (inquireCloseoutBidArr.count > 0) {
        
        for (CloseoutBidListrspModel *model in inquireCloseoutBidArr) {
            
            NSLog(@"model.CloseTime---%@",model.CloseTime);
            
            if ([MetaDataTool changeDateWithCompareDay:model.CloseTime WithCurrentDay:_dateBtn.titleLabel.text] == YES) {
                
                [inquireCloseoutBidDateArr addObject:model];
            }
        }
    }
    
   [_inquireTV_right reloadData]; 
    
}

#pragma mark  ---日期选择按钮
- (void)datePick:(UIButton *)sender {
    
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
//    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
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

#pragma mark  --- 查询---
- (void)inquireSubviewsBtnClick:(UIButton *)sender {
    
    
    
    if (sender.tag == 1050) {
       _detailBtnInquire.backgroundColor = RGB(24,26,30);
       _entrustBtnInquire.backgroundColor = [UIColor clearColor];
       _profitBtnInquire.backgroundColor = [UIColor clearColor];
       _bargainBtnInquire.backgroundColor = [UIColor clearColor];
        
//        _detailBtnInquire.selected = YES;
//        _entrustBtnInquire.selected = NO;
//        _profitBtnInquire.selected = NO;
//        _bargainBtnInquire.selected = NO;
        
        selectCount = 20;
//        [_inquireTV_left reloadData];
        [_inquireTV_right reloadData];
        
    }else if (sender.tag == 1051) {
        _detailBtnInquire.backgroundColor = [UIColor clearColor];
        _entrustBtnInquire.backgroundColor = RGB(24,26,30);
        _profitBtnInquire.backgroundColor = [UIColor clearColor];
        _bargainBtnInquire.backgroundColor = [UIColor clearColor];
        
//        _detailBtnInquire.selected = NO;
//        _entrustBtnInquire.selected = YES;
//        _profitBtnInquire.selected = NO;
//        _bargainBtnInquire.selected = NO;
        
        selectCount = 21;
        
//        [_inquireTV_left reloadData];
        [_inquireTV_right reloadData];
        
        
    }else if (sender.tag == 1052) {
        _detailBtnInquire.backgroundColor = [UIColor clearColor];
        _entrustBtnInquire.backgroundColor = [UIColor clearColor];
        _profitBtnInquire.backgroundColor = RGB(24,26,30);
        _bargainBtnInquire.backgroundColor = [UIColor clearColor];
        
//        _detailBtnInquire.selected = NO;
//        _entrustBtnInquire.selected = NO;
//        _profitBtnInquire.selected = YES;
//        _bargainBtnInquire.selected = NO;
        
        selectCount = 22;
        
//        [_inquireTV_left reloadData];
        [_inquireTV_right reloadData];
        
    }else if (sender.tag == 1053) {
        _detailBtnInquire.backgroundColor = [UIColor clearColor];
        _entrustBtnInquire.backgroundColor = [UIColor clearColor];
        _profitBtnInquire.backgroundColor = [UIColor clearColor];
        _bargainBtnInquire.backgroundColor = RGB(24,26,30);
        
//        _detailBtnInquire.selected = NO;
//        _entrustBtnInquire.selected = NO;
//        _profitBtnInquire.selected = NO;
//        _bargainBtnInquire.selected = YES;
        
        selectCount = 23;
        
//        [_inquireTV_left reloadData];
        [_inquireTV_right reloadData];
        
    }else {
        
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
        
        
        _lab_Fund.textColor = RGB(222,224,227);
        _lab_Transaction.textColor = RGB(222,224,227);
        _lab_Bargain.textColor = RGB(222,224,227);
        _lab_Inquire.textColor = RGB(222,224,227);
        _lab_Set.textColor = RGB(227,74,80);
        
        
        fundCount = 0;
        bargainCount = 0;
        transactionCount = 0;
        inquireCount = 0;
        
        setBGView = [UIView new];
        setBGView.frame = CGRectMake(4, kScreenHeight, kScreenWidth-8, kScreenWidth*0.64);
        
        setBGView.layer.cornerRadius = 5;
        setBGView.clipsToBounds = YES;
        
        setBGView.layer.borderWidth = 2;
        setBGView.layer.borderColor = [RGB(42,55,68) CGColor];
        
        [self loadSetBGView];
        
        // 状态栏(statusbar)
        CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
        
        if (rectStatus.size.width > 375) {
            [UIView animateWithDuration:1 animations:^{
                setBGView.bounds = CGRectMake(0, 0, kScreenWidth-8, kScreenWidth*0.64);
                setBGView.center = CGPointMake(self.view.center.x, self.view.center.y*1.49);
                
            } completion:^(BOOL finished) {
                
            }];
            
        }else {
        
            [UIView animateWithDuration:1 animations:^{
            setBGView.bounds = CGRectMake(0, 0, kScreenWidth-8, kScreenWidth*0.64);
            setBGView.center = CGPointMake(self.view.center.x, self.view.center.y*1.48);
            
            } completion:^(BOOL finished) {
            
            }];
        }
        
        
//        setBGView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        setBGView.backgroundColor = RGB(30,36,46);
        
        
        
        [self.view addSubview:setBGView];
        [self.view bringSubviewToFront:self.view_tabbar];//把界面提高层级
        
    }else {
        
        _imgV_Set.image=[UIImage imageNamed:@"shezhi"];
        
        _lab_Set.textColor = RGB(222,224,227);
        
        //        _imgV_Bargain.image=[UIImage imageNamed:@"chengjiao"];
        //        _imgV_Transaction.image=[UIImage imageNamed:@"jiaoyi"];
        //        _imgV_Inquire.image=[UIImage imageNamed:@"chaxun"];
        //        _imgV_Set.image=[UIImage imageNamed:@"shezhi"];
        
        [UIView animateWithDuration:0.3 animations:^{
            setBGView.frame = CGRectMake(4, kScreenHeight, kScreenWidth-8, kScreenWidth*0.64);
        } completion:^(BOOL finished) {
            [setBGView removeFromSuperview];
            
            setCount = 0;
            
        }];
    }
}

- (void)loadSetBGView {
    
    //类型
    UIImageView  *typeImgV = [UIImageView new];
    typeImgV.bounds = CGRectMake(0, 0, 17, 17);
    typeImgV.center = CGPointMake(self.view.center.x*0.2, self.view.center.y*0.08);
    //typeImgV.backgroundColor = [UIColor redColor];
    typeImgV.image = [UIImage imageNamed:@"ic_set_type"];
    [setBGView addSubview:typeImgV];
    
    UILabel  *typeLab = [UILabel new];
    typeLab.bounds = CGRectMake(0, 0, 25, 17);
    typeLab.center = CGPointMake(self.view.center.x*0.35, self.view.center.y*0.08);
    typeLab.backgroundColor = [UIColor clearColor];
    typeLab.text = @"类型";
    typeLab.font = [UIFont systemFontOfSize:12];
    typeLab.textColor = [UIColor whiteColor];
    [setBGView addSubview:typeLab];
    
    UIView  *typeView = [UIView new];
    typeView.bounds = CGRectMake(0, 0, kScreenWidth*0.352, kScreenWidth*0.08);
    typeView.center = CGPointMake(self.view.center.x*0.47, self.view.center.y*0.17);
    typeView.backgroundColor = RGB(24,26,30);
    typeView.layer.cornerRadius = 4;
    typeView.clipsToBounds = YES;
    [setBGView addSubview:typeView];
    
    _kLineBtn = [UIButton new];
    _kLineBtn.frame = CGRectMake(0, 0, typeView.frame.size.width/2-1, kScreenWidth*0.08);
    _kLineBtn.backgroundColor = RGB(24,26,30);
    [_kLineBtn setTitle:@"K线" forState:UIControlStateNormal];
    _kLineBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    _kLineBtn.titleLabel.textColor = [UIColor whiteColor];
    [_kLineBtn addTarget:self action:@selector(kLineBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [typeView addSubview:_kLineBtn];
    
    _timeDivisionBtn = [UIButton new];
    _timeDivisionBtn.frame = CGRectMake(typeView.frame.size.width/2, 0, typeView.frame.size.width/2, kScreenWidth*0.08);
    _timeDivisionBtn.backgroundColor = RGB(42,55,68);
    [_timeDivisionBtn setTitle:@"分时" forState:UIControlStateNormal];
    _timeDivisionBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    _timeDivisionBtn.titleLabel.textColor = [UIColor whiteColor];
    [_timeDivisionBtn addTarget:self action:@selector(timeDivisionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [typeView addSubview:_timeDivisionBtn];
    
    
    //k 线周期
    UIImageView  *kLineImgV = [UIImageView new];
    kLineImgV.bounds = CGRectMake(0, 0, 17, 17);
    kLineImgV.center = CGPointMake(self.view.center.x*0.2, self.view.center.y*0.295);
    //kLineImgV.backgroundColor = [UIColor redColor];
    kLineImgV.image = [UIImage imageNamed:@"ic_set_kline"];
    [setBGView addSubview:kLineImgV];
    
    UILabel  *kLineLab = [UILabel new];
    kLineLab.bounds = CGRectMake(0, 0, 50, 17);
    kLineLab.center = CGPointMake(self.view.center.x*0.42, self.view.center.y*0.295);
    kLineLab.backgroundColor = [UIColor clearColor];
    kLineLab.text = @"K线周期";
    kLineLab.font = [UIFont systemFontOfSize:12];
    kLineLab.textColor = [UIColor whiteColor];
    [setBGView addSubview:kLineLab];
    
    UIView  *kLineView = [UIView new];
    kLineView.bounds = CGRectMake(0, 0, kScreenWidth*0.528, kScreenWidth*0.08);
    kLineView.center = CGPointMake(self.view.center.x*0.64, self.view.center.y*0.394);
    kLineView.backgroundColor = RGB(24,26,30);
    kLineView.layer.cornerRadius = 4;
    kLineView.clipsToBounds = YES;
    [setBGView addSubview:kLineView];
    
    _threeMinuteBtn = [UIButton new];
    _threeMinuteBtn.frame = CGRectMake(0, 0, kLineView.frame.size.width/3-1, kScreenWidth*0.08);
    _threeMinuteBtn.backgroundColor = RGB(24,26,30);
    [_threeMinuteBtn setTitle:@"3分钟" forState:UIControlStateNormal];
    _threeMinuteBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    _threeMinuteBtn.titleLabel.textColor = [UIColor whiteColor];
    [_threeMinuteBtn addTarget:self action:@selector(threeMinuteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [kLineView addSubview:_threeMinuteBtn];
    
    _fiveMinuteBtn = [UIButton new];
    _fiveMinuteBtn.frame = CGRectMake(kLineView.frame.size.width/3, 0, kLineView.frame.size.width/3-1, kScreenWidth*0.08);
    _fiveMinuteBtn.backgroundColor = RGB(42,55,68);
    [_fiveMinuteBtn setTitle:@"5分钟" forState:UIControlStateNormal];
    _fiveMinuteBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    _fiveMinuteBtn.titleLabel.textColor = [UIColor whiteColor];
    [_fiveMinuteBtn addTarget:self action:@selector(fiveMinuteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [kLineView addSubview:_fiveMinuteBtn];
    
    _tenMinuteBtn = [UIButton new];
    _tenMinuteBtn.frame = CGRectMake((kLineView.frame.size.width/3*2), 0, kLineView.frame.size.width/3, kScreenWidth*0.08);
    _tenMinuteBtn.backgroundColor = RGB(42,55,68);
    [_tenMinuteBtn setTitle:@"10分钟" forState:UIControlStateNormal];
    _tenMinuteBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    _tenMinuteBtn.titleLabel.textColor = [UIColor whiteColor];
    [_tenMinuteBtn addTarget:self action:@selector(tenMinuteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [kLineView addSubview:_tenMinuteBtn];
    
    //指标
    UIImageView  *normImgV = [UIImageView new];
    normImgV.bounds = CGRectMake(0, 0, 17, 17);
    normImgV.center = CGPointMake(self.view.center.x*0.2, self.view.center.y*0.51);
    //normImgV.backgroundColor = [UIColor redColor];
    normImgV.image = [UIImage imageNamed:@"ic_set_index"];
    [setBGView addSubview:normImgV];
    
    UILabel  *normLab = [UILabel new];
    normLab.bounds = CGRectMake(0, 0, 25, 17);
    normLab.center = CGPointMake(self.view.center.x*0.35, self.view.center.y*0.51);
    normLab.backgroundColor = [UIColor clearColor];
    normLab.text = @"指标";
    normLab.font = [UIFont systemFontOfSize:12];
    normLab.textColor = [UIColor whiteColor];
    [setBGView addSubview:normLab];
    
    UIView  *normView = [UIView new];
    normView.bounds = CGRectMake(0, 0, kScreenWidth*0.528, kScreenWidth*0.08);
    normView.center = CGPointMake(self.view.center.x*0.64, self.view.center.y*0.61);
    normView.backgroundColor = RGB(24,26,30);
    normView.layer.cornerRadius = 4;
    normView.clipsToBounds = YES;
    [setBGView addSubview:normView];
    
    _MACD_Btn = [UIButton new];
    _MACD_Btn.frame = CGRectMake(0, 0, normView.frame.size.width/3-1, kScreenWidth*0.08);
    _MACD_Btn.backgroundColor = RGB(42,55,68);
    [_MACD_Btn setTitle:@"MACD" forState:UIControlStateNormal];
    _MACD_Btn.titleLabel.font = [UIFont systemFontOfSize:11];
    _MACD_Btn.titleLabel.textColor = [UIColor whiteColor];
    [_MACD_Btn addTarget:self action:@selector(MACD_BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [normView addSubview:_MACD_Btn];
    
    _KDJ_Btn = [UIButton new];
    _KDJ_Btn.frame = CGRectMake(normView.frame.size.width/3, 0, normView.frame.size.width/3-1, kScreenWidth*0.08);
    _KDJ_Btn.backgroundColor = RGB(42,55,68);
    [_KDJ_Btn setTitle:@"KDJ" forState:UIControlStateNormal];
    _KDJ_Btn.titleLabel.font = [UIFont systemFontOfSize:11];
    _KDJ_Btn.titleLabel.textColor = [UIColor whiteColor];
    [_KDJ_Btn addTarget:self action:@selector(KDJ_BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [normView addSubview:_KDJ_Btn];
    
    _VOL_Btn = [UIButton new];
    _VOL_Btn.frame = CGRectMake(normView.frame.size.width/3*2, 0, normView.frame.size.width/3, kScreenWidth*0.08);
    _VOL_Btn.backgroundColor = RGB(24,26,30);
    [_VOL_Btn setTitle:@"VOL" forState:UIControlStateNormal];
    _VOL_Btn.titleLabel.font = [UIFont systemFontOfSize:11];
    _VOL_Btn.titleLabel.textColor = [UIColor whiteColor];
    [_VOL_Btn addTarget:self action:@selector(VOL_BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [normView addSubview:_VOL_Btn];
    
}

#pragma mark  --设置--类型--k线按钮
- (void)kLineBtnClick:(UIButton *)sender {
    self.kLineBtn.backgroundColor = RGB(24,26,30);
//    sender.backgroundColor = RGB(24,26,30);
    self.timeDivisionBtn.backgroundColor = RGB(42,55,68);
    _MACD_Btn.userInteractionEnabled = YES;
    _KDJ_Btn.userInteractionEnabled = YES;
    
}
#pragma mark  --设置--类型--分时按钮
- (void)timeDivisionBtnClick:(UIButton *)sender {
    _kLineBtn.backgroundColor = RGB(42,55,68);
    _timeDivisionBtn.backgroundColor = RGB(24,26,30);
    _MACD_Btn.userInteractionEnabled = NO;
    _KDJ_Btn.userInteractionEnabled = NO;
}
#pragma mark  --设置--周期--3分钟按钮
- (void)threeMinuteBtnClick:(UIButton *)sender {
    _threeMinuteBtn.backgroundColor = RGB(24,26,30);
    _fiveMinuteBtn.backgroundColor = RGB(42,55,68);
    _tenMinuteBtn.backgroundColor = RGB(42,55,68);
}
#pragma mark  --设置--周期--5分钟按钮
- (void)fiveMinuteBtnClick:(UIButton *)sender {
    _threeMinuteBtn.backgroundColor = RGB(42,55,68);
    _fiveMinuteBtn.backgroundColor = RGB(24,26,30);
    _tenMinuteBtn.backgroundColor = RGB(42,55,68);
}
#pragma mark  --设置--周期--10分钟按钮
- (void)tenMinuteBtnClick:(UIButton *)sender {
    _threeMinuteBtn.backgroundColor = RGB(42,55,68);
    _fiveMinuteBtn.backgroundColor = RGB(42,55,68);
    _tenMinuteBtn.backgroundColor = RGB(24,26,30);
}
#pragma mark  --设置--指标--MACD按钮
- (void)MACD_BtnClick:(UIButton *)sender {
    _MACD_Btn.backgroundColor = RGB(24,26,30);
    _KDJ_Btn.backgroundColor = RGB(42,55,68);
    _VOL_Btn.backgroundColor = RGB(42,55,68);
}
#pragma mark  --设置--指标--KDJ按钮
- (void)KDJ_BtnClick:(UIButton *)sender {
    _MACD_Btn.backgroundColor = RGB(42,55,68);
    _KDJ_Btn.backgroundColor = RGB(24,26,30);
    _VOL_Btn.backgroundColor = RGB(42,55,68);
}
#pragma mark  --设置--指标--VOL按钮
- (void)VOL_BtnClick:(UIButton *)sender {
    _MACD_Btn.backgroundColor = RGB(42,55,68);
    _KDJ_Btn.backgroundColor = RGB(42,55,68);
    _VOL_Btn.backgroundColor = RGB(24,26,30);
}

#pragma mark  ---通知--行情数据改变
- (void)changeForResult:(NSNotification*)sender {

    NSArray *results = (NSArray*)sender.object;
    
    //    NSLog(@"通知改变--内容%@",results);
    
    NSDictionary  *dic = (NSDictionary *)sender.object;
    
    if (results.count == 23) {
        
        for (NSString  *str in [dic allKeys]) {
            
            if ([str isEqualToString:@"ContractID"]) {
                
                NSString  *abd = [dic valueForKey:@"ContractID"];
                
                if ([self.contractIDLabel.text isEqualToString:abd]) {
                    
                    //NSLog(@"开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----开始赋值-----");
                    
                    
//                    self.detailTView.lab_left_number1.userInteractionEnabled = YES;
                    self.detailTView.lab_left_number1.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"NewestPrice"]];
//                    NSLog(@"%@",self.detailTView.lab_left_number1.text);
                    
                    //self.detailTView.lab_left_number2.text = [NSString stringWithFormat:@"%@ %@",[dic valueForKey:@"Difference"],[dic valueForKey:@"DifferenceRatio"]];
                    
                    
                    NSString  *diffRatio = [NSString stringWithFormat:@"%@",[dic valueForKey:@"DifferenceRatio"]];
                    float     flot = [diffRatio floatValue];
                    NSString  *difRatio = [NSString stringWithFormat:@"%.2lf%%",flot*100];
                    
//                    NSLog(@"%@",difRatio);
                    NSString  *difference = [NSString stringWithFormat:@"%@",[dic valueForKey:@"Difference"]];
                    float     flotD = [difference floatValue];
                    self.detailTView.lab_left_number2.text = [NSString stringWithFormat:@"%.2f  %@",flotD,difRatio];
                    
                    
                    self.detailTView.lab_Max_number.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"HighestPrice"]];
                    self.detailTView.lab_Sell_number.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"SellPrice"]];
                    self.detailTView.lab_MaxSell_num.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"SellVol"]];
                    
                    self.detailTView.lab_Min_number.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"LowestPrice"]];
                    self.detailTView.lab_Buy_number.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"BuyPrice"]];
                    self.detailTView.lab_MinBuy_num.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"BuyVol"]];
                    
                    
                    if ([[dic valueForKey:@"Difference"] floatValue] > 0) {
                        self.detailTView.lab_left_number1.textColor = RGB(227, 74, 80);
                        self.detailTView.lab_left_number2.textColor = RGB(227, 74, 80);
                        self.detailTView.lab_Sell_number.textColor = RGB(227, 74, 80);
                        self.detailTView.lab_Buy_number.textColor = RGB(227, 74, 80);
                        self.detailTView.lab_MaxSell_num.textColor = RGB(227, 74, 80);
                        self.detailTView.lab_MinBuy_num.textColor = RGB(227, 74, 80);
                    }else if ([[dic valueForKey:@"Difference"] floatValue] < 0) {
                        self.detailTView.lab_left_number1.textColor = RGB(46, 178, 141);
                        self.detailTView.lab_left_number2.textColor = RGB(46, 178, 141);
                        self.detailTView.lab_Sell_number.textColor = RGB(46, 178, 141);
                        self.detailTView.lab_Buy_number.textColor = RGB(46, 178, 141);
                        self.detailTView.lab_MaxSell_num.textColor = RGB(46, 178, 141);
                        self.detailTView.lab_MinBuy_num.textColor = RGB(46, 178, 141);
                    }else {
                        self.detailTView.lab_left_number1.textColor = RGB(255, 255, 255);
                        self.detailTView.lab_left_number2.textColor = RGB(255, 255, 255);
                        self.detailTView.lab_Sell_number.textColor = RGB(255, 255, 255);
                        self.detailTView.lab_Buy_number.textColor = RGB(255, 255, 255);
                        self.detailTView.lab_MaxSell_num.textColor = RGB(255, 255, 255);
                        self.detailTView.lab_MinBuy_num.textColor = RGB(255, 255, 255);
                    }

                }
            }
        }
    }
    
}
#pragma mark  ---通知--资金信息
- (void)accountInfoReportrsp:(NSNotification*)sender {
    NSDictionary  *dic = (NSDictionary *)sender.object;
    
    NSLog(@"accountInfoReportrsp----------------------------------------%@",dic);
    
//    FundView  *fundview = [FundView new];
    
    NSString  *UsableFund = dic[@"UsableFund"];//可用资金
    _fundView.keyongzijinCount.text = [NSString stringWithFormat:@"%.2f",[UsableFund floatValue]];
    
    NSString  *DynamicInterest = dic[@"DynamicInterest"];//可用权益
    _fundView.keyongquanyiCount.text = [NSString stringWithFormat:@"%.2f",[DynamicInterest floatValue]];
    
    NSString  *SelloutProfit = dic[@"SelloutProfit"];//平仓盈亏
    _fundView.pingcangyingkuiCount.text = [NSString stringWithFormat:@"%.2f",[SelloutProfit floatValue]];
    if ([SelloutProfit doubleValue] > 0) {
        _fundView.pingcangyingkuiCount.textColor = RGB(227, 74, 80);
    }else if ([SelloutProfit doubleValue] < 0) {
        _fundView.pingcangyingkuiCount.textColor = RGB(44, 179, 120);
    }else {
        _fundView.pingcangyingkuiCount.textColor = [UIColor whiteColor];
    }
    
    NSString  *PositionProfit = dic[@"PositionProfit"];//持仓盈亏
    _fundView.chicangyingkuiCount.text = [NSString stringWithFormat:@"%.2f",[PositionProfit floatValue]];
    if ([PositionProfit doubleValue] > 0) {
        _fundView.chicangyingkuiCount.textColor = RGB(227, 74, 80);
    }else if ([PositionProfit doubleValue] < 0) {
        _fundView.chicangyingkuiCount.textColor = RGB(44, 179, 120);
    }else {
        _fundView.chicangyingkuiCount.textColor = [UIColor whiteColor];
    }
    
    
    NSString  *AllTradeFee = dic[@"AllTradeFee"];//手续费
    _fundView.shouxufeiCount.text = [NSString stringWithFormat:@"%.2f",[AllTradeFee floatValue]];
    
    NSString  *AllWaitFee = dic[@"AllWaitFee"];//延期费
    _fundView.yanqifeiCount.text = [NSString stringWithFormat:@"%.2f",[AllWaitFee floatValue]];
    
    
    
    NSString  *OccupyFund = dic[@"OccupyFund"];//占用保证资金
    _fundView.baozhengjinCount.text = [NSString stringWithFormat:@"%.2f",[OccupyFund floatValue]];
    
    NSString  *StatusCode = dic[@"StatusCode"];//状态（ 0--正常，1--冻结）
    if ([StatusCode integerValue] == 0) {
        _fundView.status.text = @"正常";
        _fundView.status.textColor = RGB(44, 179, 120);
    }else {
        _fundView.status.text = @"冻结";
        _fundView.status.textColor = RGB(227, 74, 80);
    }
    
    float  floatStr = [SelloutProfit floatValue]+[PositionProfit floatValue]-[AllTradeFee floatValue]-[AllWaitFee floatValue];
    NSString  *zongyingkui = [NSString stringWithFormat:@"%.2f",floatStr];
    _fundView.zongyingkuiCount.text = [NSString stringWithFormat:@"%@",zongyingkui];
    if ([zongyingkui doubleValue] > 0) {
        _fundView.zongyingkuiCount.textColor = RGB(227, 74, 80);
    }else if ([zongyingkui doubleValue] < 0) {
        _fundView.zongyingkuiCount.textColor = RGB(44, 179, 120);
    }else {
        _fundView.zongyingkuiCount.textColor = [UIColor whiteColor];
    }
    
    
    NSString  *StartMoney = dic[@"StartMoney"];//初始资金
    float    floatFX = 1-[UsableFund floatValue]/[StartMoney floatValue];
    NSString  *fengxiandu = [NSString stringWithFormat:@"%.2f%%",floatFX*100];
    _fundView.fengxianduCount.text = [NSString stringWithFormat:@"%@",fengxiandu];
    
    
    //NSLog(@"----->>>>%@-----%@",zongyingkui,fengxiandu);
}
#pragma mark  ---通知--交易明细
- (void)bidListrsp:(NSNotification*)sender {
    
    //NSDictionary  *dic = (NSDictionary *)sender.object;
    
    //NSLog(@"bidListrsp----------------------------------------%@",dic);
    
    NSArray      *array = (NSArray *)sender.object;
    NSLog(@"bidListrsp----------------------------------------%@",array);
    
    if (selectCount == 20) {
        //NSArray      *array = (NSArray *)sender.object;
        //NSLog(@"bidListrsp----------------------------------------%@",array);
        
        
        //    inquireBidNumberArr = @[].mutableCopy;
        inquireBidArr = @[].mutableCopy;
        
        if (array.count > 0) {
            
            
            
            for (NSDictionary  *dic in array) {
                //        NSString  *BidNumber = dic[@"BidNumber"];
                
                //        [inquireBidNumberArr addObject:BidNumber];
                
                BidListrspModel  *model = [BidListrspModel dicInitWithDic:dic];
                
                
                [inquireBidArr addObject:model];
            }
            
            
            NSLog(@"inquireBidArr----------------------------------------%@",inquireBidArr);
            
            //    _inquireScrollView.scrollsToTop = YES;
            //    [_inquireTV_right reloadData];
            //    [_inquireTV_left reloadData];
            
        }
    }else{
        
        //NSArray      *array = (NSArray *)sender.object;
        //NSLog(@"bidListrsp----------------------------------------%@",array);
        
        transactionBidArr = @[].mutableCopy;
        
        if (array.count >0) {
            
            NSDate *date = [NSDate date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterShortStyle];
            [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
            NSString *DateTime = [formatter stringFromDate:date];
            //        NSLog(@"%@============年-月-日  时：分：秒=====================",DateTime);
            
            NSArray  *currentDay = [DateTime componentsSeparatedByString:@" "];
            NSString *currentday = [currentDay firstObject];
            
            for (NSDictionary  *dic in array) {
                //        NSString  *CloseBidNumber = [NSString stringWithFormat:@"%@",dic[@"CloseBidNumber"]];;
                //
                //        [inquireCloseoutBidNumberArr addObject:CloseBidNumber];
                
                TransactionBidListrspModel  *model = [TransactionBidListrspModel dicInitWithDic:dic];
                
                if ([MetaDataTool changeDateWithCurrentHourWithCompareDay:model.CreateDate WithCurrentDay:currentday] == YES) {
                    [transactionBidArr addObject:model];
                }
                
                
            }
            
            
            NSLog(@"transactionBidArr----------------------------------------%@",transactionBidArr);
            
            [_transactionTV reloadData];
        }
    }
    

    
}
#pragma mark  ---通知--委托纪录
- (void)presetBidListrsp:(NSNotification*)sender {
    
    //    NSDictionary  *dic = (NSDictionary *)sender.object;
    
    //NSLog(@"bidListrsp----------------------------------------%@",dic);
    
    
    NSArray      *array = (NSArray *)sender.object;
    NSLog(@"presetBidListrsp----------------------------------------%@",array);
    
    
        
    
    
//    inquirePresetBidNumberArr = @[].mutableCopy;
    inquirePresetBidArr = @[].mutableCopy;
    
    transactionPresetBidArr = @[].mutableCopy;
    
    if (array.count > 0) {
        if (selectCount == 21) {
            for (NSDictionary  *dic in array) {
                //        NSString  *ID = [NSString stringWithFormat:@"%@",dic[@"ID"]];
                
                //        [inquirePresetBidNumberArr addObject:ID];
                
                PresetBidListrspModel  *model = [PresetBidListrspModel dicInitWithDic:dic];
                
                
                [inquirePresetBidArr addObject:model];
            }
            
            
            NSLog(@"inquirePresetBidArr----------------------------------------%@",inquirePresetBidArr);
        }else if (selectCount == 31){
            for (NSDictionary  *dic in array) {
                //        NSString  *ID = [NSString stringWithFormat:@"%@",dic[@"ID"]];
                
                //        [inquirePresetBidNumberArr addObject:ID];
                
                TransactionPresetBidListrspModel  *model = [TransactionPresetBidListrspModel dicInitWithDic:dic];
                
                
                [transactionPresetBidArr addObject:model];
            }
            
            
            NSLog(@"transactionPresetBidArr----------------------------------------%@",transactionPresetBidArr);
            [_transactionTV reloadData];
            
        }else {
            
        }
      
    
    
    //    _inquireScrollView.scrollsToTop = YES;
//    [_inquireTV_right reloadData];
//    [_inquireTV_left reloadData];
        
        }
}
#pragma mark  ---通知--止损止盈
- (void)limitBidListrsp:(NSNotification*)sender {
    
    //    NSDictionary  *dic = (NSDictionary *)sender.object;
    
    //NSLog(@"bidListrsp----------------------------------------%@",dic);
    
    
    NSArray      *array = (NSArray *)sender.object;
    NSLog(@"limitBidListrsp----------------------------------------%@",array);
    
    
        
    
    
//    inquireLimitBidNumberArr = @[].mutableCopy;
    inquireLimitBidArr = @[].mutableCopy;
    transactionLimitBidArr = @[].mutableCopy;
    
    if (array.count > 0) {
        if (selectCount == 22) {
            for (NSDictionary  *dic in array) {
                //        NSString  *ID = [NSString stringWithFormat:@"%@",dic[@"ID"]];
                //
                //        [inquireLimitBidNumberArr addObject:ID];
                
                LimitBidListrspModel  *model = [LimitBidListrspModel dicInitWithDic:dic];
                
                
                [inquireLimitBidArr addObject:model];
            }
            
            
            NSLog(@"inquireLimitBidArr----------------------------------------%@",inquireLimitBidArr);
        }else if (selectCount == 32){
            for (NSDictionary  *dic in array) {
                //        NSString  *ID = [NSString stringWithFormat:@"%@",dic[@"ID"]];
                //
                //        [inquireLimitBidNumberArr addObject:ID];
                
                TransactionLimitBidListrspModel  *model = [TransactionLimitBidListrspModel dicInitWithDic:dic];
                
                
                [transactionLimitBidArr addObject:model];
            }
            
            
            NSLog(@"transactionLimitBidArr----------------------------------------%@",transactionLimitBidArr);
            [_transactionTV reloadData];
        }else {
            
        }
    
    
    //    _inquireScrollView.scrollsToTop = YES;
//    [_inquireTV_right reloadData];
//    [_inquireTV_left reloadData];
        
        }
}
#pragma mark  ---通知--成交纪录
- (void)closeoutbidListrsp:(NSNotification*)sender {
    
    //    NSDictionary  *dic = (NSDictionary *)sender.object;
    
    //NSLog(@"bidListrsp----------------------------------------%@",dic);
    
    if (selectCount == 10) {
        
        NSArray      *array = (NSArray *)sender.object;
        NSLog(@"closeoutbidListrsp-----------111-----------------------------%@",array);
        
        _closeoutbidListrspArr = @[].mutableCopy;
        
        NSMutableArray  *yingkuiArr = @[].mutableCopy;
        NSMutableArray  *shouxufeiArr = @[].mutableCopy;
        NSMutableArray  *chengjiaoArr = @[].mutableCopy;
        
        
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *DateTime = [formatter stringFromDate:date];
//        NSLog(@"%@============年-月-日  时：分：秒=====================",DateTime);
        
        NSArray  *currentDay = [DateTime componentsSeparatedByString:@" "];
        NSString *currentday = [currentDay firstObject];
        
        for (NSDictionary  *dic in array) {
            BargainCloseOutBidListrspModel  *model = [BargainCloseOutBidListrspModel dicInitWithDic:dic];
            
            
            
            
            if ([MetaDataTool changeDateWithCurrentHourWithCompareDay:model.CloseTime WithCurrentDay:currentday] == YES) {
                [_closeoutbidListrspArr addObject:model];
                
                [yingkuiArr addObject:model.CloseProfit];
                [shouxufeiArr addObject:model.TradeFee];
                [chengjiaoArr addObject:model.CloseOutLot];
                
                
            }
            

            
        }
        
        
        int  yingkui = 0;
        for (NSString  *yingkuib in yingkuiArr) {
            yingkui = [yingkuib intValue]+yingkui;
        }
        
//        NSLog(@"kui---%d",yingkui);
        
        int  shouxufei = 0;
        for (NSString  *shouxufeib in shouxufeiArr) {
            shouxufei = [shouxufeib intValue]+shouxufei;
        }
        
        int  chengjiao = 0;
        for (NSString  *chengjiaob in chengjiaoArr) {
            chengjiao = [chengjiaob intValue]+chengjiao;
        }
        
        
        
        if (_closeoutbidListrspArr.count > 0) {
            self.bargainView.yingkui.text = [NSString stringWithFormat:@"平仓盈亏:%d",yingkui];
            self.bargainView.shouxufei.text = [NSString stringWithFormat:@"手续费:%d",shouxufei];
            self.bargainView.chengjiao.text = [NSString stringWithFormat:@"成交手数:%d",chengjiao];
            
            if (yingkui > 0) {
                self.bargainView.yingkui.textColor = RGB(227,74,80);
            }else if (yingkui < 0){
                self.bargainView.yingkui.textColor = RGB(44,179,120);
            }else {
                self.bargainView.yingkui.textColor = RGB(255,255,255);
            }
            
            
        }else {
            self.bargainView.yingkui.text = [NSString stringWithFormat:@"平仓盈亏:%d",0];
            self.bargainView.shouxufei.text = [NSString stringWithFormat:@"手续费:%d",0];
            self.bargainView.chengjiao.text = [NSString stringWithFormat:@"成交手数:%d",0];
        }
        
        
        
        [_bargainTV_right reloadData];
        
    }else {
    
    NSArray      *array = (NSArray *)sender.object;
    NSLog(@"closeoutbidListrsp----------------------------------------%@",array);
    
    
        
    
    
//    inquireCloseoutBidNumberArr = @[].mutableCopy;
    inquireCloseoutBidArr = @[].mutableCopy;
    
    if (array.count >0) {
    
    for (NSDictionary  *dic in array) {
//        NSString  *CloseBidNumber = [NSString stringWithFormat:@"%@",dic[@"CloseBidNumber"]];;
//        
//        [inquireCloseoutBidNumberArr addObject:CloseBidNumber];
        
        CloseoutBidListrspModel  *model = [CloseoutBidListrspModel dicInitWithDic:dic];
        
        
        [inquireCloseoutBidArr addObject:model];
    }
    
    
    NSLog(@"inquireCloseoutBidArr----------------------------------------%@",inquireCloseoutBidArr);
    
    //    _inquireScrollView.scrollsToTop = YES;
//    [_inquireTV_right reloadData];
//    [_inquireTV_left reloadData];
        
        }
    }
}

#pragma mark  ---通知--交易--持仓合计
- (void)waitBidReportrsp:(NSNotification*)sender {
    /*
    NSArray      *array = (NSArray *)sender.object;
    NSLog(@"waitBidReportrsp----------------------------------------%@",array);

    waitBidArr = @[].mutableCopy;
    
    if (array.count > 0) {
        
        
        
        for (NSDictionary  *dic in array) {
            
            NSString  *stockid = dic[@"StockID"];
            NSString  *TradeType_Id = dic[@"TradeType_Id"];
            
            NSLog(@"stockid---%@TradeType_Id----%@",stockid,TradeType_Id);
            
            if(waitBidArr.count>0)
            {
                
                WaitBidReportrspModel  *mol = [WaitBidReportrspModel new];
                for (int i = 0;i < waitBidArr.count; i++) {
                    //NSDictionary *dice=waitBidArr[a];
                    
                    mol =waitBidArr[i];
                    //NSLog(@"mol--?---%@",mol.TradeType_Id);
                    
                    //WaitBidReportrspModel  *model = [WaitBidReportrspModel dicInitWithDic:dice];
                    
                    
                    //NSLog(@"dice----%@",model);
                                        //NSString  *TradeTypeId = [NSString stringWithFormat:@"%@",mol.TradeType_Id];
                    if ([stockid isEqualToString:mol.StockID]&&[TradeType_Id isEqualToString:mol.TradeType_Id]) {
                        
                        NSInteger  lotdic = [dic[@"Lot"] intValue];
                        NSInteger  lotdice=[mol.Lot intValue];
                        
                        float  pricedic=[dic[@"Price"] floatValue];
                        float  pricedice=[mol.Price floatValue];
                        
                        float  resultPrice=(pricedic*lotdic+pricedice*lotdice)/(lotdice+lotdic);
                        NSString  *resultPricee = [NSString stringWithFormat:@"%f",resultPrice];
                        NSLog(@"resultPricee---%@",resultPricee);
                        
                        NSInteger resultlot=lotdic+lotdice;
                        NSString  *resullott = [NSString stringWithFormat:@"%ld",resultlot];
                        NSLog(@"resullott---%@",resullott);
                        
                        mol.Lot = resullott;
                        mol.Price = resultPricee;
                        mol.StockID = mol.StockID;
                        mol.TradeType_Id = mol.TradeType_Id;
                        WaitBidReportrspModel *dol = [WaitBidReportrspModel new];
                        //dol.Lot = resulllot;
                        //dol.Price = [NSString stringWithFormat:@"%@",resultPricee];
                        //dol.StockID = mol.StockID;
                        //dol.TradeType_Id = mol.TradeType_Id;
                        //NSMutableDictionary *replace=@{@"Lot":resulllot,@"Price":resultPricee,@"StockID":stockid,@"TradeType_Id":TradeType_Id,@"Profit":@50}.mutableCopy;
                        NSLog(@"mol--mol--%@",mol);
                        //waitBidArr[i]=mol;
                        dol = mol;
                        NSLog(@"dol.StockID---%@",dol.StockID);
                        NSLog(@"waitBidArr[i]--%@",waitBidArr[i]);
                        //[WaitBidReportrspModel dicInitWithDic:replace];
                        
                        //[waitBidArr replaceObjectAtIndex:0 withObject:model];
                        //[waitBidArr removeObjectAtIndex:0];
                        
                       // WaitBidReportrspModel  *mol = [WaitBidReportrspModel dicInitWithDic:replace];
                        //mol.Lot = resulllot;
                        //mol.Price = resultPricee;
                        //mol.StockID = stock;
                        //mol.TradeType_Id = TradeTypeId;
                        //[waitBidArr addObject:mol];
                        //[waitBidArr replaceObjectAtIndex:i withObject:mol];
                        //[waitBidArr removeObject:model];
                        [waitBidArr removeObjectAtIndex:i];
                        [waitBidArr addObject:dol];
                        [_transactionTV reloadData];
                         NSLog(@"waitBidArr----111------------------------------------%@",waitBidArr);
                      
                    }
                    
                    else
                    {
                        WaitBidReportrspModel  *model = [WaitBidReportrspModel dicInitWithDic:dic];
                        NSLog(@"dic-----%@",dic);
                        NSLog(@"model-----%@",model.StockID);
                        [waitBidArr addObject:model];
                        
                        [_transactionTV reloadData];
                         NSLog(@"waitBidArr----------------------------------------%@",waitBidArr);
  
                    }
                }
            }else
            {
                WaitBidReportrspModel  *model = [WaitBidReportrspModel dicInitWithDic:dic];
                NSLog(@"dic-----%@",dic);
                NSLog(@"model-----%@",model.StockID);
                [waitBidArr addObject:model];
                [_transactionTV reloadData];
            }
            
            
            
            
            
            //WaitBidReportrspModel  *model = [WaitBidReportrspModel dicInitWithDic:dic];
            
            //[waitBidArr addObject:model];
        }
        
        
        NSLog(@"waitBidArr----------------------------------------%@",waitBidArr);
        [_transactionTV reloadData];
        
    }
     */
    
    
    // 临时--
    if (selectCount == 30) {
        NSArray      *array = (NSArray *)sender.object;
        waitBidArr = @[].mutableCopy;
        
        if (array.count > 0) {
            for (NSDictionary  *dic in array) {
                WaitBidReportrspModel  *model = [WaitBidReportrspModel dicInitWithDic:dic];
                [waitBidArr addObject:model];
            }
            
            [_transactionTV reloadData];
        }
    }else{
        NSArray      *array = (NSArray *)sender.object;
        stopLossArr = @[].mutableCopy;
        
        if (array.count > 0) {
            for (NSDictionary  *dic in array) {
                StopLossAndWinModel  *model = [StopLossAndWinModel dicInitWithDic:dic];
                [stopLossArr addObject:model];
            }
            
            [stopLossTV reloadData];
        }
    }
    
    
    /*   使用？？？
    
    NSArray      *array = (NSArray *)sender.object;
    waitBidArr = @[].mutableCopy;
    
    NSMutableArray  *linarr = @[].mutableCopy;
    
    if (array.count > 0) {
        for (NSDictionary  *dic in array) {
            WaitBidReportrspModel  *model = [WaitBidReportrspModel dicInitWithDic:dic];
            [linarr addObject:model];
        }
    }
    
    
    //for (WaitBidReportrspModel  *model in linarr) {
    //    [waitBidArr addObject:model];
    //}
    
    
    NSMutableArray  *array1 = @[].mutableCopy;
    for (NSInteger i = 0; i< linarr.count; i++) {
        WaitBidReportrspModel  *model1 = linarr[i];
        
        for (NSInteger j = linarr.count-1; j>i; j--) {
            WaitBidReportrspModel  *model2 = linarr[j];
            if ([model1.StockID isEqualToString:model2.StockID]&&[model1.TradeType_Id isEqualToString:model2.TradeType_Id]) {
                
                NSInteger  lotdic = [model1.Lot intValue];
                NSInteger  lotdice=[model2.Lot intValue];
                
                float  pricedic=[model1.Price floatValue];
                float  pricedice=[model2.Price floatValue];
                
                float  resultPrice=(pricedic*lotdic+pricedice*lotdice)/(lotdice+lotdic);
                NSString  *resultPricee = [NSString stringWithFormat:@"%f",resultPrice];
                NSLog(@"resultPricee---%@",resultPricee);
                
                NSInteger resultlot=lotdic+lotdice;
                NSString  *resullott = [NSString stringWithFormat:@"%ld",resultlot];
                NSLog(@"resullott---%@",resullott);
                
                model1.Lot = resullott;
                model1.Price = resultPricee;
                //model1.StockID = model1.StockID;
                //model1.TradeType_Id = model1.TradeType_Id;
                
                [linarr removeObject:model2];
                
            }
        }
        
        [array1 addObject:model1];
        NSLog(@"model1.Lot---%@",model1.Lot);
        NSLog(@"model1.Price---%@",model1.Price);
        [waitBidArr addObject:model1];
    }
    
    NSLog(@"array1---%@",array1);
    
    //[waitBidArr removeAllObjects];
    //[waitBidArr addObjectsFromArray: array1];
    
[self.transactionTV reloadData];
    
  */
    
    
    /*
    if (linarr.count > 0) {
        
        WaitBidReportrspModel  *mod = [WaitBidReportrspModel new];
        WaitBidReportrspModel  *model = [WaitBidReportrspModel new];
        for (int i = 0; i < linarr.count; i++) {
           
            mod = linarr[i];
            
            NSString  *stockid = mod.StockID;
            NSString  *typeid = mod.TradeType_Id;
            
            
            
            for (int i = 0; i < waitBidArr.count; i++) {
                model = waitBidArr[i];
                
                if ([stockid isEqualToString:model.StockID]&&[typeid isEqualToString:model.TradeType_Id]) {
                    
                    NSInteger  lotdic = [mod.Lot intValue];
                    NSInteger  lotdice=[model.Lot intValue];
                    
                    float  pricedic=[mod.Price floatValue];
                    float  pricedice=[model.Price floatValue];
                    
                    float  resultPrice=(pricedic*lotdic+pricedice*lotdice)/(lotdice+lotdic);
                    NSString  *resultPricee = [NSString stringWithFormat:@"%f",resultPrice];
                    NSLog(@"resultPricee---%@",resultPricee);
                    
                    NSInteger resultlot=lotdic+lotdice;
                    NSString  *resullott = [NSString stringWithFormat:@"%ld",resultlot];
                    NSLog(@"resullott---%@",resullott);
                    
                    model.Lot = resullott;
                    model.Price = resultPricee;
                    model.StockID = mod.StockID;
                    model.TradeType_Id = mod.TradeType_Id;
                    
                    [waitBidArr removeObjectAtIndex:i];
                    [waitBidArr addObject:model];
                    //waitBidArr[i] = model;
                    //[waitBidArr removeObject:mod];
                    //[waitBidArr replaceObjectAtIndex:i withObject:model];
                    [_transactionTV reloadData];
                }else {
                    
                    [waitBidArr addObject:mod];
                    [_transactionTV reloadData];
                }
                
            }
            
            
        }
    }
    
    */
    
}

#pragma mark  ---通知--交易--成功(限价)
- (void)presetBidAddrspSUCCESS:(NSNotification*)sender {
    
    NSString  *str = sender.object;
    NSLog(@"-----通知--交易--成功(限价)--%@",str);
    
    NSArray   *arr = [str componentsSeparatedByString:@" "];
    NSString  *content = arr[3];
    NSLog(@"content--%@",content);
    
    [AlertView alertViewWithText:content withVC:self];
    
}

#pragma mark  ---通知--交易--成功(市价)
- (void)bidTraderspSUCCESS:(NSNotification*)sender {
    
    NSString  *str = sender.object;
    NSLog(@"-----通知--交易--成功(市价)--%@",str);
    
    NSArray   *arr = [str componentsSeparatedByString:@" "];
    NSString  *content = arr[2];
    NSLog(@"content--%@",content);
    
    [AlertView alertViewWithText:content withVC:self];
    
}

#pragma mark  ---通知--交易--失败
- (void)bidTraderspFAIL:(NSNotification*)sender {
    
    NSString  *str = sender.object;
    NSLog(@"-----通知--交易--失败--%@",str);
    
    NSArray   *arr = [str componentsSeparatedByString:@" "];
    NSString  *content = arr[2];
    NSLog(@"content--%@",content);
    
    [AlertView alertViewWithText:content withVC:self];
    
}

#pragma mark  ---通知--交易--新增止损止盈失败
- (void)limitBidAddrspFAIL:(NSNotification*)sender {
    /*
    NSString  *str = sender.object;
    NSLog(@"-----通知--交易--新增止损止盈失败--%@",str);
    
    NSArray   *arr = [str componentsSeparatedByString:@" "];
    NSString  *content = arr[3];
    NSLog(@"content--%@",content);
    NSArray   *array = [content componentsSeparatedByString:@"!"];
    NSString  *contentStr = array[0];
    */
    [AlertView alertViewWithText:@"新增止损止盈失败" withVC:self];
    
}
#pragma mark  ---通知--交易--新增止损止盈成功
- (void)limitBidAddrspSUCCESS:(NSNotification*)sender {
    
    NSString  *str = sender.object;
    NSLog(@"-----通知--交易--新增止损止盈成功--%@",str);
    
    NSArray   *arr = [str componentsSeparatedByString:@" "];
    NSString  *content = arr[3];
    NSLog(@"content--%@",content);
    
    [AlertView alertViewWithText:content withVC:self];
    
}

#pragma mark  ---键盘控制
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.lotTF resignFirstResponder];
    
    [self.typeTFCount resignFirstResponder];
    
    [lotTextField resignFirstResponder];
    [stopLossTF resignFirstResponder];
    [stopWinTF resignFirstResponder];
    
    if ([self.lotTF.text intValue] <= 0) {
        self.lotTF.text = @"1";
    }
    
    if ([lotTextField.text intValue] <= 0) {
        lotTextField.text = @"1";
    }

}

#pragma mark  ---dealloc
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"changeForResult" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"accountInfoReportrsp" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"bidListrsp" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"presetBidListrsp" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"limitBidListrsp" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"closeoutbidListrsp" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"waitBidReportrsp" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"presetBidAddrspSUCCESS" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"bidTraderspSUCCESS" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"bidTraderspFAIL" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"limitBidAddrspFAIL" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"limitBidAddrspSUCCESS" object:nil];
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
