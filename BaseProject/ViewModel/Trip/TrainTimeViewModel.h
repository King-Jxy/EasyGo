//
//  TrainTimeViewModel.h
//  EasyGo
//
//  Created by jake on 15/11/9.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "TrainTimeModel.h"
@interface TrainTimeViewModel : BaseViewModel
@property (nonatomic , strong) NSArray *dataArr;
@property (nonatomic , strong) NSString *basicInfo;

- (id)getTrainTimeListDataFromTrainName:(NSString *)name completionHandle:(void(^)(NSError *error))completionHandle;

- (NSInteger)getCount;

- (TrainTimeBodyDataModel *)getStationDataAtIndex:(NSInteger)index;

- (NSString *)getStationNameAtIndex:(NSInteger)index;

- (NSString *)getListNumAtIndex:(NSInteger)index;

- (NSString *)getLishiTimeAtIndex:(NSInteger)index;

- (NSString *)getArriveTimeAtIndex:(NSInteger)index;

- (NSString *)getLeaveTimeAtIndex:(NSInteger)index;

- (NSString *)getBasicInfo;


@end
