//
//  BusLineModel.h
//  EasyGo
//
//  Created by jake on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//
//公交线路模型
#import "BaseModel.h"

@class BusLineBodyModel,BusLineRetlistModel;
@interface BusLineModel : BaseModel

@property (nonatomic, strong) BusLineBodyModel *showapi_res_body;

@property (nonatomic, copy) NSString *showapi_res_error;

@property (nonatomic, assign) NSInteger showapi_res_code;

@end
@interface BusLineBodyModel : NSObject

@property (nonatomic, strong) NSArray<BusLineRetlistModel *> *retList;

@property (nonatomic, assign) NSInteger ret_code;

@end

@interface BusLineRetlistModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *info;

@property (nonatomic, copy) NSString *stats;

@property (nonatomic , strong) NSArray *stations;//用于存储站点数组（从stats字符串中获取出来，在viewModel层中处理）

@end

