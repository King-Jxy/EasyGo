//
//  WeatherViewModel.m
//  BaseProject
//
//  Created by jake on 15/10/29.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "WeatherViewModel.h"
#import "WeatherNetManager.h"
#import "CityPicModel.h"
@implementation WeatherViewModel

- (NSMutableArray *)futureData {
    if(_futureData == nil) {
        _futureData = [[NSMutableArray alloc] init];
    }
    return _futureData;
}

- (id)getWeatherDataWithCity:(NSString *)city completionHandle:(void(^)(NSError *error))completionHandle{
    

    return [WeatherNetManager getCityPicDataCity:city CompletionHandle:^(CityPicModel *model, NSError *error) {
        self.imagePath = model.data.image;
//内层获取天气数据，外层获取图片数据
        [WeatherNetManager getWeatherDataCity:city CompletionHandle:^(WeatherModel *model, NSError *error) {
            self.futureData = [model.result.future copy];
            self.skData = model.result.sk;
            self.todayData = model.result.today;
            self.idData = model.result.today.weather_id;
            completionHandle(error);
        }];
        completionHandle(error);
    }];
}

- (NSURL *)getImageURL{
    return [NSURL URLWithString:self.imagePath];
}

- (NSString *)getWeatherIcon{
    return self.idData.fa;
}

- (NSString *)getLocalName{
    return self.todayData.city;
}

- (NSString *)getTemp{
    return self.todayData.temperature;
}

- (NSString *)getWeather{
    return self.todayData.weather;
}

- (NSString *)getDate{
    NSArray *date = [self.todayData.date_y componentsSeparatedByString:@"年"];
    return date[1];
}

- (NSString *)getWeek{
    return self.todayData.week;
}
@end
