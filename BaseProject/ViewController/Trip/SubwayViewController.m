//
//  SubwayViewController.m
//  WeatherNews
//
//  Created by jake on 15/11/2.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "SubwayViewController.h"

@interface SubwayViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation SubwayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor  = [UIColor greenColor];
    self.label.text = @"地铁";
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
