//
//  GoLocationViewController.m
//  BaseProject
//
//  Created by jake on 15/10/28.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "GoLocationViewController.h"
#import "CityListViewModel.h"
#import "LocationCityViewController.h"
#import "MainViewController.h"
#import "LocationDistrictViewController.h"
@interface GoLocationViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchDisplayDelegate,LocationDistrictViewControllerDelegate>

@property (nonatomic , strong) CityListViewModel *cityListVM;

//用于存储目的地的地址
@property (nonatomic , strong) NSString *destination;
@property (nonatomic , strong) NSMutableArray *searchCity;//存储搜索出来的数组
@end

@implementation GoLocationViewController

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




#pragma mark TableViewDataSource

kRemoveCellSeparator
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == self.searchDisplayController.searchResultsTableView){
        return self.searchCity.count;
    }else{
        
        return [self.cityListVM getProviceCount];
        
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
        
      
            //        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ProviceCell"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"GoCell" forIndexPath:indexPath];
            cell.textLabel.text = [self.cityListVM getProviceNameAtIndex:indexPath];
            //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
     
    }
    return cell;
}


#pragma mark TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(tableView == self.tableView){
        
            NSString *selectedProvice = [self.cityListVM getProviceNameAtIndex:indexPath];
            //获取在该省份对象数组
            NSArray *cityArray = [self.cityListVM getCityListModelFromProvice:selectedProvice];
            //推送结果到下一个视图
            LocationCityViewController *vc = [[LocationCityViewController alloc] initWithCityArray:cityArray];
            vc.cityListVM = self.cityListVM;
            vc.dataVC = self;
            [self.navigationController pushViewController:vc animated:YES];
            
        
    }else{
        //在搜索结果中选择位置
        self.destination = self.searchCity[indexPath.row];
        //给代理方发送消息
        [self.delegate  goLocationView:self withDistination:self.destination];
        
        NSString *message = [NSString stringWithFormat:@"切换到 %@",self.destination];
        UIAlertView *alertView = [[UIAlertView alloc]bk_initWithTitle:@"设置成功" message:message];
        [alertView bk_addButtonWithTitle:@"确定" handler:^{
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        [alertView show];
    }
    
}

#pragma mark - Search Display  Delegate

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

#pragma mark - LocationDistrictViewControllerDelegate


- (void)locationDistrictView:(LocationDistrictViewController *)senderVC withLocalName:(NSString *)localName{
    self.destination = localName;
    //给代理方发送消息（给主界面）
    [self.delegate goLocationView:self withDistination:self.destination];
}

#pragma mark - 懒加载
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

@end