//
//  Left_Menu.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/23.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "Left_Menu.h"

#define ImageviewWidth    18
#define Frame_Width       self.frame.size.width//200


@interface Left_Menu ()
<
UITableViewDataSource,
UITableViewDelegate
>

@property (nonatomic ,strong)UITableView    *contentTableView;

@end

@implementation Left_Menu


-(instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        [self initView];
    }
    return  self;
}

-(void)initView{
    
    self.backgroundColor=RGB(29,38,48);
    
    
    //添加头部
    UIView *headerView     = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Frame_Width, 90)];
    [headerView setBackgroundColor:RGB(29,38,48) ];
    CGFloat width          = 90/2;
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(12, (90 - width) / 2, width, width)];

    imageview.layer.cornerRadius = imageview.frame.size.width / 2;
    imageview.layer.masksToBounds = YES;
    [imageview setImage:[UIImage imageNamed:@"icon1"]];
    [headerView addSubview:imageview];
    
    
    width                  = 15;
//    UIImageView *arrow     = [[UIImageView alloc]initWithFrame:CGRectMake(Frame_Width - width - 10, (90 - width)/2, width, width)];
//    arrow.contentMode      = UIViewContentModeScaleAspectFit;
//    [arrow setImage:[UIImage imageNamed:@"icon1"]];
//    [headerView addSubview:arrow];
    
    
    _accountLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageview.frame.size.width + imageview.frame.origin.x * 2, imageview.frame.origin.y-10, 90, imageview.frame.size.height)];
    [_accountLabel setText:@"12321321"];
    _accountLabel.font = [UIFont systemFontOfSize:10];
    _accountLabel.textColor = [UIColor whiteColor];
    [headerView addSubview:_accountLabel];
    
    
    _NameLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageview.frame.size.width + imageview.frame.origin.x * 2, imageview.frame.origin.y+5, 90, imageview.frame.size.height)];
    [_NameLabel setText:@"name"];
    _NameLabel.font = [UIFont systemFontOfSize:10];
    _NameLabel.textColor = [UIColor whiteColor];
    [headerView addSubview:_NameLabel];
    
    [self addSubview:headerView];
    
    
    //中间tableview
    UITableView *contentTableView        = [[UITableView alloc]initWithFrame:CGRectMake(0, headerView.frame.size.height, Frame_Width, self.frame.size.height - headerView.frame.size.height * 2)
                                                                       style:UITableViewStylePlain];
    [contentTableView setBackgroundColor:RGB(29,38,48)];
    contentTableView.dataSource          = self;
    contentTableView.delegate            = self;
    contentTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [contentTableView setBackgroundColor:RGB(29,38,48)];
    contentTableView.separatorStyle      = UITableViewCellSeparatorStyleNone;
    contentTableView.tableFooterView = [UIView new];
    self.contentTableView = contentTableView;
    [self addSubview:contentTableView];
    
}


#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = [NSString stringWithFormat:@"LeftView%li",indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if(cell == nil){
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        
    }
    [cell setBackgroundColor:RGB(29,38,48)];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    
//    cell.imageView.layer.cornerRadius = 15;
//    cell.imageView.clipsToBounds = YES;
    
    cell.hidden = NO;
    switch (indexPath.row) {
        case 0:
        {
            [cell.imageView setImage:[UIImage imageNamed:@"icon1"]];
            [cell.textLabel setText:@"全球行情"];
            
        }
            break;
            
        case 1:
        {
            
            [cell.imageView setImage:[UIImage imageNamed:@"icon1"]];
            [cell.textLabel setText:@"信息查询"];
        }
            break;
            
            
        case 2:
        {
            
            [cell.imageView setImage:[UIImage imageNamed:@"icon1"]];
            [cell.textLabel setText:@"通知通告"];
        }
            break;
            
        case 3:
        {
            
            [cell.imageView setImage:[UIImage imageNamed:@"icon1"]];
            [cell.textLabel setText:@"系统设置"];
        }
            break;
            //新增 整车调度
        case 4:{
            
            [cell.imageView setImage:[UIImage imageNamed:@"icon1"]];
            [cell.textLabel setText:@"系统信息"];
        }
            break;
            
            
        case 5:
        {
            
            [cell.imageView setImage:[UIImage imageNamed:@"icon1"]];
            [cell.textLabel setText:@"退出登录"];
        }
            break;
            
            
        default:
            break;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if([self.customDelegate respondsToSelector:@selector(LeftMenuViewClick:)]){
        [self.customDelegate LeftMenuViewClick:indexPath.row];
    }
    
}



@end






















