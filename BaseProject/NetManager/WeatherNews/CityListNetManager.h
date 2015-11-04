//
//  CityListNetManager.h
//  BaseProject
//
//  Created by jake on 15/10/24.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseNetManager.h"
#import "CityListModel.h"
@interface CityListNetManager : BaseNetManager
+ (id)getCityListDataCompletionHandle:(void(^)(CityListModel *model,NSError *error))completionHandle;
@end
