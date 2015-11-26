//
//  BusViewModel.h
//  EasyGo
//
//  Created by jake on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"

@interface BusViewModel : BaseViewModel
@property (nonatomic , strong) NSArray *lineData;//元素类型为BusLineRetlistModel
@property (nonatomic , strong) NSArray *stationData;//元素类型为BusStationRetlistModel
@property (nonatomic ) NSInteger res_code;//查询结果代码
@property (nonatomic , strong) NSString *res_error;//错误原因
//获取公交线路查询的结果
- (id)getLineDataInCity:(NSString *)city atLine:(NSString *)lineNum completionHandle:(void(^)(NSError *error))completionHandle;
//获取公交站点查询的结果
- (id)getStationDataInCity:(NSString *)city atStation:(NSString *)station completionHandle:(void(^)(NSError *error))completionHandle;

#pragma mark - 线路的数据

- (NSInteger)getLineDataCount;

- (NSString *)getLineNameAtIndex:(NSInteger)index;

- (NSString *)getLineInfoAtIndex:(NSInteger)index;

- (NSArray *)getStationsAtIndex:(NSInteger)index;

#pragma mark - 站点的数据

- (NSInteger)getStationDataCount;

- (NSString *)getStationNameAtIndex:(NSInteger)index;

- (NSArray *)getStationLineNamesAtIndex:(NSInteger)index;

@end
