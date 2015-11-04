//
//  NewsListNetManager.m
//  BaseProject
//
//  Created by jake on 15/10/29.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "NewsListNetManager.h"

@implementation NewsListNetManager
+ (id)getNewsListDataCompletionHandle:(void(^)(BDNewsModel *model,NSError *error))completionHandle{
    NSString *path = @"http://api.baiyue.baidu.com/sn/api/newchosenlist?action=1&ln=20";
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([BDNewsModel objectWithKeyValues:responseObj],error);
    }];
}
@end
