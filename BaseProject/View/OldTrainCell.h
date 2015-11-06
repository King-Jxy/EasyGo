//
//  OldTrainCell.h
//  WeatherNews
//
//  Created by jake on 15/11/7.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OldTrainCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *startStationName;
@property (weak, nonatomic) IBOutlet UILabel *endStationName;
@property (weak, nonatomic) IBOutlet UILabel *trainCodeName;
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *endTime;
@property (weak, nonatomic) IBOutlet UILabel *lishiTime;

@property (weak, nonatomic) IBOutlet UILabel *rwNum;
@property (weak, nonatomic) IBOutlet UILabel *ywNum;
@property (weak, nonatomic) IBOutlet UILabel *yzNum;
@property (weak, nonatomic) IBOutlet UILabel *wzNum;
@end
