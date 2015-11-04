//
//  WeatherModel.m
//  BaseProject
//
//  Created by jake on 15/10/28.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "WeatherModel.h"

@implementation WeatherModel

@end

@implementation WeatherFutureModel

@end

@implementation WeatherIdModel

@end

@implementation WeatherTodayModel

@end

@implementation WeatherSkModel

@end

@implementation WeatherResultModel
+ (NSDictionary *)objectClassInArray{
    return @{@"future":[WeatherFutureModel class]};
}
@end

