//
//  TestModel.m
//  TableViewSelect
//
//  Created by GDC-DEV-02 on 2017/8/3.
//  Copyright © 2017年 GDC-DEV-02 POPLiu. All rights reserved.
//

#import "TestModel.h"

@implementation TestModel
- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.name  = [dic objectForKey:@"name"];
        self.age = [dic valueForKey:@"age"];
        self.sex = [dic objectForKey:@"sex"];
        self.jiage = [dic valueForKey:@"jiage"];
    }
    return self;
}
+ (instancetype)testModelInitWithDic:(NSDictionary *)dic{
    return [[TestModel alloc]initWithDic:dic];
}
@end
