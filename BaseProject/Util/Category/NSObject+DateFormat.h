//
//  NSObject+DateFormat.h
//  WeatherNews
//
//  Created by jake on 15/11/4.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DateFormat)
- (NSString *)getDateAndWeek;//2015-11-06 星期五

- (NSString *)getTimestamp;//20151105232948

- (NSString *)getDate;//2015-11-07

//两个NSDate之间相差几天
-(NSInteger)daysWithinEraFromDate:(NSDate *) startDate toDate:(NSDate *) endDate;
@end
