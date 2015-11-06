//
//  NewTrainCell.h
//  WeatherNews
//
//  Created by jake on 15/11/7.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewTrainCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *startStationName;
@property (weak, nonatomic) IBOutlet UILabel *endStationName;
@property (weak, nonatomic) IBOutlet UILabel *trainCodeName;
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *endTime;
@property (weak, nonatomic) IBOutlet UILabel *lishiTime;

@property (weak, nonatomic) IBOutlet UILabel *swzNum;
@property (weak, nonatomic) IBOutlet UILabel *zyNum;
@property (weak, nonatomic) IBOutlet UILabel *zeNum;
@property (weak, nonatomic) IBOutlet UILabel *wzNum;

@end
