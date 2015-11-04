//
//  TripNetManager.m
//  WeatherNews
//
//  Created by jake on 15/11/4.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "TripNetManager.h"
#define APPKEY  @"690d3b51fb844e9463ddfc7c658b11b0"
@implementation TripNetManager
+ (id)getS2StaionDataFromStart:(NSString *)start toEnd:(NSString *)end CompletionHandle:(void(^)(S2StationModel *model , NSError *error))completionHandle{
    NSString *path = @"http://apis.juhe.cn/train/s2swithprice";
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:start forKey:@"start"];
    [params setObject:end forKey:@"end"];
    [params setObject:APPKEY forKey:@"key"];
    
   return [self GET:path parameters:params completionHandler:^(id responseObj, NSError *error) {
       completionHandle([S2StationModel objectWithKeyValues:responseObj],error);
    }];
}
@end
