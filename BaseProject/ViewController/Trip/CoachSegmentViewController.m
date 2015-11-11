//
//  CoachSegmentViewController.m
//  EasyGo
//
//  Created by jake on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "CoachSegmentViewController.h"
#import "CoachViewController.h"
#import "DVSwitch.h"
@interface CoachSegmentViewController ()
@property (weak, nonatomic) IBOutlet UIButton *startCity;
@property (weak, nonatomic) IBOutlet UIButton *endCity;
@property (weak, nonatomic) IBOutlet UIButton *exchangeBtn;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (nonatomic , strong) DVSwitch *third;
@end

@implementation CoachSegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DVSwitch *third = [DVSwitch switchWithStringsArray:@[@"汽车站信息", @"站到站查询"]];
    third.frame = CGRectMake(10, 70, self.view.frame.size.width - 10 * 2, 30);
    third.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:18];
    third.backgroundColor = [UIColor colorWithRed:21/255.0 green:94/255.0 blue:228/255.0 alpha:0.6];
    third.sliderColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.9];
    [self.view addSubview:third];
    [third setPressedHandler:^(NSUInteger index) {
        if(index == 0){
            [self.dvSwitch forceSelectedIndex:0 animated:NO];
            [self.view removeFromSuperview];
        }
    }];
    self.third = third;
    CALayer *layer = self.searchBtn.layer;
    layer.shadowColor = [[UIColor blackColor]CGColor];
    layer.cornerRadius = 10;
    layer.shadowOpacity = 0.6;
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.third forceSelectedIndex:1 animated:NO];
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
