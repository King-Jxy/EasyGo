//
//  BusStationModel.m
//  EasyGo
//
//  Created by jake on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BusStationModel.h"

@implementation BusStationModel

@end
@implementation BusStationBodyModel

+ (NSDictionary *)objectClassInArray{
    return @{@"retList" : [BusStationRetlistModel class]};
}

@end


@implementation BusStationRetlistModel

@end


