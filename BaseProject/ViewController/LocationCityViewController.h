//
//  LocationCityViewController.h
//  BaseProject
//
//  Created by jake on 15/10/26.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityListViewModel.h"
@interface LocationCityViewController : UITableViewController
- (instancetype) initWithCityArray:(NSArray *)cityArray;
@property (nonatomic , strong) CityListViewModel *cityListVM;
@end
