//
//  Response.h
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/25.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Response : NSObject
/*
 *
 */
@property (nonatomic,strong) NSString * Status;
@property (nonatomic,assign) NSDate   * TriggedTime;
@property (nonatomic,strong) NSString * CommandName;
@property (nonatomic,strong) NSString * ResponseBody;
@property (nonatomic,strong) NSString * EXResponseBody;
@property (nonatomic,strong) NSString * VersionResponseBody;
@property (nonatomic,strong) NSString * ActualResponseBody;
@property (nonatomic,strong) NSString * pcykResponseBody;
@property (nonatomic,strong) NSString * OriginBody;


-(void)rspMsg:(NSString *)rspmsg;

@end
