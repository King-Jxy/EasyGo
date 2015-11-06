//
//  LeftTicketModel.h
//  WeatherNews
//
//  Created by jake on 15/11/6.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@class LTShowapi_Res_BodyModel,LTBodyDataModel;
@interface LeftTicketModel : BaseModel

@property (nonatomic, strong) LTShowapi_Res_BodyModel *showapi_res_body;

@property (nonatomic, copy) NSString *showapi_res_error;

@property (nonatomic, assign) NSInteger showapi_res_code;

@end
@interface LTShowapi_Res_BodyModel : NSObject

@property (nonatomic, strong) NSArray<LTBodyDataModel *> *data;

@property (nonatomic, assign) NSInteger count;//车次数目

@property (nonatomic, copy) NSString *date;//发车日期

@property (nonatomic, copy) NSString *end_station;//终点站

@property (nonatomic, copy) NSString *error_code;

@property (nonatomic, copy) NSString *start_station;//始发站

@property (nonatomic, copy) NSString *ret_code;

@end

@interface LTBodyDataModel : NSObject

@property (nonatomic, copy) NSString *yz_num;//硬座

@property (nonatomic, copy) NSString *yz_pri;

@property (nonatomic, copy) NSString *rw_num;//软卧

@property (nonatomic, copy) NSString *rw_pri;

@property (nonatomic, copy) NSString *yw_num;//硬卧

@property (nonatomic, copy) NSString *yw_pri;

@property (nonatomic, copy) NSString *gr_num;//高级软卧

@property (nonatomic, copy) NSString *gr_pri;

@property (nonatomic, copy) NSString *tz_num;//特等座

@property (nonatomic, copy) NSString *tz_pri;

@property (nonatomic, copy) NSString *qt_num;//其他

@property (nonatomic, copy) NSString *qt_pri;

@property (nonatomic, copy) NSString *rz_num;//软座

@property (nonatomic, copy) NSString *rz_pri;


@property (nonatomic, copy) NSString *swz_pri;//商务座价格

@property (nonatomic, copy) NSString *swz_num;

//@property (nonatomic, copy) NSString *yz_num;//硬座数量

@property (nonatomic, copy) NSString *start_station_name;//始发站

@property (nonatomic, copy) NSString *station_train_code;//

@property (nonatomic, copy) NSString *end_station_name;//终点站

@property (nonatomic, copy) NSString *arrive_time;//到达时间

@property (nonatomic, copy) NSString *zy_num;//一等座

@property (nonatomic, copy) NSString *zy_pri;

@property (nonatomic, copy) NSString *wz_num;//无座

@property (nonatomic, copy) NSString *wz_pri;

@property (nonatomic, copy) NSString *from_station_name;//出发站点

@property (nonatomic, copy) NSString *ze_num;//二等座

@property (nonatomic, copy) NSString *ze_pri;

@property (nonatomic, copy) NSString *start_train_date;

@property (nonatomic, copy) NSString *day_difference;

@property (nonatomic, copy) NSString *to_station_no;

@property (nonatomic, copy) NSString *lishi;//历时

@property (nonatomic, copy) NSString *start_time;//出站时间

@property (nonatomic, copy) NSString *from_station_no;

@property (nonatomic, copy) NSString *to_station_name;//目的站点



@end

