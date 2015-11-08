//
//  TripNetManager.m
//  WeatherNews
//
//  Created by jake on 15/11/4.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "TripNetManager.h"
#define APPKEY  @"690d3b51fb844e9463ddfc7c658b11b0"//聚合
#define APPID @11924
#define APPSIGN @"1e1b0ab55ac445ceab6d06266783ee50"//易源数据showapi
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

+ (id)getLeftTicketDataFromStation:(NSString *)start toStation:(NSString *)end andDate:(NSString *)date CompletionHandle:(void(^)(LeftTicketModel *model , NSError *error))completionHandle{
    //https://route.showapi.com/832-1?date=2015-11-06&from=温州&showapi_appid=11919&showapi_timestamp=20151106001849&to=丽水&showapi_sign=1a830c4e4e73c19685301b5ba248bb90
   
    NSString *path = @"http://route.showapi.com/832-1";
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:start forKey:@"from"];
    [params setObject:end forKey:@"to"];
    [params setObject:[self getTimestamp] forKey:@"showapi_timestamp"];
    [params setObject:date forKey:@"date"];
    [params setObject:APPID forKey:@"showapi_appid"];
    [params setObject:APPSIGN forKey:@"showapi_sign"];
    
    return [self GET:path parameters:params completionHandler:^(id responseObj, NSError *error) {
        completionHandle([LeftTicketModel objectWithKeyValues:responseObj],error);
    }];
    
}

//https://route.showapi.com/832-2?showapi_appid=11919&showapi_timestamp=20151109041652&train_num=k102&showapi_sign=b9019ef4f75ea0130f7e764acfdcb9f2

+ (id)getTrainTimeListFromTrainName:(NSString *)name CompletionHandle:(void(^)(TrainTimeModel *model , NSError *error))completionHandle{
    NSString *path = @"https://route.showapi.com/832-2";
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:APPID forKey:@"showapi_appid"];
    [params setObject:APPSIGN forKey:@"showapi_sign"];
    [params setObject:[self getTimestamp] forKey:@"showapi_timestamp"];
    [params setObject:name forKey:@"train_num"];

    return [self GET:path parameters:params completionHandler:^(id responseObj, NSError *error) {
        completionHandle([TrainTimeModel objectWithKeyValues:responseObj],error);
    }];
}
@end
