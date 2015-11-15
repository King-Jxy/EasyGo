//
//  CoachViewModel.m
//  EasyGo
//
//  Created by jake on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "CoachViewModel.h"
#import "TripNetManager.h"
#import "CoachModel.h"
#import "CoachStationModel.h"
@implementation CoachViewModel

- (id)getCoachStationDataAtCity:(NSString *)city completionHandle:(void(^)(NSError *error))completionHandle{
    return [TripNetManager getCoachStationListAtCity:city CompletionHandle:^(CoachStationModel *model, NSError *error) {
        self.stationDataArr = [model.result.list copy];
        self.reason = model.reason;
        completionHandle(error);
    }];
    
}

- (id)getCoachS2SListDataFrom:(NSString *)start to:(NSString *)end completionHandle:(void(^)(NSError *error))completionHandle{
    return [TripNetManager getCoachListFromStation:start toStation:end CompletionHandle:^(CoachModel *model, NSError *error) {
        self.s2sDataArr = [model.result.list copy];
        self.reason = model.reason;
        completionHandle(error);
    }];
}

- (CoachResultListModel *)getCoachModelAtIndex:(NSInteger)index{
    return self.s2sDataArr[index];
}

- (CoachStationResultListModel *)getCoachStationModelAtIndex:(NSInteger)index{
    return self.stationDataArr[index];
}

- (NSString *)getStationNameAtIndex:(NSInteger)index{
    return [self getCoachStationModelAtIndex:index].name; 
}

- (NSString *)getStationTeleAtIndex:(NSInteger)index{
    return [self getCoachStationModelAtIndex:index].tel;
}

- (NSString *)getStationAddsAtIndex:(NSInteger)index{
    return [self getCoachStationModelAtIndex:index].adds;
}

- (NSString *)getDateTimeAtIndex:(NSInteger)index{
    return [self getCoachModelAtIndex:index].date;
}

- (NSString *)getArriveStationAtIndex:(NSInteger)index{
    return [self getCoachModelAtIndex:index].arrive;
}

- (NSString *)getPriceAtIndex:(NSInteger)index{
    return [self getCoachModelAtIndex:index].price;
}

- (NSString *)getStartStaionAtIndex:(NSInteger)index{
    return [self getCoachModelAtIndex:index].start;
}
@end
