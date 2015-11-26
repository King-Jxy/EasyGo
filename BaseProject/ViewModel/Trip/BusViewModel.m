//
//  BusViewModel.m
//  EasyGo
//
//  Created by jake on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BusViewModel.h"
#import "TripNetManager.h"
#import "BusLineModel.h"
#import "BusStationModel.h"
@implementation BusViewModel

//对获得的字符串数据进行分段切割获得数组
- (NSArray *)getStationListFromLine:(NSArray *)lineData{
    NSMutableArray *newLineData = [NSMutableArray array];
    for (BusLineRetlistModel *model in lineData) {
        model.stations = [[model.stats componentsSeparatedByString:@";"] copy];
        [newLineData addObject:model];
    }
    return [newLineData copy];
}

- (NSArray *)getBusLineListFromStation:(NSArray *)stationData{
    NSMutableArray *newStationData = [NSMutableArray array];
    for (BusStationRetlistModel *model in stationData) {
        model.lines = [[model.line_names componentsSeparatedByString:@";"] copy];
        [newStationData addObject:model];
    }
    return [newStationData copy];
}

//获取公交线路查询的结果
- (id)getLineDataInCity:(NSString *)city atLine:(NSString *)lineNum completionHandle:(void(^)(NSError *error))completionHandle{
    
    return [TripNetManager getBusLineDataAtCity:city inLine:lineNum CompletionHandle:^(BusLineModel *model, NSError *error) {
        self.res_code = model.showapi_res_code;
        self.res_error = model.showapi_res_error;
        self.lineData = [[self getStationListFromLine:model.showapi_res_body.retList] copy];
        completionHandle(error);
    }];
}
//获取公交站点查询的结果
- (id)getStationDataInCity:(NSString *)city atStation:(NSString *)station completionHandle:(void(^)(NSError *error))completionHandle{
    return [TripNetManager getBusStationDataAtCity:city atStation:station CompletionHandle:^(BusStationModel *model, NSError *error) {
        self.res_code = model.showapi_res_code;
        self.res_error = model.showapi_res_error;
        self.stationData = [[self getBusLineListFromStation:model.showapi_res_body.retList] copy];
        completionHandle(error);
    }];
}

#pragma mark - 线路的数据

- (NSInteger)getLineDataCount{
    return self.lineData.count;
}

- (BusLineRetlistModel *)getLineModelAtIndex:(NSInteger)index{
    return self.lineData[index];
}

- (NSString *)getLineNameAtIndex:(NSInteger)index{
    return [self getLineModelAtIndex:index].name;
}

- (NSString *)getLineInfoAtIndex:(NSInteger)index{
    return [self getLineModelAtIndex:index].info;
}

- (NSArray *)getStationsAtIndex:(NSInteger)index{
    return [self getLineModelAtIndex:index].stations;
}

#pragma mark - 站点的数据

- (BusStationRetlistModel *)getStationModelAtIndex:(NSInteger)index{
    return self.stationData[index];
}

- (NSInteger)getStationDataCount{
    return self.stationData.count;
}

- (NSString *)getStationNameAtIndex:(NSInteger)index{
    return [self getStationModelAtIndex:index].name;
}

- (NSArray *)getStationLineNamesAtIndex:(NSInteger)index{
    return [self getStationModelAtIndex:index].lines;
}
@end
