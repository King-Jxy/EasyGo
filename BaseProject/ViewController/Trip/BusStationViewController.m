//
//  BusStationViewController.m
//  EasyGo
//
//  Created by jake on 15/11/25.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BusStationViewController.h"
#import "LocationViewController.h"
#import "BusViewModel.h"
#import "BusLineListViewController.h"
@interface BusStationViewController ()<UITableViewDelegate,UITableViewDataSource,LocationViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *cityTF;
@property (weak, nonatomic) IBOutlet UIButton *chooseCityBtn;
@property (weak, nonatomic) IBOutlet UITextField *stationTF;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic , strong) NSString *city;
@property (nonatomic , strong) NSString *stationName;
@property (nonatomic , strong) DVSwitch *mySwitch;
@property (nonatomic , strong) BusViewModel *bVM;

@end

@implementation BusStationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DVSwitch *third = [DVSwitch switchWithStringsArray:@[@"线路查询", @"路线规划",@"站点查询"]];
    third.frame = CGRectMake(10, 5, self.view.frame.size.width - 10 * 2, 30);
    third.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:18];
    third.backgroundColor = [UIColor colorWithRed:21/255.0 green:94/255.0 blue:228/255.0 alpha:0.6];
    third.sliderColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.9];
    [self.view addSubview:third];
    self.mySwitch = third;
    [third setPressedHandler:^(NSUInteger index) {
        if(index == 0){
            [self.dvSwitch forceSelectedIndex:0 animated:NO];
            [self.view removeFromSuperview];
        }
    }];
    
    CALayer *layer = self.chooseCityBtn.layer;
    layer.cornerRadius = 10;
    layer.shadowOpacity = 0.3;
    layer = self.searchBtn.layer;
    layer.cornerRadius = 10;
    layer.shadowOpacity = 0.3;
    
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
        }else if([_stationTF.text isEqualToString:@""]){
            [self showErrorMsg:@"请输入站点名"];
            return;
        }
        self.stationName = self.stationTF.text;
        self.city = self.cityTF.text;
        self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.bVM getStationDataInCity:self.city atStation:self.stationName completionHandle:^(NSError *error) {
                [self.tableView reloadData];
                [self.tableView.header endRefreshing];
            }];
        }];
        [self.tableView.header beginRefreshing];
    } forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.mySwitch forceSelectedIndex:2 animated:NO];
}

- (void)locationViewEnd:(LocationViewController *)senderVC withLocalName:(NSString *)localName{
    self.cityTF.text = localName;
    self.city = localName;
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.bVM getStationDataCount];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StationNameCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.bVM getStationNameAtIndex:indexPath.row];
    return cell;
}


#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BusLineListViewController *bllvc = [kStoryboard(@"Main")instantiateViewControllerWithIdentifier:@"BusLineListViewController"];
    bllvc.navigationController = self.navigationController;
    bllvc.data = [self.bVM getStationLineNamesAtIndex:indexPath.row];
    [self.navigationController pushViewController:bllvc animated:YES];
}


- (DVSwitch *)mySwitch {
	if(_mySwitch == nil) {
		_mySwitch = [[DVSwitch alloc] init];
	}
	return _mySwitch;
}

- (BusViewModel *)bVM {
	if(_bVM == nil) {
		_bVM = [[BusViewModel alloc] init];
	}
	return _bVM;
}

@end
