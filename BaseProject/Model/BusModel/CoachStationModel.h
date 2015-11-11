//
//  CoachStationModel.h
//  EasyGo
//
//  Created by jake on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@class CoachStationResultModel,CoachStationResultListModel;
@interface CoachStationModel : BaseModel

@property (nonatomic, strong) CoachStationResultModel *result;

@property (nonatomic, assign) NSInteger error_code;

@property (nonatomic, copy) NSString *reason;

@end
@interface CoachStationResultModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray<CoachStationResultListModel *> *list;

@end

@interface CoachStationResultListModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *tel;

@property (nonatomic, copy) NSString *adds;

@end

