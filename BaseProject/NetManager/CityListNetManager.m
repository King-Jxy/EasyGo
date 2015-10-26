//
//  CityListNetManager.m
//  BaseProject
//
//  Created by jake on 15/10/24.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "CityListNetManager.h"

@interface CityListNetManager()

@end

static const NSString *APPKEY = @"b6a901979de1bad19fa819d7856afea6";

@implementation CityListNetManager
    
+ (id)getCityListDataCompletionHandle:(void(^)(CityListModel *model,NSError *error))completionHandle{
    NSString *path = @"http://v.juhe.cn/weather/citys";
    NSDictionary *params = @{@"key":APPKEY};
    return [BaseNetManager GET:path parameters:params completionHandler:^(id responseObj, NSError *error) {
//在此处进行数据持久化
       completionHandle([CityListModel objectWithKeyValues:responseObj],error);
    }];
}

@end
