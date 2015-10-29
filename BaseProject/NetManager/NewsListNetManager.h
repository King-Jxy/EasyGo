//
//  NewsListNetManager.h
//  BaseProject
//
//  Created by jake on 15/10/29.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseNetManager.h"
#import "BDNewsModel.h"
@interface NewsListNetManager : BaseNetManager
+ (id)getNewsListDataCompletionHandle:(void(^)(BDNewsModel *model,NSError *error))completionHandle;


@end
