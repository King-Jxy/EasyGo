//
//  BusStationModel.h
//  EasyGo
//
//  Created by jake on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@class BusStationBodyModel,BusStationRetlistModel;
@interface BusStationModel : BaseModel

@property (nonatomic, strong) BusStationBodyModel *showapi_res_body;

@property (nonatomic, copy) NSString *showapi_res_error;

@property (nonatomic, assign) NSInteger showapi_res_code;

@end
@interface BusStationBodyModel : NSObject

@property (nonatomic, strong) NSArray<BusStationRetlistModel *> *retList;

@property (nonatomic, assign) NSInteger ret_code;

@end

@interface BusStationRetlistModel : NSObject

@property (nonatomic, copy) NSString *line_names;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *xy;

@end

