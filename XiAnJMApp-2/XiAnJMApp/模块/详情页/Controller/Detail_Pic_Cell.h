//
//  Detail_Pic_Cell.h
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/23.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Detail_Pic_Cell : UITableViewCell
+(CGFloat)computeHeight:(id)info;
-(void)relayOutUIWithModel:(id)model;
@end
