//
//  LocationDistrictViewController.m
//  BaseProject
//
//  Created by jake on 15/10/26.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "LocationDistrictViewController.h"
#import "CityListModel.h"
#import "LocationViewController.h"
#import "MainViewController.h"
@interface LocationDistrictViewController ()
@property (nonatomic , strong) NSArray *districts;
@end

@implementation LocationDistrictViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
}

kRemoveCellSeparator
- (instancetype)initWithDistrictArray:(NSArray *)districtArray{
    self = [super init];
    if (self) {
        NSMutableArray *disArr = [NSMutableArray array];
        for (CityListDataModel *model in districtArray) {
            if(![disArr containsObject:model.district]){
                [disArr addObject:model.district];
            }
        }
        self.districts = [disArr copy];
    }
    return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.districts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"districtCell" ];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"districtCell"];
        
    }
    cell.textLabel.text = self.districts[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *message = [NSString stringWithFormat:@"切换到 %@",self.districts[indexPath.row]];
    UIAlertView *alertView = [[UIAlertView alloc]bk_initWithTitle:@"设置成功" message:message];
    [alertView bk_addButtonWithTitle:@"确定" handler:^{
//给代理发送消息
        [self.delegate locationDistrictView:self withLocalName:self.districts[indexPath.row]];
//把获得的值统一传回给LocationViewController来处理
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [alertView show];
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
