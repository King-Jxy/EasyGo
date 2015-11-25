//
//  DetailFunctionViewController.m
//  EasyGo
//
//  Created by jake on 15/11/25.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "DetailFunctionViewController.h"

@interface DetailFunctionViewController ()<UIWebViewDelegate>
@property (nonatomic , strong) NSURL *url;
@end

@implementation DetailFunctionViewController

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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
