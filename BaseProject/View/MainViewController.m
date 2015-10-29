//
//  MainViewController.m
//  BaseProject
//
//  Created by jake on 15/10/22.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MainViewController.h"
#import "LocationViewController.h"
#import "GoLocationViewController.h"
#import "WeatherViewModel.h"
#import "WeatherView.h"
#import "NewsListViewModel.h"
@interface MainViewController () <LocationViewControllerDelegate,GoLocationViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *newsTableView;

@property (weak, nonatomic) IBOutlet UIImageView *cityImageView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *placeSegment;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *setMyLocation;


@property (strong, nonatomic) WeatherView *weatherView;


//本地的地址
@property (nonatomic , strong) NSString *localName;
@property (nonatomic , strong) WeatherViewModel *weatherVM;
@property (nonatomic , strong) NewsListViewModel *newsListVM;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.newsTableView.delegate = self;
    self.newsTableView.dataSource = self;
    
    
    self.newsTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.newsListVM refreshDataCompletionHandle:^(NSError *error) {
            [self.newsTableView reloadData];
            [self.newsTableView.header endRefreshing];
            if(error){
                DDLogVerbose(@"%@",error.userInfo);
            }
        }];
    }];
    
    [self.newsTableView.header beginRefreshing];
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    
    self.newsTableView.tableHeaderView = self.weatherView;
}

//实现代理方法
- (void)locationViewEnd:(LocationViewController *)senderVC withLocalName:(NSString *)localName{
    self.localName = localName;
    DDLogVerbose(@"本地地址是%@",self.localName);
    [self.placeSegment setTitle:self.localName forSegmentAtIndex:0];
    [self.weatherView.imageActivity startAnimating];
    [self.weatherVM getWeatherDataWithCity:localName completionHandle:^(NSError *error) {
        self.weatherView.weatherVM = self.weatherVM;
        [self.weatherView.imageActivity stopAnimating];
    }];
}

- (void)goLocationView:(GoLocationViewController *)senderVC withDistination:(NSString *)destination{
    self.destination = destination;
    DDLogVerbose(@"目的地址是%@",self.destination);
    [self.placeSegment setTitle:self.destination forSegmentAtIndex:1];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"MyLocationSegue"]){
        LocationViewController *vc = segue.destinationViewController;
        vc.delegate = self;
    }else if([segue.identifier isEqualToString:@"GoLocationSegue"]){
        GoLocationViewController *vc = segue.destinationViewController;
        vc.delegate = self;
    }
}

#pragma Mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.newsListVM getRowNum];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    NSInteger num = [self.newsListVM getImageCountAtIndex:indexPath];
    if(num == 0){
        cell = [tableView dequeueReusableCellWithIdentifier:@"NOPCell" forIndexPath:indexPath];
        UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:100];
        titleLabel.text = [self.newsListVM getTitleAtIndex:indexPath];
        UILabel *siteLabel = (UILabel *)[cell.contentView viewWithTag:101];
        siteLabel.text = [self.newsListVM getSiteAtIndex:indexPath];
        [cell.contentView addSubview:titleLabel];
        [cell.contentView addSubview:siteLabel];
    }else if(num == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:@"OnePCell" forIndexPath:indexPath];
        UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:100];
        titleLabel.text = [self.newsListVM getTitleAtIndex:indexPath];
        UILabel *siteLabel = (UILabel *)[cell.contentView viewWithTag:101];
        siteLabel.text = [self.newsListVM getSiteAtIndex:indexPath];
        UIImageView *image = (UIImageView *)[cell.contentView viewWithTag:200];
        [image setImageWithURL:[self.newsListVM getImageURLArrAtIndex:indexPath].firstObject];
        [cell.contentView addSubview:image];
        [cell.contentView addSubview:titleLabel];
        [cell.contentView addSubview:siteLabel];
    }else if(num == 3){
        cell = [tableView dequeueReusableCellWithIdentifier:@"ThreePCell" forIndexPath:indexPath];
        UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:100];
        titleLabel.text = [self.newsListVM getTitleAtIndex:indexPath];
        NSArray *imageUrls = [self.newsListVM getImageURLArrAtIndex:indexPath];
        UIImageView *image1 = (UIImageView *)[cell.contentView viewWithTag:200];
        [image1 setImageWithURL:imageUrls.firstObject];
        UIImageView *image2 = (UIImageView *)[cell.contentView viewWithTag:201];
        [image2 setImageWithURL:imageUrls[1]];
        UIImageView *image3 = (UIImageView *)[cell.contentView viewWithTag:202];
        [image3 setImageWithURL:imageUrls.lastObject];
        [cell.contentView addSubview:image1];
        [cell.contentView addSubview:image2];
        [cell.contentView addSubview:image3];
        [cell.contentView addSubview:titleLabel];
        
    }
    return cell;
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.newsTableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)localName {
	if(_localName == nil) {
		_localName = [[NSString alloc] init];
        //此处做一个本地址的数据持久化
	}
	return _localName;
}

- (WeatherViewModel *)weatherVM {
	if(_weatherVM == nil) {
		_weatherVM = [[WeatherViewModel alloc] init];
	}
	return _weatherVM;
}

- (WeatherView *)weatherView {
	if(_weatherView == nil) {
		_weatherView = [[WeatherView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH * 3.0/10)];
        _weatherView.bkImageView.image = [UIImage imageNamed:@"bg.jpg"];
        _weatherView.backgroundColor = [UIColor grayColor];
	}
	return _weatherView;
}

- (NewsListViewModel *)newsListVM {
	if(_newsListVM == nil) {
		_newsListVM = [[NewsListViewModel alloc] init];
	}
	return _newsListVM;
}

@end
