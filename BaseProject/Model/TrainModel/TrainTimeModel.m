//
//  TrainTimeModel.m
//  EasyGo
//
//  Created by jake on 15/11/9.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "TrainTimeModel.h"

@implementation TrainTimeModel

@end
@implementation TrainTimeBodyModel

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [TrainTimeBodyDataModel class]};
}

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"desc" : @"description"};
}
@end


@implementation TrainTimeBodyDataModel

@end


