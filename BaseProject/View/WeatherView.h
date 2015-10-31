//
//  WeatherView.h
//  BaseProject
//
//  Created by jake on 15/10/29.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherViewModel.h"
@interface WeatherView : UIView

@property (nonatomic , strong) WeatherViewModel *weatherVM;

//@property (nonatomic , strong) UIImageView *bkImageView;
@property (nonatomic , strong) UIImageView *weatherIcon;
@property (nonatomic , strong) UILabel *weatherLabel;
@property (nonatomic , strong) UILabel *cityLabel;
@property (nonatomic , strong) UILabel *weekLabel;
@property (nonatomic , strong) UILabel *dateLabel;
@property (nonatomic , strong) UILabel *temp;


@property (strong, nonatomic)  UIButton *goWhereButton;
@property (strong, nonatomic)  UIActivityIndicatorView *imageActivity;







@end
