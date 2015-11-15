//
//  CoachResultViewController.m
//  EasyGo
//
//  Created by jake on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "CoachResultViewController.h"
#import "CoachViewModel.h"
@interface CoachResultViewController ()
@property (nonatomic , strong) CoachViewModel *coachVM;
@end

@implementation CoachResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if(self.city){
            [self.coachVM getCoachStationDataAtCity:self.city completionHandle:^(NSError *error) {
                [self.tableView.header endRefreshing];
                if(error){
                    [self showErrorMsg:(NSString *)error.userInfo];
                    return;
                }else if(!self.coachVM.stationDataArr){
                    [self showErrorMsg:self.coachVM.reason];
                    return;
                }
                [self.tableView reloadData];
                self.title = [NSString stringWithFormat:@"%@车站列表",self.city];
                
            }];
        }else{
            [self.coachVM getCoachS2SListDataFrom:self.start to:self.end completionHandle:^(NSError *error) {
                [self.tableView.header endRefreshing];
                if(error){
                    [self showErrorMsg:(NSString *)error.userInfo];
                    return;
                }else if(!self.coachVM.s2sDataArr){
                    [self showErrorMsg:self.coachVM.reason];
                    return;
                }
                [self.tableView reloadData];
                self.title = [NSString stringWithFormat:@"%@-%@ 汽车时刻表",self.start,self.end];
               
            }];
        }
    }];
    
    [self.tableView.header beginRefreshing];
    
    self.tableView.tableFooterView = [UIView new];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.city){
        return self.coachVM.stationDataArr.count;
    }else{
        return self.coachVM.s2sDataArr.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell ;
    if(self.city){
        cell = [tableView dequeueReusableCellWithIdentifier:@"CoachStationCell" forIndexPath:indexPath];
        UILabel *nameLabel = (UILabel *)[cell.contentView viewWithTag:100];
        UILabel *telLabel = (UILabel *)[cell.contentView viewWithTag:101];
        UILabel *addsLabel = (UILabel *)[cell.contentView viewWithTag:102];
        nameLabel.text = [@"站名："stringByAppendingString:[self.coachVM getStationNameAtIndex:indexPath.row]];
        telLabel.text = [@"电话："stringByAppendingString:[self.coachVM getStationTeleAtIndex:indexPath.row]];
        addsLabel.text = [@"地址："stringByAppendingString:[self.coachVM getStationAddsAtIndex:indexPath.row]];
        
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"CoachTimeCell" forIndexPath:indexPath];
        UILabel *startLabel = (UILabel *)[cell.contentView viewWithTag:201];
        UILabel *endLabel = (UILabel *)[cell.contentView viewWithTag:202];
        UILabel *timeLabel = (UILabel *)[cell.contentView viewWithTag:203];
        UILabel *priceLabel = (UILabel *)[cell.contentView viewWithTag:204];
        startLabel.text = [@"出发站："stringByAppendingString:[self.coachVM getStartStaionAtIndex:indexPath.row]];
        endLabel.text = [@"终点站："stringByAppendingString:[self.coachVM getArriveStationAtIndex:indexPath.row]];
        timeLabel.text = [@"出发时间："stringByAppendingString:[self.coachVM getDateTimeAtIndex:indexPath.row]];
        priceLabel.text = [@"票价："stringByAppendingString:[self.coachVM getPriceAtIndex:indexPath.row]];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

- (CoachViewModel *)coachVM {
	if(_coachVM == nil) {
		_coachVM = [[CoachViewModel alloc] init];
	}
	return _coachVM;
}

@end
