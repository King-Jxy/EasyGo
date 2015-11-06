//
//  TrainViewModel.h
//  WeatherNews
//
//  Created by jake on 15/11/4.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"

@interface TrainViewModel : BaseViewModel
- (id)getS2StaionDataFromStart:(NSString *)start toEnd:(NSString *)end completionHandle:(void(^)(NSError *error))completionHandle;
@end
