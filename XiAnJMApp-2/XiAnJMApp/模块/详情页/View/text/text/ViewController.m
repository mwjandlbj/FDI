//
//  ViewController.m
//  text
//
//  Created by Kai Wang on 2017/8/3.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "ViewController.h"
#import "TestModel.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)UITableView    *tableView;

@end

static NSString *CELLID = @"cellIdentifier";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self getData];
    [self createTableView];
}

- (void)createTableView{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CELLID];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID forIndexPath:indexPath];
    TestModel *model = self.dataArr[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@:%@:%@:%@",model.name,model.age,model.sex,model.jiage];
    return cell;
}
- (void)getData{
    NSArray *arr = @[@"白菜",@"大蒜",@"牛肉",@"芹菜",@"咖啡",@"水果"];
    NSMutableArray *muArr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 100; i++) {
        int name = arc4random()%arr.count;
        int jiage = arc4random()%20;
        NSDictionary *dic = @{@"name":arr[name],@"age":@(jiage*2/5),@"sex":[NSString stringWithFormat:@"%d",i],@"jiage":@(jiage)};
        [muArr addObject:dic];
    }
    
    for (NSDictionary *dic in muArr) {
        TestModel *model = [TestModel testModelInitWithDic:dic];
        [self.dataArr addObject:model];
    }
    
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < self.dataArr.count; i++) {
        TestModel *model1 = self.dataArr[i];
        for (NSInteger j = self.dataArr.count-1; j>i; j--) {
            TestModel *model2 = self.dataArr[j];
            if ([model1.name isEqualToString:model2.name]) {
                int jiage1 = [model1.jiage intValue];
                int jiage2 = [model2.jiage intValue];
                model1.jiage = @(jiage1+jiage2);
                [self.dataArr removeObject:model2];
            }
        }
        [array addObject:model1];
    }
    NSLog(@"%@",array);
    
}
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArr;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
