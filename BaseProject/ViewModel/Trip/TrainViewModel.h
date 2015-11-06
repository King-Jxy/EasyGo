//
//  TrainViewModel.h
//  WeatherNews
//
//  Created by jake on 15/11/4.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"

@interface TrainViewModel : BaseViewModel
- (id)getS2StaionDataFromStart:(NSString *)start toEnd:(NSString *)end completionHandle:(void(^)(NSError *error))completionHandle;

- (id)getLeftTicketDataFromStation:(NSString *)start toStation:(NSString *)end andDate:(NSString *)date completionHandle:(void(^)(NSError *error))completionHandle;

- (NSString *)getStartStationNameAtIndex:(NSInteger)index;
- (NSString *)getEndStationNameAtIndex:(NSInteger)index;
- (NSString *)getPriceOfrwAtIndex:(NSInteger)index;//软卧
- (NSString *)getNumOfrwAtIndex:(NSInteger)index;
- (NSString *)getPriceOfywAtIndex:(NSInteger)index;//硬卧
- (NSString *)getNumOfywAtIndex:(NSInteger)index;
- (NSString *)getPriceOfyzAtIndex:(NSInteger)index;//硬座
- (NSString *)getNumOfyzAtIndex:(NSInteger)index;
- (NSString *)getPriceOfwzAtIndex:(NSInteger)index;//无座
- (NSString *)getNumOfwzAtIndex:(NSInteger)index;
- (NSString *)getPriceOfswzAtIndex:(NSInteger)index;//商务
- (NSString *)getNumOfswzAtIndex:(NSInteger)index;
- (NSString *)getPriceOfzyAtIndex:(NSInteger)index;//一等
- (NSString *)getNumOfzyAtIndex:(NSInteger)index;
- (NSString *)getPriceOfzeAtIndex:(NSInteger)index;//二等
- (NSString *)getNumOfzeAtIndex:(NSInteger)index;

- (NSString *)getFromStationNameAtIndex:(NSInteger)index;
- (NSString *)getToStationNameAtIndex:(NSInteger)index;

- (NSString *)getStartTimeAtIndex:(NSInteger)index;
- (NSString *)getArriveTimeAtIndex:(NSInteger)index;

- (NSString *)getTrainNameAtIndex:(NSInteger)index;
- (NSString *)getLishiTimeAtIndex:(NSInteger)index;

- (NSString *)getErrorCode;
- (NSInteger)getTrainCount;
@end
