//
//  CityPicModel.m
//  BaseProject
//
//  Created by jake on 15/10/28.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "CityPicModel.h"

@implementation CityPicModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"aerrno":@"errno"};
}
@end

@implementation CityPicDataModel
+ (NSDictionary *)objectClassInArray{
    return @{@"weather":[CityPicWeatherModel class]};
}

@end

@implementation CityPicWeatherModel


@end

@implementation CityPicPm25Model


@end