//
//  TrainTimeViewController.m
//  EasyGo
//
//  Created by jake on 15/11/9.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "TrainTimeViewController.h"
#import "TrainTimeViewModel.h"
#import "TripNetManager.h"
#import "NewTrainCell.h"
#import "OldTrainCell.h"
@interface TrainTimeViewController ()
@property (nonatomic , strong) TrainTimeViewModel *trainTimeVM;
@end

@implementation TrainTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.trainTimeVM getTrainTimeListDataFromTrainName:self.selectedData.station_train_code completionHandle:^(NSError *error) {
            if(error){
                [self showErrorMsg:[NSString stringWithFormat:@"%@",error.userInfo]];
            }else{
//只刷新第三部分的数据
                 NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
                [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
            }
        }];
    }];
    
    [self.tableView.header beginRefreshing];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return 1;
    }else if(section == 1){
//此处进行判断有哪些票还可以预定
        if(self.selectedData.zy_pri){//判断是否是动车或者高铁
            NSInteger cellNum = 0;
            if(self.selectedData.swz_pri && self.selectedData.swz_num){
                cellNum ++;
            }
            if(self.selectedData.zy_pri && self.selectedData.zy_num){
                cellNum ++;
            }
            if(self.selectedData.ze_pri && self.selectedData.ze_num){
                cellNum ++;
            }
            if(self.selectedData.wz_pri && self.selectedData.wz_num){
                cellNum ++;
            }
            return cellNum;
        }else{
            NSInteger cellNum = 0;
            if(self.selectedData.rw_pri && self.selectedData.rw_num){
                cellNum ++;
            }
            if(self.selectedData.yw_pri && self.selectedData.yw_num){
                cellNum ++;
            }
            if(self.selectedData.yz_pri && self.selectedData.yz_num){
                cellNum ++;
            }
            if(self.selectedData.wz_pri && self.selectedData.wz_num){
                cellNum ++;
            }
            return cellNum;
        }
    }else{
        return [self.trainTimeVM getCount];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        NewTrainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectedTicketCell" forIndexPath:indexPath];
        cell.trainCodeName.text = self.selectedData.station_train_code;
        cell.startStationName.text = self.selectedData.from_station_name;
        cell.endStationName.text = self.selectedData.to_station_name;
        cell.startTime.text = self.selectedData.start_time;
        cell.endTime.text = self.selectedData.arrive_time;
        cell.lishiTime.text = self.selectedData.lishi;
        return cell;
    }else if(indexPath.section == 1){
        return nil;
    }else{
        UITableViewCell *cell;
        if(indexPath.row == 0){
         cell = [tableView dequeueReusableCellWithIdentifier:@"TrainInfoCell" forIndexPath:indexPath];
            UILabel *label = (UILabel *)[cell.contentView viewWithTag:100];
            label.text = [self.trainTimeVM getBasicInfo];
        }else if(indexPath.row == 1){
            cell = [tableView dequeueReusableCellWithIdentifier:@"StationInfoCell" forIndexPath:indexPath];
        }else {
            cell = [tableView dequeueReusableCellWithIdentifier:@"StationInfoCell" forIndexPath:indexPath];
            UILabel *listNum = (UILabel *)[cell.contentView viewWithTag:100];
            listNum.text = [self.trainTimeVM getListNumAtIndex:indexPath.row-2];
            
            UILabel *stationName = (UILabel *)[cell.contentView viewWithTag:101];
            stationName.text = [self.trainTimeVM getStationNameAtIndex:indexPath.row-2];
            
            UILabel *lishiTime = (UILabel *)[cell.contentView viewWithTag:102];
            lishiTime.text = [self.trainTimeVM getLishiTimeAtIndex:indexPath.row-2];
            
            UILabel *arriveTime = (UILabel *)[cell.contentView viewWithTag:103];
            arriveTime.text = [self.trainTimeVM getArriveTimeAtIndex:indexPath.row-2];
            
            UILabel *leaveTime = (UILabel *)[cell.contentView viewWithTag:104];
            leaveTime.text = [self.trainTimeVM getLeaveTimeAtIndex:indexPath.row-2];
        }
        return cell;
    }

}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (TrainTimeViewModel *)trainTimeVM {
	if(_trainTimeVM == nil) {
		_trainTimeVM = [[TrainTimeViewModel alloc] init];
	}
	return _trainTimeVM;
}

@end
