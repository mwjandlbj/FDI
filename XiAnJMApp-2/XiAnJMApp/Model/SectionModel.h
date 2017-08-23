//
//  SectionModel.h
//  XiAnJMApp
//
//  Created by Kai Wang on 2017/5/19.
//  Copyright © 2017年 Kai Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellModel.h"

@interface SectionModel : NSObject

@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSArray<CellModel*> *cells;
@property(nonatomic,strong) NSMutableArray *mutableCells;

@property(nonatomic,strong) NSString *className;
@property(nonatomic,assign) CGFloat headerhHeight;
@property(nonatomic,assign) CGFloat footerHeight;
@property(nonatomic,strong) NSString *reuseIdentifier;

@property(nonatomic,weak) id delegate;

@property(nonatomic,strong) id userInfo;

@property(nonatomic,assign) BOOL isExpand;

+(instancetype)sectionModelWithTitle:(NSString*)title cells:(NSArray<CellModel*>*)cells;

@end
