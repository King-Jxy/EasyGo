//
//  TrainViewModel.m
//  WeatherNews
//
//  Created by jake on 15/11/4.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "TrainViewModel.h"
#import "TripNetManager.h"
#import "LeftTicketModel.h"
@interface TrainViewModel ()
@property (nonatomic , strong) NSArray *trainS2SList;
@property (nonatomic , strong) NSArray *leftTicketDataList;
@property (nonatomic , strong) NSString *errorCode;
@property (nonatomic , strong) NSString *resError;
@end

@implementation TrainViewModel
- (id)getS2StaionDataFromStart:(NSString *)start toEnd:(NSString *)end completionHandle:(void(^)(NSError *error))completionHandle{
    return [TripNetManager getS2StaionDataFromStart:start toEnd:end CompletionHandle:^(S2StationModel *model, NSError *error) {
        self.trainS2SList = model.result.list;
        completionHandle(error);
    }];
}

- (id)getLeftTicketDataFromStation:(NSString *)start toStation:(NSString *)end andDate:(NSString *)date completionHandle:(void(^)(NSError *error))completionHandle{
    return [TripNetManager getLeftTicketDataFromStation:start toStation:end andDate:date CompletionHandle:^(LeftTicketModel *model, NSError *error) {
        self.leftTicketDataList = model.showapi_res_body.data;
        self.errorCode = model.showapi_res_body.error_code;
        self.resError = model.showapi_res_error;
        completionHandle(error);
    }];
}


- (LTBodyDataModel *)getModelAtIndex:(NSInteger)index{
    return self.leftTicketDataList[index];
}

- (NSString *)getStartStationNameAtIndex:(NSInteger)index{
    return [self getModelAtIndex:index].start_station_name;
}

- (NSString *)getEndStationNameAtIndex:(NSInteger)index{
    return [self getModelAtIndex:index].end_station_name;
}
- (NSString *)getPriceOfrwAtIndex:(NSInteger)index{
    return [self getModelAtIndex:index].rw_pri;
}//软卧
- (NSString *)getNumOfrwAtIndex:(NSInteger)index{
    if([[self getModelAtIndex:index].rw_num doubleValue] >= 999){
        return @"有";
    }
    return [self getModelAtIndex:index].rw_num;
}
- (NSString *)getPriceOfywAtIndex:(NSInteger)index{
    return [self getModelAtIndex:index].yw_pri;
}//硬卧
- (NSString *)getNumOfywAtIndex:(NSInteger)index{
    if([[self getModelAtIndex:index].yw_num doubleValue] >= 999){
        return @"有";
    }
    return [self getModelAtIndex:index].yw_num;
}
- (NSString *)getPriceOfyzAtIndex:(NSInteger)index{
    return [self getModelAtIndex:index].yz_pri;
}//硬座
- (NSString *)getNumOfyzAtIndex:(NSInteger)index{
    if([[self getModelAtIndex:index].yz_num doubleValue] >= 999){
        return @"有";
    }
    return [self getModelAtIndex:index].yz_num;
}
- (NSString *)getPriceOfwzAtIndex:(NSInteger)index{
    return [self getModelAtIndex:index].wz_pri;
}//无座
- (NSString *)getNumOfwzAtIndex:(NSInteger)index{
    if([[self getModelAtIndex:index].wz_num doubleValue] >= 999){
        return @"有";
    }
    return [self getModelAtIndex:index].wz_num;
}
- (NSString *)getPriceOfswzAtIndex:(NSInteger)index{
    return [self getModelAtIndex:index].swz_pri;
}//商务
- (NSString *)getNumOfswzAtIndex:(NSInteger)index{
    if([[self getModelAtIndex:index].swz_num doubleValue] >= 999){
        return @"有";
    }
    return [self getModelAtIndex:index].swz_num;
}
- (NSString *)getPriceOfzyAtIndex:(NSInteger)index{
    return [self getModelAtIndex:index].zy_pri;
}//一等
- (NSString *)getNumOfzyAtIndex:(NSInteger)index{
    if([[self getModelAtIndex:index].zy_num doubleValue] >= 999){
        return @"有";
    }
    return [self getModelAtIndex:index].zy_num;
}
- (NSString *)getPriceOfzeAtIndex:(NSInteger)index{
    return [self getModelAtIndex:index].ze_pri;
}//二等
- (NSString *)getNumOfzeAtIndex:(NSInteger)index{
    if([[self getModelAtIndex:index].ze_num doubleValue] >= 999){
        return @"有";
    }
    return [self getModelAtIndex:index].ze_num;
}

- (NSString *)getFromStationNameAtIndex:(NSInteger)index{
    return [self getModelAtIndex:index].from_station_name;
}
- (NSString *)getToStationNameAtIndex:(NSInteger)index{
    return [self getModelAtIndex:index].to_station_name;
}

- (NSString *)getStartTimeAtIndex:(NSInteger)index{
    return [self getModelAtIndex:index].start_time;
}
- (NSString *)getArriveTimeAtIndex:(NSInteger)index{
    return [self getModelAtIndex:index].arrive_time;
}

- (NSString *)getTrainNameAtIndex:(NSInteger)index{
    return [self getModelAtIndex:index].station_train_code;
}
- (NSString *)getLishiTimeAtIndex:(NSInteger)index{
    return [self getModelAtIndex:index].lishi;
}

- (NSString *)getErrorCode{
    return self.errorCode;
}
- (NSInteger)getTrainCount{
    return self.leftTicketDataList.count;
}

- (NSString *)getResError{
    return self.resError;
}

@end

