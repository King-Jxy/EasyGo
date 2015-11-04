//
//  S2StationModel.m
//  WeatherNews
//
//  Created by jake on 15/11/4.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "S2StationModel.h"

@implementation S2StationModel

@end
@implementation S2StationResultModel

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [S2StationResultListModel class]};
}

@end


@implementation S2StationResultListModel

+ (NSDictionary *)objectClassInArray{
    return @{@"price_list" : [S2StationResultListPrice_ListModel class]};
}

@end


@implementation S2StationResultListPrice_ListModel

@end



