//
//  BusViewController.m
//  WeatherNews
//
//  Created by jake on 15/11/2.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BusViewController.h"
#import "DVSwitch.h"
#import "BusViewModel.h"
#import "LocationViewController.h"
#import "BusStationListViewController.h"
#import "BusStationViewController.h"
@interface BusViewController ()<LocationViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UIButton *chooseCityBtn;
@property (weak, nonatomic) IBOutlet UITextField *busLineTF;
@property (weak, nonatomic) IBOutlet UITextField *cityTF;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic , strong) BusViewModel *bVM;
@property (nonatomic , strong) NSString *city;
@property (nonatomic , strong) NSString *lineNum;

@property (nonatomic , strong) BusStationViewController *bsvc;
@end

@implementation BusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DVSwitch *third = [DVSwitch switchWithStringsArray:@[@"线路查询", @"路线规划",@"站点查询"]];
    third.frame = CGRectMake(10, 5, self.view.frame.size.width - 10 * 2, 30);
    third.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:18];
    third.backgroundColor = [UIColor colorWithRed:21/255.0 green:94/255.0 blue:228/255.0 alpha:0.6];
    third.sliderColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.9];
    [self.view addSubview:third];
    self.bsvc.dvSwitch = third;
    [third setPressedHandler:^(NSUInteger index) {
        if(index == 2){
            [self.view addSubview:self.bsvc.view];
        }
    }];

    
    
#pragma mark - 给按钮添加响应事件
    [self.chooseCityBtn bk_addEventHandler:^(id sender) {
        LocationViewController *lvc = [kStoryboard(@"Main")instantiateViewControllerWithIdentifier:@"LocationViewController"];
        lvc.delegate = self;
        [self.navigationController pushViewController:lvc animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.searchBtn bk_addEventHandler:^(id sender) {
        if(!_city && [_cityTF.text isEqualToString:@""]){
            [self showErrorMsg:@"未选定城市"];
            return;
        }else if([_busLineTF.text isEqualToString:@""]){
            [self showErrorMsg:@"请输入线路名"];
            return;
        }
        self.lineNum = self.busLineTF.text;
        self.city = self.cityTF.text;
        [self showProgress];
        [self.bVM getLineDataInCity:self.city atLine:self.lineNum completionHandle:^(NSError *error) {
            [self.tableView reloadData];
            [self hideProgress];
        }];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    CALayer *layer = self.chooseCityBtn.layer;
    layer.cornerRadius = 10;
    layer.shadowOpacity = 0.3;
    layer = self.searchBtn.layer;
    layer.cornerRadius = 10;
    layer.shadowOpacity = 0.3;
}

- (void)locationViewEnd:(LocationViewController *)senderVC withLocalName:(NSString *)localName{
    self.city = localName;
    self.cityTF.text = localName;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.bVM getLineDataCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusLineCell" forIndexPath:indexPath];
    UILabel *name = (UILabel *)[cell.contentView viewWithTag:100];
    name.text = [self.bVM getLineNameAtIndex:indexPath.row];
    UILabel *info = (UILabel *)[cell.contentView viewWithTag:101];
    info.text = [self.bVM getLineInfoAtIndex:indexPath.row];
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BusStationListViewController *bslvc = [kStoryboard(@"Main")instantiateViewControllerWithIdentifier:@"BusStationListViewController"];
    bslvc.navigationController = self.navigationController;
    bslvc.data = [[self.bVM getStationsAtIndex:indexPath.row] copy];
    [self.navigationController pushViewController:bslvc animated:YES];
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return UITableViewAutomaticDimension;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (BusViewModel *)bVM {
	if(_bVM == nil) {
		_bVM = [[BusViewModel alloc] init];
	}
	return _bVM;
}

- (BusStationViewController *)bsvc {
	if(_bsvc == nil) {
		_bsvc = [kStoryboard(@"Main")instantiateViewControllerWithIdentifier:@"BusStationViewController"];
        _bsvc.navigationController = self.navigationController;
	}
	return _bsvc;
}

@end
