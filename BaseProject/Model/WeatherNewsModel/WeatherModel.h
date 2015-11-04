//
//  WeatherModel.h
//  BaseProject
//
//  Created by jake on 15/10/28.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"
@class WeatherResultModel,WeatherIdModel;
@interface WeatherModel : BaseModel

@property (nonatomic, strong)WeatherResultModel* result;
@property (nonatomic, strong)NSString* resultcode;
@property (nonatomic, strong)NSString* reason;
@property (nonatomic, strong)NSNumber* error_code;
@end

@interface WeatherFutureModel : BaseModel
@property (nonatomic, strong)NSString* temperature;
@property (nonatomic, strong)WeatherIdModel* weather_id;
@property (nonatomic, strong)NSString* wind;
@property (nonatomic, strong)NSString* week;
@property (nonatomic, strong)NSString* date;
@property (nonatomic, strong)NSString* weather;
@end

@interface WeatherIdModel : BaseModel
@property (nonatomic, strong)NSString* fa;
@property (nonatomic, strong)NSString* fb;
@end

@interface WeatherTodayModel : BaseModel
@property (nonatomic, strong)NSString* temperature;
@property (nonatomic, strong)NSString* dressing_index;
@property (nonatomic, strong)NSString* dressing_advice;
@property (nonatomic, strong)NSString* uv_index;
@property (nonatomic, strong)NSString* comfort_index;
@property (nonatomic, strong)NSString* wind;
@property (nonatomic, strong)NSString* weather;
@property (nonatomic, strong)NSString* city;
@property (nonatomic, strong)NSString* date_y;
@property (nonatomic, strong)NSString* week;
@property (nonatomic, strong)NSString* wash_index;
@property (nonatomic, strong)WeatherIdModel* weather_id;
@property (nonatomic, strong)NSString* travel_index;
@property (nonatomic, strong)NSString* exercise_index;
@property (nonatomic, strong)NSString* drying_index;
@end

@interface WeatherSkModel : BaseModel
@property (nonatomic, strong)NSString* humidity;
@property (nonatomic, strong)NSString* wind_direction;
@property (nonatomic, strong)NSString* temp;
@property (nonatomic, strong)NSString* wind_strength;
@property (nonatomic, strong)NSString* time;
@end

@interface WeatherResultModel : BaseModel
@property (nonatomic, strong)WeatherSkModel* sk;
@property (nonatomic, strong)WeatherTodayModel* today;
@property (nonatomic, strong)NSArray* future;

@end

