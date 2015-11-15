//
//  CoachViewModel.h
//  EasyGo
//
//  Created by jake on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "CoachModel.h"
#import "CoachStationModel.h"
@interface CoachViewModel : BaseViewModel
@property (nonatomic , strong) NSArray *s2sDataArr;
@property (nonatomic , strong) NSArray *stationDataArr;
@property (nonatomic , strong) NSString *reason;

- (id)getCoachStationDataAtCity:(NSString *)city completionHandle:(void(^)(NSError *error))completionHandle;

- (id)getCoachS2SListDataFrom:(NSString *)start to:(NSString *)end completionHandle:(void(^)(NSError *error))completionHandle;

- (NSString *)getStationNameAtIndex:(NSInteger)index;

- (NSString *)getStationTeleAtIndex:(NSInteger)index;

- (NSString *)getStationAddsAtIndex:(NSInteger)index;

- (NSString *)getDateTimeAtIndex:(NSInteger)index;

- (NSString *)getArriveStationAtIndex:(NSInteger)index;

- (NSString *)getPriceAtIndex:(NSInteger)index;

- (NSString *)getStartStaionAtIndex:(NSInteger)index;
@end
