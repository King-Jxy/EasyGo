//
//  LocationCityViewController.m
//  BaseProject
//
//  Created by jake on 15/10/26.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "LocationCityViewController.h"
#import "CityListModel.h"
#import "LocationDistrictViewController.h"
@interface LocationCityViewController ()
@property (nonatomic , strong) NSArray *citys;//存储城市名
@end

@implementation LocationCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
}

kRemoveCellSeparator
- (instancetype) initWithCityArray:(NSArray *)cityArray{
    self = [super init];
    if (self) {
        NSMutableArray *cityArr = [NSMutableArray array];
        for (CityListDataModel *model in cityArray) {
            if(![cityArr containsObject:model.city]){
                [cityArr addObject:model.city];
            }
        }
        self.citys = [cityArr copy];
    }
    return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.citys.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CityCell" forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityCell"];
    if(cell == nil){
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cityCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSString *city = self.citys[indexPath.row];
    cell.textLabel.text = city;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//  下句在用segue的时候进行指定时机跳转
//    [self performSegueWithIdentifier:@"City2District" sender:self];
    NSString *cityName = self.citys[indexPath.row];
    NSArray *districtArr = [self.cityListVM getDistrictListModelFromCity:cityName];
    LocationDistrictViewController *vc = [[LocationDistrictViewController alloc]initWithDistrictArray:districtArr];
    [self.navigationController  pushViewController:vc animated:YES];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *index = [self.tableView indexPathForSelectedRow];
    NSString *cityName = self.citys[index.row];
    NSArray *districtArr = [self.cityListVM getDistrictListModelFromCity:cityName];
    LocationDistrictViewController *vc = [[LocationDistrictViewController alloc]initWithDistrictArray:districtArr];
    vc = segue.destinationViewController;
    
}


@end
