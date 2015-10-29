//
//  CityPicModel.h
//  BaseProject
//
//  Created by jake on 15/10/28.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"
@class CityPicDataModel,CityPicPm25Model;
@interface CityPicModel : BaseModel
@property (nonatomic, assign) double aerrno;
@property (nonatomic, strong) CityPicDataModel *data;
@end

@interface CityPicDataModel : BaseModel
@property (nonatomic, strong) NSArray *weather;
@property (nonatomic, strong) NSString *image;
@end


@interface CityPicWeatherModel : BaseModel
@property (nonatomic, strong) NSString *temperature;
@property (nonatomic, strong) NSString *weather;
@property (nonatomic, strong) CityPicPm25Model *pm25;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *date;
@end


@interface CityPicPm25Model : BaseModel
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) NSString *level;
@property (nonatomic, strong) NSString *levelnum;
@end

