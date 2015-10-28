//
//  CityListViewModel.m
//  BaseProject
//
//  Created by jake on 15/10/24.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "CityListViewModel.h"
#import "CityListNetManager.h"
#import "CityListModel.h"
@interface CityListViewModel()

@end

@implementation CityListViewModel



- (void)getCityListDataCompletionHandle:(void(^)(NSError *error))completionHandle{

        [CityListNetManager getCityListDataCompletionHandle:^(CityListModel *model, NSError *error) {
            self.cityList = model.result;
            completionHandle(error);
        }];
}

- (NSInteger)getProviceCount{
    NSMutableArray *provices = [NSMutableArray array];
    for (CityListDataModel *city in _cityList) {
        if(![provices containsObject:city.province]){
            [provices addObject:city.province];
        }
    }
    self.provicesArr = [provices copy];
    return provices.count;
}

//根据数组位置返回省份名
- (NSString *)getProviceNameAtIndex:(NSIndexPath *)index{
    return self.provices[index.row];
}
//根据省份名返回城市属于该省份的对象数组
- (NSArray *)getCityListModelFromProvice:(NSString *)provice{
    NSMutableArray *cityArray = [NSMutableArray array];
    for (CityListDataModel *cityModel in _cityList) {
        if([cityModel.province isEqualToString:provice]){
            [cityArray addObject:cityModel];
        }
    }
    self.cityArr = [cityArray copy];
    return self.cityArr;
}
//根据城市名返回地区属于该城市对象数组
- (NSArray *)getDistrictListModelFromCity:(NSString *)city{
    NSMutableArray *districtArray = [NSMutableArray array];
    for (CityListDataModel *cityModel in _cityArr) {
        if([cityModel.city isEqualToString:city])
        {
            [districtArray addObject:cityModel];
        }
    }
    self.districtArr = [districtArray copy];
    return self.districtArr;
}


- (NSArray *)cityList {
    if(_cityList == nil) {
        _cityList = [[NSArray alloc] init];
    }
    return _cityList;
}

- (NSArray *)provices {
    if(_provicesArr == nil) {
        _provicesArr = [[NSArray alloc] init];
    }
    return _provicesArr;
}

- (NSArray *)city {
    if(_cityArr == nil) {
        _cityArr = [[NSArray alloc] init];
    }
    return _cityArr;
}

- (NSArray *)district {
    if(_districtArr == nil) {
        _districtArr = [[NSArray alloc] init];
    }
    return _districtArr;
}


@end
