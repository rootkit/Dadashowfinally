//
//  DIYWebController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/28.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "DIYWebController.h"
#import "JSClotherRoomSencondViewController.h"
@interface DIYWebController ()<UIWebViewDelegate,PetJSExport>//代理方法要不一

@property (nonatomic, copy) NSString *urlStr;
@property (strong, nonatomic) JSContext *context;
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation DIYWebController

- (instancetype)initWithUrl:(NSString *)url
{
    self = [super init];
    if (self) {
        _urlStr = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor=[UIColor whiteColor];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    webView.scalesPageToFit = YES;
    webView.delegate = self;
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5.0]];
    [self.view addSubview:webView];
    _webView=webView;
}


#pragma mark - WebViewDelegate

//加载成功
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    


    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    // 打印异常
    self.context.exceptionHandler =
    ^(JSContext *context, JSValue *exceptionValue)
    {
        context.exception = exceptionValue;
        NSLog(@"%@", exceptionValue);
    };
    // 以 JSExport 协议关联 native 的方法
     self.context[@"gonding"] = self;
    
    
}



- (void)push:(NSString *)str{
    
    NSLog(@"返回商城");
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *requestStr = [[request.URL absoluteString] stringByRemovingPercentEncoding];
    NSLog(@"%@",requestStr);
    if ([requestStr hasPrefix:@"http://119.23.46.204/index.html"]) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        return NO;
    }
    if ([requestStr hasPrefix:@"http://119.23.46.204/app/fittingRoom/fittingRoom.html"]) {
        JSClotherRoomSencondViewController* jsvc=[[JSClotherRoomSencondViewController alloc]init];
        UINavigationController* navi=[[UINavigationController alloc]initWithRootViewController:jsvc];
        [self presentViewController:navi animated:YES completion:nil];
        
         return NO;
    }
    return YES;
}



@end
