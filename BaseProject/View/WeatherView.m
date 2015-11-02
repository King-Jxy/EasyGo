//
//  WeatherView.m
//  BaseProject
//
//  Created by jake on 15/10/29.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "WeatherView.h"
@interface WeatherView ()
@end
@implementation WeatherView

- (void)setWeatherVM:(WeatherViewModel *)weatherVM{
    _weatherVM = weatherVM;
//重新绘画
    [self setNeedsDisplay];
}

- (void)setImageViews{



//设置随屏幕大小变化的图片
    CGRect frame = self.weatherIcon.frame;
    frame.size.height = self.frame.size.height/3;
    frame.size.width = frame.size.height;
    self.weatherIcon.frame = frame;
    self.weatherIcon.contentMode = UIViewContentModeScaleAspectFill;
    self.weatherIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[self.weatherVM getWeatherIcon]]];
    [self addSubview:self.weatherIcon];
    [self.weatherIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-5);
        make.left.mas_equalTo(10);
    }];
}

- (void)setLables{

    self.cityLabel.text = [self.weatherVM getLocalName];
    self.cityLabel.textColor = [UIColor whiteColor];
    self.cityLabel.font = [UIFont systemFontOfSize:30 weight:8];
    [self addSubview:self.cityLabel];
    [self.cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.top.mas_equalTo(15);
    }];
    

    self.weatherLabel.text = [self.weatherVM getWeather];
    self.weatherLabel.textColor = [UIColor whiteColor];
    self.weatherLabel.font = [UIFont systemFontOfSize:20 weight:7];
    [self addSubview:self.weatherLabel];
    [self.weatherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cityLabel.mas_right).mas_equalTo(20);
        make.bottom.mas_equalTo(self.cityLabel);
    }];
    
    self.temp.text = [self.weatherVM getTemp];
    self.temp.textColor = [UIColor whiteColor];
    self.temp.font = [UIFont systemFontOfSize:28 weight:5];
    [self addSubview:self.temp];
    [self.temp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-80);
        make.bottom.mas_equalTo(self.weatherIcon).mas_equalTo(5);
    }];
    
    
    self.weekLabel.text = [self.weatherVM getWeek];
    self.weekLabel.textColor = [UIColor whiteColor];
    self.weekLabel.font = [UIFont systemFontOfSize:15 weight:7];
    [self addSubview:self.weekLabel];
    [self.weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-80);
       
        make.bottom.mas_equalTo(self.temp.mas_top).mas_equalTo(-25);
    }];

    
    self.dateLabel.text = [self.weatherVM getDate];
    self.dateLabel.textColor = [UIColor whiteColor];
    self.dateLabel.font = [UIFont systemFontOfSize:15 weight:7];
    [self addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.temp.mas_left);
         make.top.mas_equalTo(self.weekLabel);
    }];
    
    
}

- (void)drawRect:(CGRect)rect {
    [self setImageViews];
    [self setLables];
    

    [self addSubview:self.imageActivity];
    
    [self.imageActivity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.imageActivity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
    }];
    

    
}

- (UIButton *)goWhereButton {
    if(_goWhereButton == nil) {
        _goWhereButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _goWhereButton.backgroundColor = [UIColor  greenColor];
        _goWhereButton.titleLabel.text = @"去哪";
        _goWhereButton.titleLabel.textColor = [UIColor whiteColor];
        CALayer *layer = _goWhereButton.layer;
        layer.shadowColor = [[UIColor blackColor]CGColor];
        layer.cornerRadius = 30;
        //透明度
        layer.shadowOpacity = 0.6;
    }
    return _goWhereButton;
}

- (UIActivityIndicatorView *)imageActivity {
    if(_imageActivity == nil) {
        _imageActivity = [[UIActivityIndicatorView alloc] init];
    }
    return _imageActivity;
}


- (UIImageView *)weatherIcon {
    if(_weatherIcon == nil) {
        _weatherIcon = [[UIImageView alloc] init];
    }
    return _weatherIcon;
}
- (UILabel *)weatherLabel {
    if(_weatherLabel == nil) {
        _weatherLabel = [[UILabel alloc] init];
    }
    return _weatherLabel;
}

- (UILabel *)cityLabel {
    if(_cityLabel == nil) {
        _cityLabel = [[UILabel alloc] init];
    }
    return _cityLabel;
}

- (UILabel *)weekLabel {
    if(_weekLabel == nil) {
        _weekLabel = [[UILabel alloc] init];
    }
    return _weekLabel;
}

- (UILabel *)dateLabel {
    if(_dateLabel == nil) {
        _dateLabel = [[UILabel alloc] init];
    }
    return _dateLabel;
}

- (UILabel *)temp {
    if(_temp == nil) {
        _temp = [[UILabel alloc] init];
    }
    return _temp;
}
//- (void)layoutSubviews{
//    
//}
//
//- (void)layoutIfNeeded{
//    
//}
@end
