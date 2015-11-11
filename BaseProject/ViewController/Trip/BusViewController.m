//
//  BusViewController.m
//  WeatherNews
//
//  Created by jake on 15/11/2.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BusViewController.h"
#import "DVSwitch.h"
@interface BusViewController ()

@end

@implementation BusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DVSwitch *third = [DVSwitch switchWithStringsArray:@[@"线路查询", @"路线规划",@"站点查询"]];
    third.frame = CGRectMake(10, 70, self.view.frame.size.width - 10 * 2, 30);
    third.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:18];
    third.backgroundColor = [UIColor colorWithRed:21/255.0 green:94/255.0 blue:228/255.0 alpha:0.6];
    third.sliderColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.9];
    [self.view addSubview:third];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
