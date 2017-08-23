//
//  NotificationView.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/7/14.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "NotificationView.h"

#import "NotificationModel.h"
#import "Common.h"


@implementation NotificationView

- (id)initWithPeople:(NotificationModel *)model {
    self = [super init];
    if (self) {
//        self.backgroundColor = [UIColor cyanColor];
        self.frame = CGRectMake(0, 0, kScreenWidth, 80);
        self.tag = VIEWTAG;
        [self setupHeader:@""];
        [self setupTitle:model.Title];
        [self setupTime:model.CreateDate];
        [self setupContent:model.Content];
    }
    return self;
}

#pragma mark  ----创建头像
- (void)setupHeader:(NSString *)imgName {
    UIImageView   *header = [[UIImageView alloc] init];
    header.frame = CGRectMake(17, 14, 14, 14);
    header.backgroundColor = [UIColor redColor];
//    header.clipsToBounds = YES;
//    header.layer.cornerRadius = 50;
    header.image = [UIImage imageNamed:imgName];
    [self addSubview:header];
}
#pragma mark  ---创建标题
- (void)setupTitle:(NSString  *)title {
    UILabel  *label = [[UILabel alloc] init];
    label.frame = CGRectMake(36, 14, kScreenWidth*0.6, 14);
    label.textColor = RGB(0,0,0);
    label.text = title;
    label.font = [UIFont systemFontOfSize:13];
    [self addSubview:label];
}

#pragma mark  ---创建 时间
- (void)setupTime:(NSString  *)time {
    UILabel  *label = [[UILabel alloc] init];
    label.frame = CGRectMake(kScreenWidth-90, 14, 70, 14);
    label.textColor = RGB(153,153,153);
    label.text = time;
    label.font = [UIFont systemFontOfSize:9];
    label.textAlignment = NSTextAlignmentRight;
    [self addSubview:label];
}

#pragma mark  --创建说说
- (void)setupContent:(NSString  *)content {
    
    UILabel  *label = [[UILabel alloc] init];
    label.frame = CGRectMake(17, 35, kScreenWidth-34, 35);
    label.textColor = RGB(153,153,153);
    label.text = content;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:11];
    [self addSubview:label];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
