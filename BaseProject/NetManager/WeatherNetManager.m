//
//  WeatherNetManager.m
//  BaseProject
//
//  Created by jake on 15/10/28.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "WeatherNetManager.h"

@implementation WeatherNetManager
+ (id)getCityPicDataCity:(NSString *)city CompletionHandle:(void(^)(CityPicModel *model,NSError *error))completionHandle{
//http://api.baiyue.baidu.com/sn/api/weather?city=%E6%9C%9D%E9%98%B3%E5%8C%BA&id=25000&pd=newsplus&sv=5.5.0.1
    NSString *path = @"http://api.baiyue.baidu.com/sn/api/weather";
    
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:city forKey:@"city"];
    [params setObject:@"25000" forKey:@"id"];
    [params setObject:@"newsplus" forKey:@"pd"];
    [params setObject:@"5.5.0.1" forKey:@"sv"];
    return [self GET:path parameters:params completionHandler:^(id responseObj, NSError *error) {
        completionHandle([CityPicModel objectWithKeyValues:responseObj],error);
    }];
}
static const NSString *APPKEY = @"b6a901979de1bad19fa819d7856afea6";

+ (id)getWeatherDataCity:(NSString *)city CompletionHandle:(void(^)(WeatherModel *model,NSError *error))completionHandle{
//http://v.juhe.cn/weather/index?format=2&cityname=%E8%8B%8F%E5%B7%9E&key=b6a901979de1bad19fa819d7856afea6
    NSString *path  = @"http://v.juhe.cn/weather/index";
    NSDictionary *params = @{@"format":@"2",@"cityname":city,@"key":APPKEY};
    return [self GET:path parameters:params completionHandler:^(id responseObj, NSError *error) {
        completionHandle([WeatherModel objectWithKeyValues:responseObj],error);
    }];
}
@end
