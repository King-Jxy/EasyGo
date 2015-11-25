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
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "TrainTimeViewController.h"
#define INDEX indexPath.row
@interface LeftTicketViewController ()<UMSocialDataDelegate,UMSocialUIDelegate>
@property (nonatomic ) NSInteger selectedRow;
@end

@implementation LeftTicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [[[self.trainVM getFromStationNameAtIndex:0] stringByAppendingString:@" - "]stringByAppendingString:[self.trainVM getToStationNameAtIndex:0]];
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

- (IBAction)UMShare:(id)sender {
//横屏支持
    [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskLandscape];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"563efdb8e0f55a78c7000f47"
                                      shareText:[self.title stringByAppendingString:@"车票查询结果"]
                                     shareImage:[UIImage imageNamed:@"more_share_weixin_ic.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToEmail,nil]
                                       delegate:self];
    
    [UMSocialWechatHandler setWXAppId:@"wxf2677aed96fb96a1" appSecret:@"d4624c36b6795d1d99dcf0547af5443d" url:@"http://www.umeng.com/social"];
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.trainVM getTrainCount];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([self.trainVM getPriceOfzyAtIndex:indexPath.row]){//此处判断是否为动车或高铁
      NewTrainCell  *cell  = [tableView dequeueReusableCellWithIdentifier:@"NewTrainCell" forIndexPath:indexPath];
        cell.trainCodeName.text = [self.trainVM getTrainNameAtIndex:INDEX];
        cell.startStationName.text = [self.trainVM getFromStationNameAtIndex:INDEX];
        if([[self.trainVM getStartStationNameAtIndex:INDEX] isEqualToString:[self.trainVM getFromStationNameAtIndex:INDEX]]){
            cell.startStationName.text = [[self.trainVM getFromStationNameAtIndex:INDEX]stringByAppendingString:@"[始]"];
        }
        
        cell.endStationName.text = [self.trainVM getToStationNameAtIndex:INDEX];
        if([[self.trainVM getEndStationNameAtIndex:INDEX] isEqualToString:[self.trainVM getToStationNameAtIndex:INDEX]]){
            cell.endStationName.text = [[self.trainVM getToStationNameAtIndex:INDEX]stringByAppendingString:@"[终]"];
        }
        cell.startTime.text = [self.trainVM getStartTimeAtIndex:INDEX];
        cell.endTime.text  = [self.trainVM getArriveTimeAtIndex:INDEX];
        cell.lishiTime.text = [self.trainVM getLishiTimeAtIndex:INDEX];
        
        if(![self.trainVM getPriceOfswzAtIndex:INDEX]){//判断该列车是否有商务座
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
        cell.trainCodeName.text = [self.trainVM getTrainNameAtIndex:INDEX];
        cell.startStationName.text = [self.trainVM getFromStationNameAtIndex:INDEX];
        if([[self.trainVM getStartStationNameAtIndex:INDEX] isEqualToString:[self.trainVM getFromStationNameAtIndex:INDEX]]){
            cell.startStationName.text = [[self.trainVM getFromStationNameAtIndex:INDEX]stringByAppendingString:@"[始]"];
        }
        
        cell.endStationName.text = [self.trainVM getToStationNameAtIndex:INDEX];
        if([[self.trainVM getEndStationNameAtIndex:INDEX] isEqualToString:[self.trainVM getToStationNameAtIndex:INDEX]]){
            cell.endStationName.text = [[self.trainVM getToStationNameAtIndex:INDEX]stringByAppendingString:@"[终]"];
        }
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
    self.selectedRow = indexPath.row;
    [self performSegueWithIdentifier:@"TicketDetailSegue" sender:self];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"共有%ld次列车",[self.trainVM getTrainCount]];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TrainTimeViewController *vc = segue.destinationViewController;
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
//  获得点击的是第几行
    DDLogVerbose(@"%@",[self.trainVM getModelAtIndex:self.selectedRow]);
    vc.selectedData = [self.trainVM getModelAtIndex:self.selectedRow];
}


@end
