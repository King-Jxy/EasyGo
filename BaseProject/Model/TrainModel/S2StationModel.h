//
//  S2StationModel.h
//  WeatherNews
//
//  Created by jake on 15/11/4.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@class S2StationResultModel,S2StationResultListModel,S2StationResultListPrice_ListModel;
@interface S2StationModel : BaseModel

@property (nonatomic, strong) S2StationResultModel *result;

@property (nonatomic, assign) NSInteger error_code;

@property (nonatomic, copy) NSString *reason;

@end
@interface S2StationResultModel : NSObject

@property (nonatomic, strong) NSArray<S2StationResultListModel *> *list;

@end

@interface S2StationResultListModel : NSObject

@property (nonatomic, copy) NSString *run_distance;

@property (nonatomic, copy) NSString *m_train_url;

@property (nonatomic, copy) NSString *start_station;

@property (nonatomic, copy) NSString *end_station;

@property (nonatomic, copy) NSString *end_station_type;

@property (nonatomic, copy) NSString *start_time;

@property (nonatomic, copy) NSString *m_chaxun_url;

@property (nonatomic, copy) NSString *run_time;

@property (nonatomic, copy) NSString *end_time;

@property (nonatomic, strong) NSArray<S2StationResultListPrice_ListModel *> *price_list;

@property (nonatomic, copy) NSString *train_type;

@property (nonatomic, copy) NSString *start_station_type;

@property (nonatomic, copy) NSString *train_no;

@end

@interface S2StationResultListPrice_ListModel : NSObject

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *price_type;

@end

