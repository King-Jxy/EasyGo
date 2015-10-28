//
//  GoLocationViewController.h
//  BaseProject
//
//  Created by jake on 15/10/28.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoLocationViewController;
@protocol GoLocationViewControllerDelegate <NSObject>

- (void)goLocationView:(GoLocationViewController *)senderVC withDistination:(NSString *)destination;

@end

@interface GoLocationViewController : UITableViewController
@property (nonatomic , weak) id<GoLocationViewControllerDelegate>delegate;
@end
