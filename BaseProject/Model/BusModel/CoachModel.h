//
//  CoachModel.h
//  EasyGo
//
//  Created by jake on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//
//长途汽车模型
#import "BaseModel.h"

@class CoachResultModel,CoachResultListModel;
@interface CoachModel : BaseModel

@property (nonatomic, strong) CoachResultModel *result;

@property (nonatomic, assign) NSInteger error_code;

@property (nonatomic, copy) NSString *reason;

@end
@interface CoachResultModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray<CoachResultListModel *> *list;

@end

@interface CoachResultListModel : NSObject

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *arrive;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *start;

@end

