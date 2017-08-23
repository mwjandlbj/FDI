//
//  ViewController.m
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/17.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import "ViewController.h"
#import "Common.h"
#import "WKRequestManager+WK.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self BK_API];
    

}




-(void)BK_API{
    NSString *const BKStorePayInfo_URL      = @"http://apis.baidu.com/idl_baidu/clothing_classification/clothing_classificationo";

    
//    NSDictionary *paramDic =  @{@"paymentCode" : @""};
    NSDictionary *paramDic =  nil;

    [[WKRequestManager manager] wkDataRequest:RequestMethodPost URLString:BKStorePayInfo_URL parameters:paramDic success:^(id  _Nullable responseObject) {
        
        BOOL success = [responseObject[@"success"] boolValue];
        
        if (success) {

            NSLog(@"----success-------%@",responseObject);
            
        }else{
            
            NSLog(@"----failure-------%@",responseObject);
            
        }
        
        
    } failure:^(id  _Nullable responseObject, NSError * _Nullable error) {
        NSString *errorMsg;
        if (error.code == -1001) {
            errorMsg = @"请求超时";
        }else if(error.code == 502){
            errorMsg = @"服务器开小差了，请稍后再试！";
        }else{
            errorMsg = @"请求失败";
        }
        NSLog(@"-----errorMsg-----%@",errorMsg);
    }];
    

    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
