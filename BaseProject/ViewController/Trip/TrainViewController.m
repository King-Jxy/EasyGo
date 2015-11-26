//
//  TrainViewController.m
//  WeatherNews
//
//  Created by jake on 15/11/2.
//  Copyright © 2015年 Tarena. All rights reserved.
//
//此界面也充当出行这一块的主界面，可以推到其他的界面，所以在本界面上会初始化其他vc对象
#import "TrainViewController.h"
#import "ReMenu.h"
#import "DriveViewController.h"
#import "CoachViewController.h"
#import "BusViewController.h"
#import "GoLocationViewController.h"
#import "LocationViewController.h"
#import "CalendarHomeViewController.h"
#import "CalendarViewController.h"
#import "Color.h"
#import "TrainViewModel.h"
#import "LeftTicketViewController.h"
#import "TrainTimeViewController.h"
@interface TrainViewController () <GoLocationViewControllerDelegate,LocationViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) DriveViewController *dvc;
@property (nonatomic , strong) CoachViewController *svc;
@property (nonatomic , strong) BusViewController *bvc;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic , strong) NSString *start;
@property (nonatomic , strong) NSString *end;

@property (nonatomic , strong) NSString *startDate;
@property (nonatomic , strong) NSString *startDateWeek;
@property (nonatomic , strong) NSDate *date;
@property (nonatomic , strong) CalendarHomeViewController *chvc;

@property (nonatomic , strong) TrainViewModel *trainVM;
@property (nonatomic , strong) NSIndexPath *textFieldIndex;
@end

@implementation TrainViewController
- (instancetype)init{
    self = [super init];
    if (self) {
        //注册广播
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessage:) name:@"location" object:nil];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"出行方式" style:UIBarButtonItemStyleBordered target:self action:@selector(showReMenu)];
    self.tableView.tableFooterView = [UIView new];
   
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)closeKeyBoard {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.textFieldIndex];
    UITextField *tf = (UITextField *)[cell.contentView viewWithTag:100];
    [tf resignFirstResponder];
}


#pragma mark - 起点和终点选择的代理方法
- (void)goLocationView:(GoLocationViewController *)senderVC withDistination:(NSString *)destination{
    self.end = destination;
    [self.tableView reloadData];
}

- (void)locationViewEnd:(LocationViewController *)senderVC withLocalName:(NSString *)localName{
    self.start = localName;
    [self.tableView reloadData];
}

#pragma mark - 广播接收消息

-(void)receiveMessage:(NSNotification *)notification{
    
    NSDictionary *location = notification.userInfo;
    //按照key值，取到value
    self.start = location[@"start"];
    self.end = location[@"end"];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - ReMenu
- (void)showReMenu{
    if (_menu.isOpen)
        return [_menu close];
    
    REMenuItem *homeItem = [[REMenuItem alloc] initWithTitle:@"火车，动车，高铁"
                                                    subtitle:@"支持实时余票查询，车次查询"
                                                       image:nil
                                            highlightedImage:nil
                                                      action:^(REMenuItem *item) {
                                                          NSLog(@"Item: %@", item);
                                                          [self.dvc.view removeFromSuperview];
                                                          [self.svc.view removeFromSuperview];
                                                          [self.bvc.view removeFromSuperview];
                                                          self.title = @"火车出行";
                                                      }];
    
    REMenuItem *exploreItem = [[REMenuItem alloc] initWithTitle:@"自驾"
                                                       subtitle:@"基于百度地图导航"
                                                          image:nil
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             NSLog(@"Item: %@", item);
                                                             
                                                             [self.svc.view removeFromSuperview];
                                                             [self.bvc.view removeFromSuperview];
                                                             [self.view addSubview:self.dvc.view];
                                                             self.title = @"自驾出行";
                                                         }];
    
    REMenuItem *activityItem = [[REMenuItem alloc] initWithTitle:@"长途汽车"
                                                        subtitle:@"长途汽车站点、时刻表和价格查询"
                                                           image:nil
                                                highlightedImage:nil
                                                          action:^(REMenuItem *item) {
                                                              NSLog(@"Item: %@", item);
                                                              [self.dvc.view removeFromSuperview];
                                                              [self.bvc.view removeFromSuperview];
                                                              [self.view addSubview:self.svc.view];
                                                              self.title = @"巴士出行";
                                                          }];
    
    REMenuItem *profileItem = [[REMenuItem alloc] initWithTitle:@"公交"
                                                       subtitle:@"公交线路规划，站点查询"
                                                          image:nil
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             NSLog(@"Item: %@", item);
                                                             [self.svc.view removeFromSuperview];
                                                             [self.dvc.view removeFromSuperview];
                                                             [self.view addSubview:self.bvc.view];
                                                             self.title = @"公交出行";
                                                         }];
    
    self.menu = [[REMenu alloc] initWithItems:@[homeItem, exploreItem, activityItem, profileItem]];
    _menu.cornerRadius = 5;
    _menu.textColor = [UIColor whiteColor];
//    _menu.backgroundColor = kRGBAColor(21, 94, 228,0.6);
    _menu.subtitleTextColor = [UIColor whiteColor];
    _menu.backgroundAlpha = 0.5;
    _menu.separatorColor = [UIColor whiteColor];
    _menu.subtitleTextShadowColor = [UIColor clearColor];
    _menu.imageOffset = CGSizeMake(30, -1);
    [self.menu showFromNavigationController:self.navigationController];
}
#pragma mark - TableViewDateSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 1;
    }else if(section == 1){
        return 3;
    }else{
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if(indexPath.section == 0){
        self.textFieldIndex = indexPath;
        cell = [tableView dequeueReusableCellWithIdentifier:@"TrainTimeQueryCell" forIndexPath:indexPath];
        UITextField *tf = (UITextField *)[cell.contentView viewWithTag:100];
        UIButton *btn = (UIButton *)[cell.contentView viewWithTag:200];
//查询推出下一个视图
        [btn bk_addEventHandler:^(id sender) {
            if(!tf.text) {
                [self showErrorMsg:@"未输入车次"];
                return ;
            }
            TrainTimeViewController *tvc = [kStoryboard(@"Main")instantiateViewControllerWithIdentifier:@"TrainTimeViewController"];
            tvc.trainName = tf.text;
            [self.navigationController pushViewController:tvc animated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
    }else if(indexPath.section == 1){
        if(indexPath.row == 0){
            cell = [tableView dequeueReusableCellWithIdentifier:@"TrainStartCell" forIndexPath:indexPath];
            cell.detailTextLabel.text = self.start;
            cell.imageView.image = [UIImage imageNamed:@"map_start_26px.png"];
        }else if(indexPath.row == 1){
            cell = [tableView dequeueReusableCellWithIdentifier:@"TrainEndCell" forIndexPath:indexPath];
            cell.detailTextLabel.text = self.end;
            cell.imageView.image = [UIImage imageNamed:@"map_end_26px.png"];
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:@"TrainStartDateCell" forIndexPath:indexPath];
            cell.detailTextLabel.text = self.startDateWeek;
            
        }
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"TrainSearchCell" forIndexPath:indexPath];
    }
    return cell;
}


#pragma mark - TableViewDelegate 
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section == 0){
        return 25;
    }else{
        return 10;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return @"列车时刻列表";
    }else if(section == 1){
        return @"站到站余票查询";
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return 60;
    }else{
        return 46;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 1){
        if(indexPath.row == 0){
            LocationViewController *lvc = [kStoryboard(@"Main")instantiateViewControllerWithIdentifier:@"LocationViewController"];
            lvc.delegate = self;
            [self.navigationController pushViewController:lvc animated:YES];
        }else if(indexPath.row == 1){
            GoLocationViewController *gvc = [kStoryboard(@"Main")instantiateViewControllerWithIdentifier:@"GoLocationViewController"];
            gvc.delegate = self;
            [self.navigationController pushViewController:gvc animated:YES];
        }else{
            __weak TrainViewController *weakSelf = self;
            self.chvc.calendarblock = ^(CalendarDayModel *model){
                
//                NSLog(@"\n---------------------------");
//                NSLog(@"1星期 %@",[model getWeek]);
//                NSLog(@"2字符串 %@",[model toString]);
//                NSLog(@"3节日  %@",model.holiday);
                
            weakSelf.startDateWeek = [NSString stringWithFormat:@"%@ %@",[model toString],[model getWeek]];
                weakSelf.startDate =[NSString stringWithFormat:@"%@",[model toString]];
                weakSelf.date = model.date;
                [weakSelf.tableView reloadData];
            };
            
            [self.navigationController pushViewController:self.chvc animated:YES];

        }
    }else if(indexPath.section == 2){
        if(!self.start){
            [self showErrorMsg:@"未填写出发站"];
        }else if(!self.end){
            [self showErrorMsg:@"未填写到达站"];
        }else{
            if([self daysWithinEraFromDate:[NSDate date] toDate:self.date]>60){
                [self showErrorMsg:@"时间不在订票范围内"];
                return;
            }
        [self showProgress];
        [self.trainVM getLeftTicketDataFromStation:self.start toStation:self.end andDate:self.startDate completionHandle:^(NSError *error) {
            [self hideProgress];
            if([[self.trainVM getErrorCode] isEqualToString:@"000"]){
                if([self.trainVM getResError]){
                    [self showErrorMsg:[self.trainVM getResError]];
                }
                if([self.trainVM getTrainCount] == 0){
                    [self showErrorMsg:@"当天已无列车"];
                }else{
//推出下一个界面（查询成功）
                    LeftTicketViewController *lvc = [kStoryboard(@"Main")instantiateViewControllerWithIdentifier:@"LeftTicketViewController"];
                    lvc.trainVM = self.trainVM;
                    [self.navigationController pushViewController:lvc animated:YES];
                }
                
            }else if([[self.trainVM getErrorCode] isEqualToString:@"001"]){
                [self showErrorMsg:@"未填写出发站"];
                
            }else if([[self.trainVM getErrorCode] isEqualToString:@"002"]){
                [self showErrorMsg:@"未填写到达站"];
            }else if([[self.trainVM getErrorCode] isEqualToString:@"003"]){
                [self showErrorMsg:@"此两地之间未通列车"];
            }
        }];
        }
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark- 其他界面的初始化
- (DriveViewController *)dvc {
	if(_dvc == nil) {
		_dvc = [kStoryboard(@"Main")instantiateViewControllerWithIdentifier:@"DriveViewController"];
        _dvc.navigationController = self.navigationController;
	}
	return _dvc;
}

- (CoachViewController *)svc {
	if(_svc == nil) {
        _svc = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"CoachViewController"] ;
        _svc.navigationController = self.navigationController;
	}
	return _svc;
}

- (BusViewController *)bvc {
	if(_bvc == nil) {
		_bvc = [kStoryboard(@"Main")instantiateViewControllerWithIdentifier:@"BusViewController"];
        _bvc.navigationController = self.navigationController;
	}
	return _bvc;
}

- (CalendarHomeViewController *)chvc {
	if(_chvc == nil) {
		_chvc = [[CalendarHomeViewController alloc] init];
        _chvc.calendartitle = @"选择出行日期";
        [_chvc setAirPlaneToDay:365 ToDateforString:nil];
	}
	return _chvc;
}

- (NSString *)startDateWeek {
	if(_startDateWeek == nil) {
		_startDateWeek = [[NSString alloc] init];
        _startDateWeek = [self getDateAndWeek];
	}
	return _startDateWeek;
}

- (TrainViewModel *)trainVM {
	if(_trainVM == nil) {
		_trainVM = [[TrainViewModel alloc] init];
	}
	return _trainVM;
}

- (NSString *)startDate {
	if(_startDate == nil) {
		_startDate = [[NSString alloc] init];
        _startDate = [self getDate];
	}
	return _startDate;
}

- (NSDate *)date {
	if(_date == nil) {
		_date = [NSDate date];
	}
	return _date;
}

@end
