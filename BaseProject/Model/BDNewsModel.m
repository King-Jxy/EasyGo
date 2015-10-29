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
+(NSDictionary *)objectClassInArray{
    return @{@"imageurls":[BDImageUrlModel class]};
}

@end


@implementation BDCommentModel

@end

@implementation BDImageUrlModel

@end