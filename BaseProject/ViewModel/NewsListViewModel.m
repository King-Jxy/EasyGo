//
//  NewsListViewModel.m
//  BaseProject
//
//  Created by jake on 15/10/29.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "NewsListViewModel.h"
#import "NewsListNetManager.h"
#import "NSString+CalcTime.h"
@implementation NewsListViewModel
- (NSMutableArray *)dataArr {
    if(_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}
- (id)getNewsDataCompletionHandle:(void(^)(NSError *error))completionHandle{
    
    return [NewsListNetManager getNewsListDataCompletionHandle:^(BDNewsModel *model, NSError *error) {
        self.dataArr = [model.data.anews copy];
        completionHandle(error);
    }];
}

- (void)refreshDataCompletionHandle:(void(^)(NSError *error))completionHandle{
    [self getNewsDataCompletionHandle:^(NSError *error) {
        completionHandle(error);
    }];
}

- (void)getModreDataCompletionHandle:(void(^)(NSError *error))completionHandle{
    
}

- (NSInteger)getRowNum{
    return self.dataArr.count;
}

- (BDNewsDetailModel *)getNewsDetailAtIndex:(NSIndexPath *)index{
    return self.dataArr[index.row];
}

- (NSString *)getTitleAtIndex:(NSIndexPath *)index{
    return [self getNewsDetailAtIndex:index].title;
}

- (NSArray *)getImageURLArrAtIndex:(NSIndexPath *)index{

    
    NSMutableArray *arr = [NSMutableArray new];
    NSArray *array =   [BDImageUrlModel prase:[self getNewsDetailAtIndex:index].imageurls];
    for (BDImageUrlModel *urlModel in array) {
        NSURL *url = [NSURL URLWithString:urlModel.url];
        [arr addObject:url];
    }
    return arr;
}

- (NSURL *)getWebURLAtIndex:(NSIndexPath *)index{
   
    return  [NSURL URLWithString:[self getNewsDetailAtIndex:index].url];
}

- (NSInteger)getImageCountAtIndex:(NSIndexPath *)index{
//    NSArray *imgs = [self getNewsDetailAtIndex:index].imageurls;
//    NSArray *imgArr = imgs.firstObject;
    return [self getImageURLArrAtIndex:index].count;
}

- (NSString *)getSiteAtIndex:(NSIndexPath *)index{
    return [self getNewsDetailAtIndex:index].site;
}


- (NSString *)getTimeAgoAtIndex:(NSIndexPath *)index{
    NSString *time = [self getNewsDetailAtIndex:index].ts;
    NSString *timeAge = [NSString timeAgoFromTimestamp:[NSNumber numberWithFloat:[time floatValue]]];
    return timeAge;
}


@end
