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

+ (NSString *)plistPath {
    NSString *plistPath;
    if(plistPath == nil) {
        //把获取的city文件存储到本地plist文件中
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *cityDataDirectory = [kDocumentPath stringByAppendingPathComponent:@"city"];
        //创建上面定义好的文件夹
        BOOL isSuccess = [fileManager createDirectoryAtPath:cityDataDirectory withIntermediateDirectories:NO attributes:nil error:nil];
        if (isSuccess) {
        //如果文件夹已经存在就不会创建
            DDLogVerbose(@"创建city数据文件夹成功！");
        }
        plistPath = [cityDataDirectory stringByAppendingPathComponent:@"cityData.plist"];
        DDLogVerbose(@"%@",plistPath);
    }
    return plistPath;
}

+ (id)getCityListDataCompletionHandle:(void(^)(CityListModel *model,NSError *error))completionHandle{
//先判断本地有没有数据
    if([[NSFileManager defaultManager] fileExistsAtPath:self.plistPath]){
//从plist文件中读取dic数据
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:self.plistPath];
        completionHandle([CityListModel objectWithKeyValues:dic],nil);
        return nil;
        
    }else{
    
        NSString *path = @"http://v.juhe.cn/weather/citys";
        NSDictionary *params = @{@"key":APPKEY};
        return [BaseNetManager GET:path parameters:params completionHandler:^(id responseObj, NSError *error) {
//在此处进行数据持久化（一定要在解析之前报数据保存到plist文件中）
            //将字典写入plist文件中
            BOOL isSuccess = [responseObj writeToFile:self.plistPath atomically:YES];
            if(isSuccess){
                DDLogVerbose(@"数据持久化成功");
            }
            completionHandle([CityListModel objectWithKeyValues:responseObj],error);
        }];
    }
}

@end
