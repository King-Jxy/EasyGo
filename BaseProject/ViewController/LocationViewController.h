//
//  LocationViewController.h
//  BaseProject
//
//  Created by jake on 15/10/23.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LocationViewController;

@protocol LocationViewControllerDelegate <NSObject>

- (void)locationViewEnd:(LocationViewController *)senderVC withLocalName:(NSString *)localName;

@end

@interface LocationViewController : UIViewController

@property (nonatomic ,weak) id<LocationViewControllerDelegate> delegate;
@property (nonatomic , strong) NSString *locationName;//存储定位或者选择得到的地址
@end


