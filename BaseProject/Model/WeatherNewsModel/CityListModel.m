#import "CityListModel.h"
@implementation CityListModel
//需要用特殊的类型进行解析的指定说明
+ (NSDictionary *)objectClassInArray{
    // key 需要填 属性, 表示某个数组属性中的元素对应的特殊解析类
    return @{@"result":[CityListDataModel class]};
}

@end

@implementation CityListDataModel

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"ID": @"id"};
}

@end