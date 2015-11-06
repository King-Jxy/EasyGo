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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
    }];
    [self.tableView.header beginRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.trainVM getTrainCount];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([self.trainVM getPriceOfzyAtIndex:indexPath.row]){
      NewTrainCell  *cell  = [tableView dequeueReusableCellWithIdentifier:@"NewTrainCell" forIndexPath:indexPath];
        cell.trainCodeName.text = [self.trainVM getTrainNameAtIndex:INDEX];
        cell.startStationName.text = [self.trainVM getStartStationNameAtIndex:INDEX];
        cell.endStationName.text = [self.trainVM getEndStationNameAtIndex:INDEX];
        cell.startTime.text = [self.trainVM getStartTimeAtIndex:INDEX];
        cell.endTime.text  = [self.trainVM getArriveTimeAtIndex:INDEX];
        cell.lishiTime.text = [self.trainVM getLishiTimeAtIndex:INDEX];
        
        if(![self.trainVM getPriceOfswzAtIndex:INDEX]){
            cell.swzNum.text = @"";
        }else{
            
            cell.swzNum.text = [@"商务座：" stringByAppendingString:[self.trainVM getNumOfswzAtIndex:INDEX]];
        }
        if(![self.trainVM getPriceOfzyAtIndex:INDEX]){
            cell.zyNum.text = @"";
        }else{
            cell.zyNum.text = [@"一等座：" stringByAppendingString:[self.trainVM getNumOfzyAtIndex:INDEX]];
        }
        if(![self.trainVM getPriceOfzeAtIndex:INDEX]){
            cell.zeNum.text = @"";
        }else{
            cell.zeNum.text = [@"二等座：" stringByAppendingString:[self.trainVM getNumOfzeAtIndex:INDEX]];
        }
        if(![self.trainVM getPriceOfwzAtIndex:INDEX]){
            cell.wzNum.text = @"";
        }else{
            cell.wzNum.text = [@"无座：" stringByAppendingString:[self.trainVM getNumOfwzAtIndex:INDEX]];
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
        
        if(![self.trainVM getPriceOfrwAtIndex:INDEX]){
            cell.rwNum.text = @"";
        }else{
            cell.rwNum.text = [@"软卧：" stringByAppendingString:[self.trainVM getNumOfrwAtIndex:INDEX]];
        }
        if(![self.trainVM getPriceOfywAtIndex:INDEX]){
            cell.ywNum.text = @"";
        }else{
            cell.ywNum.text = [@"硬卧：" stringByAppendingString:[self.trainVM getNumOfywAtIndex:INDEX]];
        }
        if(![self.trainVM getPriceOfyzAtIndex:INDEX]){
            cell.yzNum.text = @"";
        }else{
            cell.yzNum.text = [@"硬座：" stringByAppendingString:[self.trainVM getNumOfyzAtIndex:INDEX]];
        }
        if(![self.trainVM getPriceOfwzAtIndex:INDEX]){
            cell.wzNum.text = @"";
        }else{
            cell.wzNum.text = [@"无座：" stringByAppendingString:[self.trainVM getNumOfwzAtIndex:INDEX]];
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
