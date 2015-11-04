//
//  WeatherNetManager.h
//  BaseProject
//
//  Created by jake on 15/10/28.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseNetManager.h"
#import "CityPicModel.h"
#import "WeatherModel.h"
@interface WeatherNetManager : BaseNetManager
+ (id)getCityPicDataCity:(NSString *)city CompletionHandle:(void(^)(CityPicModel *model,NSError *error))completionHandle;

+ (id)getWeatherDataCity:(NSString *)city CompletionHandle:(void(^)(WeatherModel *model,NSError *error))completionHandle;
@end
