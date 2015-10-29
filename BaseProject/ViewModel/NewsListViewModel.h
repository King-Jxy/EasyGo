//
//  NewsListViewModel.h
//  BaseProject
//
//  Created by jake on 15/10/29.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "BDNewsModel.h"
@interface NewsListViewModel : BaseViewModel
@property (nonatomic , strong) NSMutableArray *dataArr;

- (id)getNewsDataCompletionHandle:(void(^)(NSError *error))completionHandle;

- (void)refreshDataCompletionHandle:(void(^)(NSError *error))completionHandle;
- (void)getModreDataCompletionHandle:(void(^)(NSError *error))completionHandle;

- (NSInteger)getRowNum;

- (NSString *)getTitleAtIndex:(NSIndexPath *)index;
//返回URL数组
- (NSArray *)getImageURLArrAtIndex:(NSIndexPath *)index;

- (NSURL *)getWebURLAtIndex:(NSIndexPath *)index;

- (NSInteger)getImageCountAtIndex:(NSIndexPath *)index;

- (NSString *)getSiteAtIndex:(NSIndexPath *)index;
@end
