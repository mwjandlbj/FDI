//
//  TestModel.h
//  TableViewSelect
//
//  Created by GDC-DEV-02 on 2017/8/3.
//  Copyright © 2017年 GDC-DEV-02 POPLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestModel : NSObject
@property (nonatomic,copy)NSString *name;
@property (nonatomic,assign)NSNumber *age;
@property (nonatomic,copy)NSString *sex;
@property (nonatomic,assign)NSNumber *jiage;
- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)testModelInitWithDic:(NSDictionary *)dic;
@end
