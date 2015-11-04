//
//  BDNewsModel.m
//  BaseProject
//
//  Created by jake on 15/10/29.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BDNewsModel.h"

@implementation BDNewsModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"aerrno":@"errno"};
}
@end

@implementation BDNewsDataModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"anews":@"news"};
}

+ (NSDictionary *)objectClassInArray{
    return @{@"anews":[BDNewsDetailModel class]};
}
@end

@implementation BDNewsDetailModel



@end


@implementation BDCommentModel

@end

@implementation BDImageUrlModel

+ (id)prase:(NSArray *)imageUrls{
    NSMutableArray *array = [NSMutableArray array];
    if([imageUrls.firstObject isKindOfClass:[NSArray class]]){
        NSArray *dataArr = imageUrls.firstObject;
        for (NSDictionary *dic in dataArr) {
            BDImageUrlModel *model = [BDImageUrlModel new];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        return array;
    }else if([imageUrls.firstObject isKindOfClass:[NSDictionary class]]){
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in imageUrls) {
            BDImageUrlModel *model = [BDImageUrlModel new];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        return array;
    }
    return nil;
}

@end