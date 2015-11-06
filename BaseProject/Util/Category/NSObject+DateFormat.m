//
//  NSObject+DateFormat.m
//  WeatherNews
//
//  Created by jake on 15/11/4.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "NSObject+DateFormat.h"
/*
 //Week:
 1 －－星期天
 2－－星期一
 3－－星期二
 4－－星期三
 5－－星期四
 6－－星期五
 7－－星期六
 */
@implementation NSObject (DateFormat)
- (NSString *)getDateAndWeek{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    NSInteger week = [comps weekday];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    NSInteger hour = [comps hour];
    NSInteger min = [comps minute];
    NSInteger sec = [comps second];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd "];
    NSString *dateStr = [formatter stringFromDate:now];
    switch (week) {
        case 1:
            return [dateStr stringByAppendingString:@"星期日"];
            break;
        case 2:
            return [dateStr stringByAppendingString:@"星期一"];
            break;
        case 3:
            return [dateStr stringByAppendingString:@"星期二"];
            break;
        case 4:
            return [dateStr stringByAppendingString:@"星期三"];
            break;
        case 5:
            return [dateStr stringByAppendingString:@"星期四"];
            break;
        case 6:
            return [dateStr stringByAppendingString:@"星期五"];
            break;
        case 7:
            return [dateStr stringByAppendingString:@"星期六"];
            break;
        default:
            return nil;
    }
}


- (NSString *)getTimestamp{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYYMMddHHmmss"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    return dateStr;
}

- (NSString *)getDate{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    return dateStr;
}

@end
