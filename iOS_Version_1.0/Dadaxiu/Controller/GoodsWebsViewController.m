//
//  GoodsWebsViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/1.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "GoodsWebsViewController.h"
#import "GoodsDetailViewController.h"

@interface GoodsWebsViewController ()<UIWebViewDelegate>

@property (nonatomic, copy) NSString *urlStr;

@end

@implementation GoodsWebsViewController

- (instancetype)initWithGoodsType:(NSString *)typeStr goodsId:(NSInteger)goodsId
{
    self = [super init];
    if (self) {
        _urlStr = [NSString stringWithFormat:@"http://119.23.46.204/app/index/thirdStep/threeLevelClassification.html?categoryid=%@&goodstypeid=%ld",typeStr,(long)goodsId];
   


    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=self.titlestring;
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    webView.scalesPageToFit = YES;
     webView.delegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]]];
    [self.view addSubview:webView];
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

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *requestStr = [[request.URL absoluteString] stringByRemovingPercentEncoding];
    if ([requestStr hasPrefix:@"http://119.23.46.204/app/index/productDetails.html?sku"]) {
        
        NSString *sku = [requestStr componentsSeparatedByString:@"sku="][1];
        sku = [sku componentsSeparatedByString:@"="][0];
        
        NSString *type = [requestStr componentsSeparatedByString:@"&type="][1];
        
        [self.navigationController pushViewController:[[GoodsDetailViewController alloc] initWithGoodsSKU:sku goodsType:type] animated:YES];
        
        return NO;
    }
    
    return YES;
}

-(void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame{
   
    NSLog(@"禁止弹出地址警告框");
}

- (BOOL)webView:(UIWebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(id *)frame{
    
    return NO;
    
}

@end
