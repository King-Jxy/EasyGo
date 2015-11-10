//
//  DriveViewController.h
//  WeatherNews
//
//  Created by jake on 15/11/2.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DriveViewController : UIViewController<BMKMapViewDelegate, BMKRouteSearchDelegate>
{
    IBOutlet UITextField* _startCityText;
    IBOutlet UITextField* _startAddrText;
    IBOutlet UITextField* _endCityText;
    IBOutlet UITextField* _endAddrText;
    BMKRouteSearch* _routesearch;
    __weak IBOutlet UIButton *_centerButton;
}

-(IBAction)onClickBusSearch;
-(IBAction)onClickDriveSearch;
-(IBAction)onClickWalkSearch;
- (IBAction)textFiledReturnEditing:(id)sender;


@end
