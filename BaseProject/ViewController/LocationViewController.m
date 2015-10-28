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
@interface LocationViewController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,UISearchDisplayDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic , strong) CLLocationManager *manager;
@property (nonatomic , strong) CityListViewModel *cityListVM;
@property (nonatomic , strong) NSString *locationName;//存储定位得到的地址

@property (nonatomic , strong) NSMutableArray *searchCity;//存储搜索出来的数组
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
    
    // 为负责显示数据的表格注册单元格
    [self.searchDisplayController.searchResultsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location = locations.firstObject;
    DDLogVerbose(@"location %@",location);
    
    [self.manager stopUpdatingLocation];
    
//反编码获得地址
    [self reGeocoder:location];
    
}

//反地理编码
- (void)reGeocoder:(CLLocation *)location{
    CLGeocoder *geocoder = [CLGeocoder new];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark *mark in placemarks) {
            DDLogVerbose(@"本地地址：%@",mark.name);
            self.locationName = mark.locality;
            DDLogVerbose(@"定位好了");
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
    if(tableView == self.searchDisplayController.searchResultsTableView){
        return self.searchCity.count;
    }else{
        if(section == 0){
            return 1;
        }else if(section == 1){
            return [self.cityListVM getProviceCount];
        }else{
            return 0;
        }
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if(tableView == self.searchDisplayController.searchResultsTableView){
        cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell"];
        if(cell == nil){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SearchCell"];
            cell.textLabel.text = self.searchCity[indexPath.row];
        }
    }else{
        if(indexPath.section == 0 ){
            cell = [tableView dequeueReusableCellWithIdentifier:@"HeaderCell" forIndexPath:indexPath];
            UILabel *label = (UILabel *)[cell.contentView viewWithTag:100];
            label.text = self.locationName;
    
        }else{
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ProviceCell"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"ProviceCell" forIndexPath:indexPath];
            cell.textLabel.text = [self.cityListVM getProviceNameAtIndex:indexPath];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
       
        }
    }
    return cell;
}


#pragma mark TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(tableView == self.tableView){
        if(!indexPath.section){
            DDLogVerbose(@"开始定位");
//开始更新位置信息
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeIndeterminate;
            hud.labelText = @"正在获取您的当前位置";
            [self.manager startUpdatingLocation];
            [hud hide:YES afterDelay:1];
        
        }else{
            NSString *selectedProvice = [self.cityListVM getProviceNameAtIndex:indexPath];
//获取在该省份对象数组
            NSArray *cityArray = [self.cityListVM getCityListModelFromProvice:selectedProvice];
//推送结果到下一个视图
            LocationCityViewController *vc = [[LocationCityViewController alloc] initWithCityArray:cityArray];
            vc.cityListVM = self.cityListVM;
            [self.navigationController pushViewController:vc animated:YES];
        
        }
    }else{
//存储选择的位置
        self.locationName = self.searchCity[indexPath.row];
    }
}

#pragma mark - Search Display  Delegate

//当选中的分类按钮 发生改变时，立即执行此方法

//-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption{
//    // 输入的文本
//    NSString *inputText = self.searchDisplayController.searchBar.text;
//    
//    [self searchCityWithDistrictName:inputText];
//    return YES;
//}

//当在bar中输入的搜索文本发生改变时，立即执行此方法
//参数 传进来的就是  在bar的text中输入的搜索信息
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    //获取此时bar上选中的scope按钮的索引
    
    [self searchCityWithDistrictName:searchString];
    return YES;
}

//根据 bar中输入的text和选中的分类进行筛选数据
-(void)searchCityWithDistrictName:(NSString *)name{
    NSMutableArray *array = [NSMutableArray array];
    
    for (CityListDataModel *model in self.cityListVM.cityList) {
        // 查看字符串B在A中出现的位置，及占用的长度
        // ABCDE -> BCD  location=1 length =3
        NSRange range = [model.district rangeOfString:name];
        if (range.length>0 ) {
            [array addObject:model.district];
        }
    }
    
    self.searchCity = [array copy];
}


- (CityListViewModel *)cityListVM {
	if(_cityListVM == nil) {
		_cityListVM = [[CityListViewModel alloc] init];
	}
	return _cityListVM;
}


- (NSMutableArray *)searchCity{
    if(!_searchCity){
        _searchCity = [NSMutableArray array];
    }
    return _searchCity;

}

- (NSString *)locationName{
    if(!_locationName){
        _locationName = @"定位当前地址";
    }
    return _locationName;

}
@end
