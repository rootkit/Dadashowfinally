//
//  GoodsShopListViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/29.
//  Copyright © 2017年 李萍. All rights reserved.
//

/******** 店铺系列 ********/
#import "GoodsShopListViewController.h"
#import "GoodsDetailViewController.h"

@interface GoodsShopListViewController ()<UIWebViewDelegate>

@property (nonatomic, copy) NSString *urlStr;

@end

@implementation GoodsShopListViewController
- (instancetype)initWithGoodsStoreSKU:(NSInteger)storeSku
{
    self = [super init];
    if (self) {
        _urlStr = [NSString stringWithFormat:@"http://119.23.46.204/app/index/shop/merchantStore.html?storeId=%ld", (long)storeSku];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.title = @"店铺";
    self.view.backgroundColor = BackCellColor;
//
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageRendingMode:@"ico_store"] style:UIBarButtonItemStylePlain target:self action:@selector(shopCartAction)];
//    
//
    [self layoutWeb];
    
    __weak typeof(self) weakSelf = self;
    [weakSelf.view configReloadAction:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf.view hideAllGeneralPage];
        [strongSelf layoutWeb];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - webview

- (void)layoutWeb
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    webView.scalesPageToFit = YES;
    webView.delegate = self;
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]]];
    [self.view addSubview:webView];
}

#pragma mark - bar action
- (void)shopCartAction
{
    NSLog(@"添加进购物车");
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ShopingCart" bundle:nil];
//    ShopingCartViewController *ctl = [storyboard instantiateViewControllerWithIdentifier:@"ShopingCartViewController"];
//    [self.navigationController pushViewController:ctl animated:YES];
}

#pragma mark - WebViewDelegate
//开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView {
    //设置顶部开始加载的加载圈
    
    webView.hidden = YES;
    [self.view beginLoading];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}
//加载成功
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    webView.hidden = NO;
    [self.view endLoading];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
}
//加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [webView removeFromSuperview];
    webView = nil;
    [self.view showEmptyPageViewWithImage:[UIImage imageNamed:@"ico_empty_fail"]
                                      tip:@"与母星暂时失去联系啦"
                              buttonTitle:@"刷新"];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *requestStr = [[request.URL absoluteString] stringByRemovingPercentEncoding];
    NSLog(@"click hs url = %@", requestStr);
    if ([requestStr hasPrefix:@"http://119.23.46.204/app/index/productDetails.html?sku="]) {
        
        NSString *sku = [requestStr componentsSeparatedByString:@"sku="][1];
        sku = [sku componentsSeparatedByString:@"="][0];
        
        [self.navigationController pushViewController:[[GoodsDetailViewController alloc] initWithGoodsSKU:sku goodsType:@"fs"] animated:YES];
        
        return NO;
    }
    
    return YES;
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
