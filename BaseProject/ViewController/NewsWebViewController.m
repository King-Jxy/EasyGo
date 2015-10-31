//
//  NewsWebViewController.m
//  BaseProject
//
//  Created by jake on 15/10/31.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "NewsWebViewController.h"

@interface NewsWebViewController () <UIWebViewDelegate>

@property (nonatomic , strong) NSURL *url;
@end

@implementation NewsWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [UIWebView new];
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    webView.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [webView loadRequest:request];
}

- (instancetype)initWithURL:(NSURL *)url{
    self = [super init];
    if(self){
        self.url = url;
    }
    return self;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self showProgress];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    [self showSuccessMsg:@"加载完成"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
//    [self showErrorMsg:(NSString *)error.userInfo];
}


- (NSURL *)url {
	if(_url == nil) {
		_url = [[NSURL alloc] init];
	}
	return _url;
}

@end
