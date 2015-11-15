//
//  SubwayViewController.m
//  WeatherNews
//
//  Created by jake on 15/11/2.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "CoachViewController.h"
#import "CoachSegmentViewController.h"
#import "DVSwitch.h"
#import "CoachResultViewController.h"
#import "GoLocationViewController.h"
@interface CoachViewController () <GoLocationViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *cityButton;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (nonatomic , strong) CoachSegmentViewController *cvc;

@property (nonatomic , strong) NSString *city;
@end

@implementation CoachViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DVSwitch *third = [DVSwitch switchWithStringsArray:@[@"汽车站信息", @"站到站查询"]];
    third.frame = CGRectMake(10, 5, self.view.frame.size.width - 10 * 2, 30);
    third.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:18];
    third.backgroundColor = [UIColor colorWithRed:21/255.0 green:94/255.0 blue:228/255.0 alpha:0.6];
    third.sliderColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.9];
    [self.view addSubview:third];
    self.cvc.dvSwitch = third;
    [third setPressedHandler:^(NSUInteger index) {
        if(index == 1){
            
            [self.view addSubview:self.cvc.view];
        }
    }];
    CALayer *layer = self.cityButton.layer;
    layer.cornerRadius = 25;
    layer.shadowOpacity = 0.6;
    layer = self.searchButton.layer;
    layer.shadowColor = [[UIColor blackColor]CGColor];
    layer.cornerRadius = 10;
    layer.shadowOpacity = 0.6;
    
    [self.searchButton bk_addEventHandler:^(id sender) {
        CoachResultViewController *crvc = [kStoryboard(@"Main")instantiateViewControllerWithIdentifier:@"CoachResultViewController"];
        crvc.city = self.city;
        [self.navigationController pushViewController:crvc animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.cityButton bk_addEventHandler:^(id sender) {
        GoLocationViewController *gvc = [kStoryboard(@"Main")instantiateViewControllerWithIdentifier:@"GoLocationViewController"];
        gvc.delegate = self;
        [self.navigationController pushViewController:gvc animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
}

- (void)goLocationView:(GoLocationViewController *)senderVC withDistination:(NSString *)destination{
    self.city = destination;
    [self.cityButton setTitle:destination forState:UIControlStateNormal];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (CoachSegmentViewController *)cvc {
	if(_cvc == nil) {
		_cvc = [kStoryboard(@"Main")instantiateViewControllerWithIdentifier:@"CoachSegmentViewController"];
        _cvc.navigationController = self.navigationController;
	}
	return _cvc;
}

@end
