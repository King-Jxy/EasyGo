//
//  NSString+CalcTime.h
//  WeatherNews
//
//  Created by jake on 15/10/31.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CalcTime)
+ (NSString *)timeAgoFromTimestamp:(NSNumber *)timestamp;
@end
