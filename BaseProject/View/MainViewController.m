//
//  MainViewController.m
//  BaseProject
//
//  Created by jake on 15/10/22.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UITableView *newsTableView;
@property (weak, nonatomic) IBOutlet UIView *weatherView;
@property (weak, nonatomic) IBOutlet UIView *chooseButtonView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *placeSegment;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *setMyLocation;
//本地的地址
@property (nonatomic , strong) NSString *local;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}


@end
