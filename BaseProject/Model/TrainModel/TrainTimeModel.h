//
//  TrainTimeModel.h
//  EasyGo
//
//  Created by jake on 15/11/9.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@class TrainTimeBodyModel,TrainTimeBodyDataModel;
@interface TrainTimeModel : BaseModel

@property (nonatomic, strong) TrainTimeBodyModel *showapi_res_body;

@property (nonatomic, copy) NSString *showapi_res_error;

@property (nonatomic, assign) NSInteger showapi_res_code;

@end
@interface TrainTimeBodyModel : NSObject

@property (nonatomic, copy) NSString *end_time;

@property (nonatomic, strong) NSArray<TrainTimeBodyDataModel *> *data;

@property (nonatomic, copy) NSString *time_all;

@property (nonatomic, copy) NSString *end_station;

@property (nonatomic, copy) NSString *error_code;

@property (nonatomic, copy) NSString *basic;

@property (nonatomic, copy) NSString *start_time;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *ret_code;

@property (nonatomic, copy) NSString *start_station;

@property (nonatomic, copy) NSString *train_type;

@end

@interface TrainTimeBodyDataModel : NSObject

@property (nonatomic, copy) NSString *station_name;

@property (nonatomic, copy) NSString *num;

@property (nonatomic, copy) NSString *lishi;

@property (nonatomic, copy) NSString *arrive_time;

@property (nonatomic, copy) NSString *leave_time;

@end

