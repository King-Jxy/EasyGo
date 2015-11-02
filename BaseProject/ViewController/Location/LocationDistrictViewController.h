//
//  LocationDistrictViewController.h
//  BaseProject
//
//  Created by jake on 15/10/26.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationViewController.h"
@class LocationDistrictViewController;
@protocol LocationDistrictViewControllerDelegate <NSObject>

- (void)locationDistrictView:(LocationDistrictViewController *)senderVC withLocalName:(NSString *)localName;

@end
@interface LocationDistrictViewController : UITableViewController
- (instancetype)initWithDistrictArray:(NSArray *)districtArray;
@property (nonatomic , weak) id<LocationDistrictViewControllerDelegate> delegate;

@end

