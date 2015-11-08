//
//  TrainTimeViewModel.m
//  EasyGo
//
//  Created by jake on 15/11/9.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "TrainTimeViewModel.h"
#import "TripNetManager.h"
@implementation TrainTimeViewModel
- (id)getTrainTimeListDataFromTrainName:(NSString *)name completionHandle:(void(^)(NSError *error))completionHandle{
   return  [TripNetManager getTrainTimeListFromTrainName:name CompletionHandle:^(TrainTimeModel *model, NSError *error) {
        self.dataArr = [model.showapi_res_body.data copy];
        self.basicInfo = model.showapi_res_body.basic;
        completionHandle(error);
    }];

}

- (NSInteger)getCount{
    return self.dataArr.count;
}

- (TrainTimeBodyDataModel *)getStationDataAtIndex:(NSInteger)index{
    return self.dataArr[index];
}

- (NSString *)getStationNameAtIndex:(NSInteger)index{
    return [self getStationDataAtIndex:index].station_name;
}

- (NSString *)getListNumAtIndex:(NSInteger)index{
     return [self getStationDataAtIndex:index].num;
}

- (NSString *)getLishiTimeAtIndex:(NSInteger)index{
     return [self getStationDataAtIndex:index].lishi;
}

- (NSString *)getArriveTimeAtIndex:(NSInteger)index{
    return [self getStationDataAtIndex:index].arrive_time;
}

- (NSString *)getLeaveTimeAtIndex:(NSInteger)index{
    return [self getStationDataAtIndex:index].leave_time;
}

- (NSString *)getBasicInfo{
    return self.basicInfo;
}
@end
