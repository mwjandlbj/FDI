//
//  Glb_M_VC.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/22.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "Glb_M_VC.h"
#import "UIView+customView.h"
//#import "MetaDataTool.h"
#import "Stock.h"
#import "RightTableViewCell.h"
#import "Common.h"
#import "First_title.h"
//#import "Detail_VC.h"

#import "DetailVC.h"

#import "InformationQueryVC.h"
#import "NotificationVC.h"
#import "SystemSetVC.h"
#import "SystemMessageVC.h"

#import "MenuView.h"
#import "Left_Menu.h"
#import "Nav_Deatil.h"
#import "GCDSocketManager.h"
#import "UDPManager.h"

#define LeftTableViewWidth 100
#define RightLabelWidth 85

#define HEIGHT_NAV    64

@interface Glb_M_VC ()
<

UITableViewDataSource,
First_title_Delegate,
UITableViewDelegate,
HomeMenuViewDelegate,
Nav_Deatil_Delegate

>{
    NSInteger      count;  //记录点击次数
    
    NSMutableArray     *chooseByMyselfIDArray;//自选合约数组
}

@property (nonatomic ,strong)UIView        * view_Back;
@property (nonatomic ,strong)MenuView      * menu_left;

@property (nonatomic,strong) UITableView *tableV_left;
@property (nonatomic,strong) UITableView *tableV_right;
@property (nonatomic,strong) UIScrollView *buttomScrollView;
@property (nonatomic,strong) NSMutableArray *rightTitles;
//@property (nonatomic,strong) NSArray *customStocks;
@property (nonatomic,strong)First_title * view_first_title;
/*
 * 1-自选   2-香港  3-大陆
 */
@property (nonatomic,assign)NSInteger tag_Type;

@property (nonatomic, strong) Nav_Deatil * nav;

@property (nonatomic,strong)GCDSocketManager * socketManager;//tcp
@property (nonatomic, strong)UDPManager * udpManager;//udp

@property (nonatomic, retain) NSMutableArray *allDataArr;//所有合约数组
@property (nonatomic, retain) NSMutableArray *chooseByMyselfArr;//自选合约
@property (nonatomic, retain) NSMutableArray *energyArr;//美能源
@property (nonatomic, retain) NSMutableArray *hangKangArr;//恒升指数
@property (nonatomic, retain) NSMutableArray *chooseByMyselfIDArr;//自选合约ID
@property (nonatomic, retain) NSMutableArray *energyIDArr;//美能源ID
@property (nonatomic, retain) NSMutableArray *hangKangIDArr;//恒升指数ID
@property (nonatomic, retain) NSMutableArray *chooseByMyselfNameArr;//自选合约名称
@property (nonatomic, retain) NSMutableArray *energyNameArr;//美能源名称
@property (nonatomic, retain) NSMutableArray *hangKangNameArr;//恒升指数名称


@property (nonatomic, retain) NSMutableArray *contractIDArray;//合约ID数组

@property (nonatomic, retain) NSMutableArray *contractNameArray;//合约名称数组

@property (nonatomic,strong)UILabel   *promptLable;//提示标签

@end

@implementation Glb_M_VC
#pragma mark - 懒加载属性
//- (NSArray *)customStocks{
//    if (!_customStocks) {
//        _customStocks = [MetaDataTool customStocks];
//    }
//    return _customStocks;
//}

-(NSArray *)rightTitles{
    if (!_rightTitles) {
        _rightTitles = @[ @"合约名称",@"最新价",@"涨跌", @"涨跌幅", @"买一", @"买量", @"卖一", @"卖量",@"成交量",@"持仓量",@"成交额",@"现量",@"最高价",@"最低价", @"今开价",@"昨收价"].mutableCopy;
    }
    return _rightTitles;
}

- (NSMutableArray*)allDataArr{//所有合约数组
    if (!_allDataArr) {
        _allDataArr = @[].mutableCopy;
    }
    return _allDataArr;
}
- (NSMutableArray*)chooseByMyselfArr{//自选合约
    if (!_chooseByMyselfArr) {
        _chooseByMyselfArr = @[].mutableCopy;
    }
    return _chooseByMyselfArr;
}
- (NSMutableArray*)energyArr{//美能源
    if (!_energyArr) {
        _energyArr = @[].mutableCopy;
    }
    return _energyArr;
}
- (NSMutableArray*)hangKangArr{//恒升指数
    if (!_hangKangArr) {
        _hangKangArr = @[].mutableCopy;
    }
    return _hangKangArr;
}
- (NSMutableArray*)chooseByMyselfIDArr{//自选合约ID
    if (!_chooseByMyselfIDArr) {
        _chooseByMyselfIDArr = @[].mutableCopy;
    }
    return _chooseByMyselfIDArr;
}
- (NSMutableArray*)energyIDArr{//美能源ID
    if (!_energyIDArr) {
        _energyIDArr = @[].mutableCopy;
    }
    return _energyIDArr;
}
- (NSMutableArray*)hangKangIDArr{//恒升指数ID
    if (!_hangKangIDArr) {
        _hangKangIDArr = @[].mutableCopy;
    }
    return _hangKangIDArr;
}
- (NSMutableArray*)chooseByMyselfNameArr{//自选合约名称
    if (!_chooseByMyselfNameArr) {
        _chooseByMyselfNameArr = @[].mutableCopy;
    }
    return _chooseByMyselfNameArr;
}
- (NSMutableArray*)energyNameArr{//美能源名称
    if (!_energyNameArr) {
        _energyNameArr = @[].mutableCopy;
    }
    return _energyNameArr;
}
- (NSMutableArray*)hangKangNameArr{//恒升指数名称
    if (!_hangKangNameArr) {
        _hangKangNameArr = @[].mutableCopy;
    }
    return _hangKangNameArr;
}

- (NSMutableArray *)contractIDArray {
    if (!_contractIDArray) {
        _contractIDArray = @[].mutableCopy;
    }
    return _contractIDArray;
}

- (NSMutableArray *)contractNameArray {
    if (!_contractNameArray) {
        _contractNameArray = @[].mutableCopy;
    }
    return _contractNameArray;
}

#pragma mark -
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSArray  *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"chooseByMyselfIDArr"];
    chooseByMyselfIDArray = @[].mutableCopy;
    [chooseByMyselfIDArray addObjectsFromArray:array];
    
    count = 0;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getAllDatas:) name:@"allDatas" object:nil];
}

#pragma mark - 设置主页面
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setProperty];

    [self createUI];
    
    [self LoadData];
    
    UILabel  *label = [UILabel new];
    label.frame = CGRectMake(self.view.frame.size.width/2-50, 25, 100, 30);
    label.font = [UIFont systemFontOfSize:18];
    label.text = @"行 情";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    
    
    self.promptLable = [UILabel new];
    self.promptLable.bounds = CGRectMake(0, 0, kScreenWidth, 35);
    self.promptLable.center = self.view.center;
    self.promptLable.font = [UIFont systemFontOfSize:14];
    self.promptLable.text = @"请添加自选";
    self.promptLable.textAlignment = NSTextAlignmentCenter;
    self.promptLable.textColor = [UIColor blackColor];
    self.promptLable.hidden = YES;
    [self.view addSubview:self.promptLable];

    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeForResult:) name:@"changeForResult" object:nil];
}
#pragma mark==================setProperty======================
-(void)setProperty{
    
    
    self.k_NavBar_Hidden=YES;
    /*
     * 此页面关闭手势策划
     */
    self.k_Pop_Disabled=YES;
    
    _tag_Type=1;
    self.view .backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        self.navigationController.navigationBar.clipsToBounds = NO;
    }

   
    
}


-(void)createUI{
    self.title=@"全球行情";
    self.view.backgroundColor=[UIColor  whiteColor];
    
    
    _view_Back=[[UIView alloc]init];
    [self.view addSubview:_view_Back];
    [_view_Back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(HEIGHT_NAV);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);

    }];
    
    _nav=[[Nav_Deatil alloc]init];
    [self.view addSubview:_nav];
    [_nav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(HEIGHT_NAV);
    }];
    _nav.delegate=self;
    
    
    _view_first_title=[[First_title alloc]init];
    [self.view addSubview:_view_first_title];
    _view_first_title.delegate=self;
    [_view_first_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nav.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(35);
    }];
    
    [self loadLeftTableView];
    [self loadRightTableView];

    
    /*
     * 加载左侧的滑动菜单
     */
    Left_Menu *leftM = [[Left_Menu alloc]initWithFrame:CGRectMake(0, HEIGHT_NAV, ScreenWidth * 0.5, ScreenHeight-HEIGHT_NAV)];
    leftM.customDelegate = self;
    MenuView *menu = [MenuView MenuViewWithDependencyView:self.view MenuView:leftM isShowCoverView:YES];
    self.menu_left = menu;
    

    
}


-(void)LoadData{
    _udpManager=[UDPManager sharedSocketManager];
    [_udpManager connectToServer];
}




-(void)LeftMenuViewClick:(NSInteger)tag{
    [self.menu_left hidenWithAnimation];
//    NSString *tagstr = [NSString stringWithFormat:@"%ld",(long)tag];
//    [[[UIAlertView alloc] initWithTitle:@"提示" message:tagstr delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
    
    if (tag == 1) {
//        NSLog(@"跳转信息查询");
        InformationQueryVC  *informationVC =[InformationQueryVC new];
        [self.navigationController pushViewController:informationVC animated:YES];
    }if (tag == 2) {//通知通告
        NotificationVC  *notificationVC = [NotificationVC new];
        [self.navigationController pushViewController:notificationVC animated:YES];
    }if (tag == 3) {//系统设置
        SystemSetVC  *systemSetVC = [SystemSetVC new];
        [self.navigationController pushViewController:systemSetVC animated:YES];
    }if (tag == 4) {//系统信息
        SystemMessageVC  *systemMessageVC = [SystemMessageVC new];
        [self.navigationController pushViewController:systemMessageVC animated:YES];
    }if (tag == 5) {//退出登陆
        
//        [_manager cutOffSocket];
//        [self.navigationController popViewControllerAnimated:YES];
        UIAlertController  *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您确定要退出登录吗" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction   *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancle];
        
        UIAlertAction   *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            _socketManager = [GCDSocketManager sharedSocketManager];
            [_socketManager cutOffSocket];
            
            [_udpManager cutOffSocket];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alert addAction:sure];
        
        [self presentViewController:alert animated:YES completion:nil];
    }

    
}



//设置分割线顶格
- (void)viewDidLayoutSubviews{
    [self.tableV_left setLayoutMargins:UIEdgeInsetsZero];
    [self.tableV_right setLayoutMargins:UIEdgeInsetsZero];
}
/*
 * 加载左边的TableView
 */
- (void)loadLeftTableView{
  
    self.tableV_left = [[UITableView alloc] init];
    self.tableV_left.delegate = self;
    self.tableV_left.dataSource = self;
    self.tableV_left.showsVerticalScrollIndicator = NO;
    self.tableV_left.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableV_left.rowHeight = 35;
    [self.view addSubview:self.tableV_left];
    
    [self.tableV_left mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top).offset(35+HEIGHT_NAV);
        make.left.and.bottom.equalTo(self.view);
        make.width.equalTo(@(LeftTableViewWidth));
        
    }];
}

- (void)loadRightTableView{
    self.tableV_right = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.rightTitles.count * RightLabelWidth + 20, ScreenHeight-35-HEIGHT_NAV) style:UITableViewStylePlain];
    self.tableV_right.delegate = self;
    self.tableV_right.dataSource = self;
    self.tableV_right.showsVerticalScrollIndicator = NO;
    self.tableV_right.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableV_right.rowHeight = 35;
   
    
    self.buttomScrollView = [[UIScrollView alloc] init];
    
    self.buttomScrollView.contentSize = CGSizeMake(self.tableV_right.bounds.size.width, 0);
    self.buttomScrollView.backgroundColor = [UIColor clearColor];
    self.buttomScrollView.bounces = NO;
    self.buttomScrollView.showsHorizontalScrollIndicator = NO;
    
    [self.buttomScrollView addSubview:self.tableV_right];
    [self.view addSubview:self.buttomScrollView];
    
    [self.buttomScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(35+HEIGHT_NAV);
        make.right.and.bottom.equalTo(self.view);
        make.left.equalTo(self.tableV_left.mas_right);
    }];
    
}

#pragma mark - table view dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableV_left) {
        static NSString *reuseIdentifer = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifer];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifer];
            [self resetSeparatorInsetForCell:cell];
        }
     
        
        if (_tag_Type == 1) {
            Stock *model = self.chooseByMyselfArr[indexPath.row];
            
            cell.textLabel.text = model.ContractID;
            
            cell.textLabel.font = [UIFont systemFontOfSize:11];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }else if (_tag_Type == 2){
            Stock *model = self.energyArr[indexPath.row];
            
            cell.textLabel.text = model.ContractID;
            
            cell.textLabel.font = [UIFont systemFontOfSize:11];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }else{
            Stock *model = self.hangKangArr[indexPath.row];
            
            cell.textLabel.text = model.ContractID;
            
            cell.textLabel.font = [UIFont systemFontOfSize:11];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
        
        return cell;
    }else{
        RightTableViewCell *cell = [RightTableViewCell cellWithTableView:tableView WithNumberOfLabels:self.rightTitles.count];
        
        if (_tag_Type == 1) {
            cell.model = self.chooseByMyselfArr[indexPath.row];
        }else if (_tag_Type == 2){
            cell.model = self.energyArr[indexPath.row];
        }else{
            cell.model = self.hangKangArr[indexPath.row];
        }
        
        return cell;
    }
    
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
    if (_tag_Type==1) {
        if (self.chooseByMyselfArr.count > 0) {
            self.promptLable.hidden = YES;
            return self.chooseByMyselfArr.count;
        }else{
            self.promptLable.hidden = NO;
            return 0;
        }
    }else if (_tag_Type==2){
        self.promptLable.hidden = YES;
        return self.energyArr.count;
    }else{
        self.promptLable.hidden = YES;
        return self.hangKangArr.count;;
    }
    
}
#pragma mark -- 设置左右两个table View的自定义头部View
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.tableV_right) {
        UIView *rightHeaderView = [UIView viewWithLabelNumber:self.rightTitles.count];
        int i = 0;
        
        for (UILabel *label in rightHeaderView.subviews) {
            label.text = self.rightTitles[i++];
        }

        rightHeaderView.backgroundColor = [UIColor lightGrayColor];
        return rightHeaderView;
    }else{
        UIView *leftHeaderView = [UIView viewWithLabelNumber:1];
        [leftHeaderView.subviews.lastObject setText:@"合约ID"];
        leftHeaderView.backgroundColor = [UIColor lightGrayColor];
        return leftHeaderView;
    }
}
//必须实现以下方法才可以使用自定义头部
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}

#pragma MARK - notifacation-所有数据
- (void)getAllDatas:(NSNotification*)sender{
    
    NSArray *results = (NSArray*)sender.object;
    
    
    NSLog(@"chooseByMyselfIDArray--%@",chooseByMyselfIDArray);
    
    for (NSDictionary *dict in results) {
        
        Stock *model = [Stock dicInitWithDic:dict];
        //[self.allDataArr addObject:model];
        //NSLog(@"model.ContractID--%@",model.ContractID);
        

        [self.contractIDArray addObject:model.ContractID];
        
        [self.contractNameArray addObject:model.ContractName];
        
        
        for (int i = 0; i < chooseByMyselfIDArray.count; i++) {
            
            
            if ([model.ContractID isEqualToString:chooseByMyselfIDArray[i]]) {
                [self.chooseByMyselfArr addObject:model];
                [self.chooseByMyselfIDArr addObject:model.ContractID];
                [self.chooseByMyselfNameArr addObject:model.ContractName];
            }
        }
        
        //区分
        
        if ([self rangeAmericaEnergy:model.ContractID] == YES) {//美能源
            [self.energyArr addObject:model];
            [self.energyIDArr addObject:model.ContractID];
            [self.energyNameArr addObject:model.ContractName];
        }
        
        if ([self rangeHangKang:model.ContractID] == YES) {//恒指
            [self.hangKangArr addObject:model];
            [self.hangKangIDArr addObject:model.ContractID];
            [self.hangKangNameArr addObject:model.ContractName];
        }
        
        
    }
    
    //NSLog(@"self.energyArr--%@self.hangKangArr---%@",self.energyArr,self.hangKangArr);
    
    //存合约名称 和id
    [[NSUserDefaults standardUserDefaults] setObject:self.contractIDArray forKey:@"contractID"];
    [[NSUserDefaults standardUserDefaults] setObject:self.contractNameArray forKey:@"contractName"];
    
    
    [_tableV_right reloadData];
    [_tableV_left reloadData];
}

#pragma mark  -- 筛选美能源
- (BOOL)rangeAmericaEnergy:(NSString *)name {
    
    if ([name containsString:@"IPBRN"] ||[name containsString:@"IPGAS"] ||[name containsString:@"NECL"] ||[name containsString:@"NEHO"] ||[name containsString:@"NENG"] ||[name containsString:@"NEQM"] ||[name containsString:@"NERB"]) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark  -- 筛选恒指
- (BOOL)rangeHangKang:(NSString *)name {
    
    if ([name containsString:@"HIHHI"] ||[name containsString:@"HIHSI"] ||[name containsString:@"HIMCH"] ||[name containsString:@"HIMHI"]) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark  ----NSNotification
- (void)changeForResult:(NSNotification*)sender{
    
    NSArray *results = (NSArray*)sender.object;
//
////    NSLog(@"通知改变--内容%@",results);
    
    NSDictionary  *dic = (NSDictionary *)sender.object;
    
//    NSLog(@"%@",dic);
    
//    NSLog(@"%lu",(unsigned long)results.count);
//    
    if (results.count == 23) {
//        NSLog(@"单一改变出现");
        
//        for (NSString  *string in results) {
//            NSLog(@"%@----%@",string,string.capitalizedString);
//            
//        }
        for (NSString *str in [dic allKeys]) {
//            NSLog(@"%@",str);
            
            if ([str isEqualToString:@"ContractID"]) {
                
                
                NSString  *abd = [dic valueForKey:@"ContractID"];
                
                if (_tag_Type == 1) {
                    for (int i = 0; i < self.chooseByMyselfIDArr.count; i++) {
                        
                        if ([abd isEqualToString:[NSString stringWithFormat:@"%@",self.contractIDArray[i]]]) {
                            
                            Stock *model = [Stock dicInitWithDic:dic];
                            
                            [self.chooseByMyselfArr replaceObjectAtIndex:i withObject:model];
                            
                        }
                    }
                }else if (_tag_Type == 2){
                    for (int i = 0; i < self.energyIDArr.count; i++) {
                        
                        if ([abd isEqualToString:[NSString stringWithFormat:@"%@",self.energyIDArr[i]]]) {
                            
                            Stock *model = [Stock dicInitWithDic:dic];
                            
                            [self.energyArr replaceObjectAtIndex:i withObject:model];
                        }
                    }
                }else {
                    for (int i = 0; i < self.hangKangIDArr.count; i++) {
                        
                        if ([abd isEqualToString:[NSString stringWithFormat:@"%@",self.hangKangIDArr[i]]]) {
                            
                            Stock *model = [Stock dicInitWithDic:dic];
                            
                            [self.hangKangArr replaceObjectAtIndex:i withObject:model];
                        }
                    }
                }
            
            }
        }
        
    }
    
    [_tableV_right reloadData];

}



#pragma mark - table view delegate
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableV_right selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [self.tableV_left selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark - 两个tableView联动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableV_left) {
        [self tableView:self.tableV_right scrollFollowTheOther:self.tableV_left];
    }else{
        [self tableView:self.tableV_left scrollFollowTheOther:self.tableV_right];
    }
}

- (void)tableView:(UITableView *)tableView scrollFollowTheOther:(UITableView *)other{
    CGFloat offsetY= other.contentOffset.y;
    CGPoint offset=tableView.contentOffset;
    offset.y=offsetY;
    tableView.contentOffset=offset;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailVC * VC = [[DetailVC alloc]init];
    
    VC.view.backgroundColor = [UIColor whiteColor];
    
    if (_tag_Type==1) {
        VC.contractNameLabel.text = self.chooseByMyselfNameArr[indexPath.row];
        VC.contractIDLabel.text = self.chooseByMyselfIDArr[indexPath.row];
    }else if (_tag_Type==2){
        VC.contractNameLabel.text = self.energyNameArr[indexPath.row];
        VC.contractIDLabel.text = self.energyIDArr[indexPath.row];
    }else{
        VC.contractNameLabel.text = self.hangKangNameArr[indexPath.row];
        VC.contractIDLabel.text = self.hangKangIDArr[indexPath.row];
    }
    
    
    
    
    [self.navigationController pushViewController:VC animated:YES];
    
    
}

#pragma mark=============First_title_Delegate=============
-(void)Btn_First_title:(NSInteger)tag{
    _tag_Type=tag-100;
    [_tableV_left   reloadData];
    [_tableV_right  reloadData];
    NSLog(@"------------------------------%ld",(long)tag);
    
}



#pragma mark  ---左上角点击
-(void)Btn_Nav_Deatil{
    
    count +=1;
    
    if (count%2 == 1) {
        [self.menu_left show];
    }else {
        [self.menu_left hidenWithAnimation];
    }
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"allDatas" object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"changeForResult" object:nil];
}

@end
















































