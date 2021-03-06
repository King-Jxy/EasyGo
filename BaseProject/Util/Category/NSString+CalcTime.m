//
//  NSString+CalcTime.m
//  WeatherNews
//
//  Created by jake on 15/10/31.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "NSString+CalcTime.h"

@implementation NSString (CalcTime)
+ (NSString *)timeAgoFromTimestamp:(NSNumber *)timestamp{
    
    int datePosted = [timestamp intValue];
    int timestampNow = [[NSDate date] timeIntervalSince1970];
    int hoursAgo = (timestampNow - datePosted) / 3600;
    int daysAgo = hoursAgo / 24;
    int yearsAgo = daysAgo / 365;
    
    if(yearsAgo != 0){
        if(yearsAgo == 1)
            return [NSString stringWithFormat:@"%d year ago", yearsAgo];
        else
            return [NSString stringWithFormat:@"%d years ago", yearsAgo];
    }
    
    if(daysAgo != 0){
        if(daysAgo == 1)
            return [NSString stringWithFormat:@"%d day ago", daysAgo];
        else
            return [NSString stringWithFormat:@"%d days ago", daysAgo];
    }
    
    int minutesAgo;
    
    if(hoursAgo == 0){
        minutesAgo = (timestampNow - datePosted) / 60;
        if(minutesAgo == 1)
            return [NSString stringWithFormat:@"%d minute ago", minutesAgo];
        else
            return [NSString stringWithFormat:@"%d minutes ago", minutesAgo];
    }
    else{
        if( hoursAgo == 1)
            return [NSString stringWithFormat:@"%d hour ago", hoursAgo];
        else
            return [NSString stringWithFormat:@"%d hours ago", hoursAgo];
    }
    
}

@end
