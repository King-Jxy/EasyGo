//
//  LeftTicketViewController.m
//  WeatherNews
//
//  Created by jake on 15/11/7.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "LeftTicketViewController.h"
#import "OldTrainCell.h"
#import "NewTrainCell.h"
#define INDEX indexPath.row
@interface LeftTicketViewController ()

@end

@implementation LeftTicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.trainVM getTrainCount];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([self.trainVM getPriceOfswzAtIndex:indexPath.row]){
      NewTrainCell  *cell  = [tableView dequeueReusableCellWithIdentifier:@"NewTrainCell" forIndexPath:indexPath];
        cell.trainCodeName.text = [self.trainVM getTrainNameAtIndex:INDEX];
        cell.startStationName.text = [self.trainVM getStartStationNameAtIndex:INDEX];
        cell.endStationName.text = [self.trainVM getEndStationNameAtIndex:INDEX];
        cell.startTime.text = [self.trainVM getStartTimeAtIndex:INDEX];
        cell.endTime.text  = [self.trainVM getArriveTimeAtIndex:INDEX];
        cell.lishiTime.text = [self.trainVM getLishiTimeAtIndex:INDEX];
        
        cell.swzNum.text = [cell.swzNum.text stringByAppendingString:[self.trainVM getNumOfswzAtIndex:INDEX]];
        cell.zyNum.text = [cell.zyNum.text stringByAppendingString:[self.trainVM getNumOfzyAtIndex:INDEX]];;
        cell.zeNum.text = [cell.zeNum.text stringByAppendingString:[self.trainVM getNumOfzeAtIndex:INDEX]];
        
        if(![self.trainVM getPriceOfwzAtIndex:INDEX]){
            cell.wzNum.text = @"";
        }else{
            cell.wzNum.text = [cell.wzNum.text stringByAppendingString:[self.trainVM getNumOfwzAtIndex:INDEX]];
        }
         return cell;
    }else{
      OldTrainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OldTrainCell" forIndexPath:indexPath];
        cell.trainCodeName.text = [self.trainVM getTrainNameAtIndex:INDEX];
        cell.startStationName.text = [self.trainVM getStartStationNameAtIndex:INDEX];
        cell.endStationName.text = [self.trainVM getEndStationNameAtIndex:INDEX];
        cell.startTime.text = [self.trainVM getStartTimeAtIndex:INDEX];
        cell.endTime.text  = [self.trainVM getArriveTimeAtIndex:INDEX];
        cell.lishiTime.text = [self.trainVM getLishiTimeAtIndex:INDEX];
        
        cell.rwNum.text = [cell.rwNum.text stringByAppendingString:[self.trainVM getNumOfrwAtIndex:INDEX]];
        cell.ywNum.text = [cell.ywNum.text stringByAppendingString:[self.trainVM getNumOfywAtIndex:INDEX]];;
        cell.yzNum.text = [cell.yzNum.text stringByAppendingString:[self.trainVM getNumOfyzAtIndex:INDEX]];
        
        if(![self.trainVM getPriceOfwzAtIndex:INDEX]){
            cell.wzNum.text = @"";
        }else{
            cell.wzNum.text = [cell.wzNum.text stringByAppendingString:[self.trainVM getNumOfwzAtIndex:INDEX]];
        }
         return cell;
    }
    
   
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
