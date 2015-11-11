//
//  BusLineModel.m
//  EasyGo
//
//  Created by jake on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BusLineModel.h"

@implementation BusLineModel

@end
@implementation BusLineBodyModel

+ (NSDictionary *)objectClassInArray{
    return @{@"retList" : [BusLineRetlistModel class]};
}

@end


@implementation BusLineRetlistModel

@end


