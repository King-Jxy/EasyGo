//
//  TripNetManager.h
//  WeatherNews
//
//  Created by jake on 15/11/4.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseNetManager.h"
#import "S2StationModel.h"
#import "LeftTicketModel.h"
#import "TrainTimeModel.h"
#import "CoachModel.h"
#import "CoachStationModel.h"
#import "BusLineModel.h"
#import "BusStationModel.h"
@interface TripNetManager : BaseNetManager
//获取站到站的数据
+ (id)getS2StaionDataFromStart:(NSString *)start toEnd:(NSString *)end CompletionHandle:(void(^)(S2StationModel *model , NSError *error))completionHandle;
//获取站到站余票查询数据
+ (id)getLeftTicketDataFromStation:(NSString *)start toStation:(NSString *)end andDate:(NSString *)date CompletionHandle:(void(^)(LeftTicketModel *model , NSError *error))completionHandle;
//获取列车时刻表
+ (id)getTrainTimeListFromTrainName:(NSString *)name CompletionHandle:(void(^)(TrainTimeModel *model , NSError *error))completionHandle;
//获取长途汽车站到站查询数据
+ (id)getCoachListFromStation:(NSString *)from toStation:(NSString *)to CompletionHandle:(void(^)(CoachModel *model , NSError *error))completionHandle;
//获取汽车站列表
+ (id)getCoachStationListAtCity:(NSString *)city CompletionHandle:(void(^)(CoachStationModel *model , NSError *error))completionHandle;
//获取公交线路查询数据
+ (id)getBusLineDataAtCity:(NSString *)city inLine:(NSString *)lineNum CompletionHandle:(void(^)(BusLineModel *model , NSError *error))completionHandle;
//获取公交站点查询数据
+ (id)getBusStationDataAtCity:(NSString *)city atStation:(NSString *)station CompletionHandle:(void(^)(BusStationModel *model , NSError *error))completionHandle;
@end
