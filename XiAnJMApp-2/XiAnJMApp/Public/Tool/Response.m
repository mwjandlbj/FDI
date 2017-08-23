//
//  Response.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/25.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "Response.h"

@implementation Response
-(void)rspMsg:(NSString *)rspmsg{
    
    NSArray *str = [rspmsg componentsSeparatedByString:@" "];
//    NSArray *str2 = [rspmsg componentsSeparatedByString:@"^"];
//    NSArray *str3 = [rspmsg componentsSeparatedByString:@"~"];

    
    
//    String[] str = rspmsg.split(" ");
//    String[] str2 = rspmsg.split("^");
//    String[] str3 = rspmsg.split("~");
    if([rspmsg length]==0)
    {
        return;
    }
    
    _CommandName = str[0];
    
    
    
//    _Status = [str[1] boolValue] ;
    _Status = str[1];
    
    if ([str count]> 2)
    {
        _ResponseBody = str[2];
    }
    
    if ([str count] > 3)
    {
        _EXResponseBody = str[3];
    }
    
    if ([str count] > 4)
    {
        _VersionResponseBody = str[4];
    }
    
//    if([str count]>1){
//        _ActualResponseBody = str2[1];
//    }
//    if ([str count]>1)
//    {
//        _pcykResponseBody = str3[1];
//        
//    }
    
    _OriginBody = rspmsg;
    
    _TriggedTime = [NSDate date];

}



@end




































