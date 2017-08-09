//
//  JSRoomViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/6/30.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "JSRoomViewController.h"

@interface JSRoomViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation JSRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title = @"试衣间列表";
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.scalesPageToFit = YES;
    webView.delegate = self;
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://119.23.46.204/app/fittingRoom/tryList.html"] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5.0]];
    [self.view addSubview:webView];
    _webView=webView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WebViewDelegate
//开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView {
    //设置顶部开始加载的加载圈
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}
//加载成功
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
}
//加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //清除webView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

@end
