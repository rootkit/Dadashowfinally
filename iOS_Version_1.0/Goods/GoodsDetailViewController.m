//
//  GoodsDetailViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/24.
//  Copyright © 2017年 李萍. All rights reserved.
//

/******** 商品详情 ********/
#import "GoodsDetailViewController.h"
#import "ShopingCartViewController.h"
#import "GoodsShopListViewController.h"
#import "ConfirmOrderViewController.h"

@interface GoodsDetailViewController ()<UIWebViewDelegate>

@property (nonatomic, copy) NSString *urlStr;

@end

@implementation GoodsDetailViewController

- (instancetype)initWithGoodsSKU:(NSString *)goodsSku goodsType:(NSString *)goodsType
{
    self = [super init];
    if (self) {
        NSDate *nowDate = [NSDate date];
        double time = [nowDate timeIntervalSince1970];
        time = time *1000;
        NSString *timeStr = [NSString stringWithFormat:@"%.0f",time];
        NSLog(@"时间戳%@",timeStr);
        NSString* token=nil;
        if ([DDXUserinfo getUserCode]==nil) {
            token=@"";
        }else{
            token=[DDXUserinfo getUserCode];
        }
    _urlStr = [NSString stringWithFormat:@"http://119.23.46.204/app/index/productDetails.html?sku=%@&type=%@&token=%@&time=%@", goodsSku, goodsType, token,timeStr];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"商品详情";
    self.view.backgroundColor = BackCellColor;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageRendingMode:@"ico_store"] style:UIBarButtonItemStylePlain target:self action:@selector(shopCartAction)];
    
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
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ShopingCart" bundle:nil];
    ShopingCartViewController *ctl = [storyboard instantiateViewControllerWithIdentifier:@"ShopingCartViewController"];
    [self.navigationController pushViewController:ctl animated:YES];
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
    if ([requestStr hasPrefix:@""]) {
        
        NSString *sku = [requestStr componentsSeparatedByString:@"sku="][1];
        sku = [sku componentsSeparatedByString:@"="][0];
        
        NSString *type = [requestStr componentsSeparatedByString:@"&type="][1];
        
        [self.navigationController pushViewController:[[GoodsDetailViewController alloc] initWithGoodsSKU:sku goodsType:type] animated:YES];
        
        return NO;
    } else if ([requestStr hasPrefix:@"http://119.23.46.204/app/index/shop/merchantStore.html?storeId="]) { //去店铺
        NSInteger storeId = [[requestStr componentsSeparatedByString:@"="][1] integerValue];
        
        [self.navigationController pushViewController:[[GoodsShopListViewController alloc] initWithGoodsStoreSKU:storeId] animated:YES];
        
        return NO;
    } else if ([requestStr hasPrefix:@"http://119.23.46.204/app/shopCar/secondStep/confirmOrder.html?type=productDetails&num="]) { //确认订单页
        NSLog(@"%@",requestStr);
        NSString *sku=nil;
        if ([requestStr componentsSeparatedByString:@"sku="].count==2) {
           sku = [requestStr componentsSeparatedByString:@"sku="][1];
        }
        NSString *numStr =nil;
        if ([requestStr componentsSeparatedByString:@"&num="].count==2) {
           numStr= [requestStr componentsSeparatedByString:@"&num="][1];
        }
        NSInteger num =0;
        if ([numStr componentsSeparatedByString:@"&sku="].count==2) {
           num = [[numStr componentsSeparatedByString:@"&sku="][0] integerValue];
        }
        if (requestStr.length) {
              [self getGoodsDetail:sku withItemNum:num];
        }
        return NO;
    }
    
    return YES;
}

//

#pragma mark - 商品详情 进确认订单
- (void)getGoodsDetail:(NSString *)sku withItemNum:(NSInteger)itemNum
{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@?sku=%@", DDXAPI_HTTP_PREFIX_Goods, DDXAPI_GOODS_Detail, sku];
    
    [DaHttpTool post:strUrl
              params:nil
             success:^(id json) {
                 
                 if ([json[@"state"] isEqualToString:@"success"]) {
                     NSLog(@"%@",json);
                     
                     DDXDetailGoodsModel *goodDetail = [DDXDetailGoodsModel osc_modelWithDictionary:json[@"content"][@"goodsInfo"]];
                     goodDetail.itemNum = (int)itemNum;
                     goodDetail.imageUrl = json[@"content"][@"goodsImg"][0][@"imageUrl"];
                     
                     DDXShopCartGoods *good = [self changeModel:goodDetail];
                     [self.navigationController pushViewController:[[ConfirmOrderViewController alloc] initWithDetailGoods:good] animated:YES];
                 } else {
                     MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
                     hud.mode = MBProgressHUDModeText;
                     hud.margin=10;
                     hud.labelFont=[UIFont boldSystemFontOfSize:13];
                     hud.detailsLabelText = json[@"content"][@"statusMsg"];
                     [hud hide:YES afterDelay:1.5];
                 }
             } failure:^(NSError *error) {
                 //
                 MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
                 hud.mode = MBProgressHUDModeText;
                 hud.margin=10;
                 hud.labelFont=[UIFont boldSystemFontOfSize:13];
                 hud.detailsLabelText = [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]];
                 [hud hide:YES afterDelay:1.5];
       
             }];
}

- (DDXShopCartGoods *)changeModel:(DDXDetailGoodsModel *)model
{
    DDXShopCartGoods *good = [DDXShopCartGoods  new];
    
    good.itemNum = (int)model.itemNum;
    good.itemName = model.goodsName;
    good.storeName = model.storeName;
    good.itemColor = model.itemColor;
    good.itemSize = model.itemSize;
    good.sku = model.sku;
    good.itemPriceNow = model.shopPrice;
    good.itemPrice = model.marketPrice;
    good.isChooseGoods = YES;
    good.storeId = model.storeId;
    good.storeSku = model.storeSku;
    good.imageUrl = model.imageUrl;
    
    return good;
}


@end
