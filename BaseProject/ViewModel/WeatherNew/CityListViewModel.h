//
//  CityListViewModel.h
//  BaseProject
//
//  Created by jake on 15/10/24.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "CityListModel.h"
@interface CityListViewModel : BaseViewModel
@property (nonatomic , strong) NSURLSessionDataTask *task;
@property (nonatomic , strong) NSArray *cityList;//存储CitylistModel类的对象数组
@property (nonatomic , strong) NSArray *provicesArr;//省份
@property (nonatomic , strong) NSArray *cityArr;//城市
@property (nonatomic , strong) NSArray *districtArr;//地区

- (void)getCityListDataCompletionHandle:(void(^)(NSError *error))completionHandle;
//返回省份个数
- (NSInteger)getProviceCount;
//根据数组位置返回省份名
- (NSString *)getProviceNameAtIndex:(NSIndexPath *)index;
//根据省份名返回城市属于该省份的对象数组
- (NSArray *)getCityListModelFromProvice:(NSString *)provice;
//根据城市名返回地区属于该城市对象数组
- (NSArray *)getDistrictListModelFromCity:(NSString *)city;


@end
