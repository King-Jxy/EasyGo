//
//  TrainViewModel.m
//  WeatherNews
//
//  Created by jake on 15/11/4.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "TrainViewModel.h"
#import "TripNetManager.h"

@interface TrainViewModel ()
@property (nonatomic , strong) NSArray *trainS2SList;
@end

@implementation TrainViewModel
- (id)getS2StaionDataFromStart:(NSString *)start toEnd:(NSString *)end completionHandle:(void(^)(NSError *error))completionHandle{
    return [TripNetManager getS2StaionDataFromStart:start toEnd:end CompletionHandle:^(S2StationModel *model, NSError *error) {
        self.trainS2SList = model.result.list;
    }];
}
@end
