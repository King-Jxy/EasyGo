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
#import "NewsWebViewController.h"

#define kFloatingViewMinimumHeight 85
#define kFloatingViewMaximumHeight self.view.bounds.size.height/3

@interface MainViewController () <LocationViewControllerDelegate,GoLocationViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *newsTableView;

@property (weak, nonatomic) IBOutlet UIImageView *cityImageView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *placeSegment;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *setMyLocation;

@property (weak, nonatomic) IBOutlet UIButton *goWhereBtn;


@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (weak, nonatomic) IBOutlet WeatherView *headerView;

//本地的地址
@property (nonatomic , strong) NSString *localName;
@property (nonatomic , strong) WeatherViewModel *weatherVM;
@property (nonatomic , strong) NewsListViewModel *newsListVM;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewHeightConstraint;
@property (nonatomic , strong) id savedDelegate;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.newsTableView.delegate = self;
    self.newsTableView.dataSource = self;
    self.headerView.clipsToBounds = YES;
    
    CALayer *layer = _goWhereBtn.layer;
    layer.shadowColor = [[UIColor blackColor]CGColor];
    layer.cornerRadius = 30;
    //透明度
    layer.shadowOpacity = 0.6;
    self.edgesForExtendedLayout = UIRectEdgeNone;//因为会利用到tableView的contentInset，所以不想系统给我们改，最好把这个设置为UIRectEdgeNone,否则在viewDidAppear的时候tableView的contentInset会变
    self.newsTableView.contentInset = UIEdgeInsetsMake(kFloatingViewMaximumHeight, 0, 0, 0);
    [self.newsTableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    
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
    
    [self.placeSegment addTarget:self action:@selector(placeChanged:) forControlEvents:UIControlEventValueChanged];
}


- (void)dealloc{
    [self.newsTableView removeObserver:self forKeyPath:@"contentOffset"];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.savedDelegate = self.navigationController.interactivePopGestureRecognizer.delegate;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;//这里是为了保留系统的右滑返回手势
//    self.newsTableView.tableHeaderView = self.weatherView;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = self.savedDelegate;//这里是为了保留系统的右滑返回手势
    
}

//切换本地和目的地
- (void)placeChanged:(UISegmentedControl *)sender{
    if(sender.selectedSegmentIndex == 0){
        if(!self.localName){
            [self showErrorMsg:@"未确认本地地址"];
            return;
        }
        [self.headerView.imageActivity startAnimating];
        [self.weatherVM getWeatherDataWithCity:self.localName completionHandle:^(NSError *error) {
            self.headerView.weatherVM = self.weatherVM;
            [self.weatherImageView setImageWithURL:[self.weatherVM getImageURL] ];
            [self.headerView.imageActivity stopAnimating];
        }];
    }else{
        if(!self.destination){
            [self showErrorMsg:@"未指定目的地"];
            return;
        }
        [self.headerView.imageActivity startAnimating];
        [self.weatherVM getWeatherDataWithCity:self.destination completionHandle:^(NSError *error) {
            self.headerView.weatherVM = self.weatherVM;
            [self.weatherImageView setImageWithURL:[self.weatherVM getImageURL] ];
            [self.headerView.imageActivity stopAnimating];
        }];
    }
}

//实现代理方法
- (void)locationViewEnd:(LocationViewController *)senderVC withLocalName:(NSString *)localName{
    self.localName = localName;
    DDLogVerbose(@"本地地址是%@",self.localName);
    [self.placeSegment setTitle:self.localName forSegmentAtIndex:0];
    if(self.placeSegment.selectedSegmentIndex == 0){
        [self.headerView.imageActivity startAnimating];
        [self.weatherVM getWeatherDataWithCity:localName completionHandle:^(NSError *error) {
            self.headerView.weatherVM = self.weatherVM;
        [self.weatherImageView setImageWithURL:[self.weatherVM getImageURL] ];
        [self.headerView.imageActivity stopAnimating];
        }];
    }
}

- (void)goLocationView:(GoLocationViewController *)senderVC withDistination:(NSString *)destination{
    self.destination = destination;
    DDLogVerbose(@"目的地址是%@",self.destination);
    [self.placeSegment setTitle:self.destination forSegmentAtIndex:1];
    if(self.placeSegment.selectedSegmentIndex == 1){
        [self.headerView.imageActivity startAnimating];
        [self.weatherVM getWeatherDataWithCity:destination completionHandle:^(NSError *error) {
            self.headerView.weatherVM = self.weatherVM;
            [self.weatherImageView setImageWithURL:[self.weatherVM getImageURL] ];
            [self.headerView.imageActivity stopAnimating];
        }];
    }
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


//浮动headerView效果：
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
        NSLog(@"offset.y: %lf",offset.y);
        NSLog(@"%d",kFloatingViewMinimumHeight);
        if (offset.y <= 0 && 0-offset.y >= kFloatingViewMinimumHeight) {
            self.headerViewHeightConstraint.constant = 0 - offset.y;
        } else {
            self.headerViewHeightConstraint.constant = kFloatingViewMinimumHeight;
        }
    }
    NSLog(@"%lf",self.headerView.frame.size.height);
}


#pragma mark - TableViewDataSource
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
//        UILabel *timeLabel = (UILabel *)[cell.contentView viewWithTag:102];
//        timeLabel.text = [self.newsListVM getTimeAgoAtIndex:indexPath];

    }else if(num == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:@"OnePCell" forIndexPath:indexPath];
        UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:100];
        titleLabel.text = [self.newsListVM getTitleAtIndex:indexPath];
        UILabel *siteLabel = (UILabel *)[cell.contentView viewWithTag:101];
        siteLabel.text = [self.newsListVM getSiteAtIndex:indexPath];
//        UILabel *timeLabel = (UILabel *)[cell.contentView viewWithTag:102];
//        timeLabel.text = [self.newsListVM getTimeAgoAtIndex:indexPath];
        UIImageView *image = (UIImageView *)[cell.contentView viewWithTag:200];
        [image setImageWithURL:[self.newsListVM getImageURLArrAtIndex:indexPath].firstObject];

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
        
    }
    return cell;
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.newsTableView deselectRowAtIndexPath:indexPath animated:YES];
    NSURL *url = [self.newsListVM getWebURLAtIndex:indexPath];
    NewsWebViewController *vc = [[NewsWebViewController alloc]initWithURL:url];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (NSString *)localName {
	if(_localName == nil) {
		_localName = [[NSString alloc] init];
        //此处做一个本地址的数据持久化
#warning TODO 此处做一个本地址的数据持久化
	}
	return _localName;
}

- (WeatherViewModel *)weatherVM {
	if(_weatherVM == nil) {
		_weatherVM = [[WeatherViewModel alloc] init];
	}
	return _weatherVM;
}



- (NewsListViewModel *)newsListVM {
	if(_newsListVM == nil) {
		_newsListVM = [[NewsListViewModel alloc] init];
	}
	return _newsListVM;
}

@end
