//
//  LocationViewController.m
//  BaseProject
//
//  Created by jake on 15/10/23.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "LocationViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "CityListViewModel.h"
#import "LocationCityViewController.h"
@interface LocationViewController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic , strong) CLLocationManager *manager;
@property (nonatomic , strong) CityListViewModel *cityListVM;
@property (nonatomic , strong) NSString *locationName;//存储定位得到的地址
@end

@implementation LocationViewController

- (CLLocationManager *)manager {
    if(_manager == nil) {
        _manager = [[CLLocationManager alloc] init];
        if([UIDevice currentDevice].systemVersion.floatValue >= 8.0){
//进行系统版本判断
            _manager.delegate = self;
            [_manager requestWhenInUseAuthorization];
        }
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//从网络获取数据
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.cityListVM getCityListDataCompletionHandle:^(NSError *error) {
        [self.tableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (error) {
            [self showErrorMsg:error.localizedDescription];
        }
    }];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location = locations.firstObject;
    DDLogVerbose(@"location %@",location);
    [self.manager stopUpdatingLocation];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
//反编码获得地址
    [self reGeocoder:location];
}

//反地理编码
- (void)reGeocoder:(CLLocation *)location{
    CLGeocoder *geocoder = [CLGeocoder new];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark *mark in placemarks) {
            DDLogVerbose(@"本地地址：%@",mark.name);
            self.locationName = mark.name;
            self.title = self.locationName;
//  刷新定位cell
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
            [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
        }
    }];
}

#pragma mark TableViewDataSource

kRemoveCellSeparator
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 1;
    }else if(section == 1){
        return [self.cityListVM getProviceCount];
    }else{
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if(indexPath.section == 0 ){
        cell = [tableView dequeueReusableCellWithIdentifier:@"HeaderCell" forIndexPath:indexPath];
        cell.textLabel.text = self.locationName;
    }else{
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ProviceCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"ProviceCell" forIndexPath:indexPath];
        cell.textLabel.text = [self.cityListVM getProviceNameAtIndex:indexPath];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
       
    }
    return cell;
}


#pragma mark TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(!indexPath.section){
        DDLogVerbose(@"开始定位");
        //开始更新位置信息
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"正在获取您的当前位置";
        [self.manager startUpdatingLocation];
        
    }else{
        NSString *selectedProvice = [self.cityListVM getProviceNameAtIndex:indexPath];
//获取在该省份对象数组
        NSArray *cityArray = [self.cityListVM getCityListModelFromProvice:selectedProvice];
        
        LocationCityViewController *vc = [[LocationCityViewController alloc] initWithCityArray:cityArray];
        vc.cityListVM = self.cityListVM;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}



- (CityListViewModel *)cityListVM {
	if(_cityListVM == nil) {
		_cityListVM = [[CityListViewModel alloc] init];
	}
	return _cityListVM;
}

@end
