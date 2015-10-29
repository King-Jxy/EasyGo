//
//  WeatherViewModel.h
//  BaseProject
//
//  Created by jake on 15/10/29.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "CityPicModel.h"
#import "WeatherModel.h"
@interface WeatherViewModel : BaseViewModel
@property (nonatomic , strong) NSString *imagePath;
@property (nonatomic , strong) NSMutableArray *futureData;
@property (nonatomic , strong) WeatherSkModel  *skData;
@property (nonatomic , strong) WeatherTodayModel *todayData;
@property (nonatomic , strong) WeatherIdModel *idData;
- (id)getWeatherDataWithCity:(NSString *)city completionHandle:(void(^)(NSError *error))completionHandle;

- (NSURL *)getImageURL;

- (NSString *)getWeatherIcon;

- (NSString *)getLocalName;

- (NSString *)getTemp;

- (NSString *)getWeather;

- (NSString *)getDate;

- (NSString *)getWeek;
@end
