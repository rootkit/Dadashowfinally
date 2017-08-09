//
//  JSClotherRoomSencondViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/7/1.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "JSClotherRoomSencondViewController.h"
#import "Loadingview.h"
@interface JSClotherRoomSencondViewController ()<UIWebViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImage *image;
@property(nonatomic,strong)NSString* imageurl;
@property(nonatomic,strong)UIWebView *webView;

@end

@implementation JSClotherRoomSencondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"试衣间";
    self.view.backgroundColor=[UIColor whiteColor];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    webView.scalesPageToFit = YES;
    webView.delegate = self;
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://119.23.46.204/app/fittingRoom/fittingRoom.html"] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5.0]];
    [self.view addSubview:webView];
    _webView=webView;
 
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageRendingMode:@"btn-back"] style:UIBarButtonItemStylePlain target:self action:@selector(gotofirstview)];
    self.navigationItem.leftBarButtonItem = barButton;

}


-(void)gotofirstview{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
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
    
    //     __weak typeof(self) weakSelf = self;
    //    self.context[@"clothesroom"] =
    //    ^(NSString *str)
    //    {
    //        NSLog(@"%@", str);
    //    [weakSelf.navigationController popViewControllerAnimated:YES];
    //
    //    };
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
}



#pragma mark - JSExport Methods

- (void)handleFactorialCalculateWithNumber:(NSNumber *)number
{
    
    //    NSNumber *result = @1000000;
    
    //    NSLog(@"%@", result);
    //
    //    [self.context[@"showResult"] callWithArguments:@[result]];
    [self changeface];
}


- (void)pushtextroom:(NSString *)view{
    NSLog(@"%@",view);
    
    Class second = NSClassFromString(view);
    id secondVC = [[second alloc]init];
    [self.navigationController pushViewController:secondVC animated:YES];
    
    
}




-(void)changeface{
    NSLog(@"换脸");
    UIAlertController *alertCtlPhoto = [UIAlertController alertControllerWithTitle:@"选择照片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertCtlPhoto addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            UIAlertController *alertCtlCam = [UIAlertController alertControllerWithTitle:@"Error" message:@"Device has no camera" preferredStyle:UIAlertControllerStyleAlert];
            [alertCtlCam addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                return;
            }]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:alertCtlCam animated:YES completion:nil];
            });
            
        } else {
            UIImagePickerController *imagePickerController = [UIImagePickerController new];
            imagePickerController.delegate = self;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePickerController.allowsEditing = YES;
            imagePickerController.showsCameraControls = YES;
            imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }
    }]];
    [alertCtlPhoto addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePickerController = [UIImagePickerController new];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePickerController.allowsEditing = YES;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }]];
    
    [alertCtlPhoto addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        return;
    }]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self presentViewController:alertCtlPhoto animated:YES completion:nil];
    });
}


#pragma mark - UIImagePickerController
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    _image = info[UIImagePickerControllerEditedImage];
    
    [picker dismissViewControllerAnimated:YES completion:^ {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.color=[UIColor whiteColor];
        hud.dimBackground=NO;//四周的渐变效果
        hud.mode = MBProgressHUDModeCustomView;
        hud.minSize = CGSizeMake(kScreen_Width, kScreen_Height);
        Loadingview* lovc=[[Loadingview alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
        lovc.backgroundColor=[UIColor whiteColor];
        hud.customView=lovc;
        NSString* strUrl=@"http://39.108.148.25:8080/shop-fitdiy/sr/faceUser/faceUserPhoto";
        [DaHttpTool postImageArray:@[_image]
                            andUrl:strUrl
                            params:@{@"id":@(1)}.mutableCopy
                           success:^(id json) {
                               NSLog(@"上传图片返回回来的数据json==== %@", json);
                               self.imageurl=json[@"data"];
                               [self.context[@"showResult"] callWithArguments:@[self.imageurl]];
                               //                               [self setoccalljs:self.imageurl];
                               //                                 [self.webView reload];
                               NSLog(@"%@",self.imageurl);
                               [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                               
                           } failure:^(NSError *error) {
                               NSLog(@"error === %@", error);
                               MBProgressHUD *HUD = [Util createHUD];
                               HUD.mode = MBProgressHUDModeCustomView;
                               HUD.labelText = @"网络错误!";
                               [HUD hide:YES afterDelay:5];
                           }];
        
        
        
    }];
}

-(void)setoccalljs:(NSString*)imageurlstring{
    self.context = [[JSContext alloc] init];
    [self.context evaluateScript:@"f"];
    JSValue *function = [self.context objectForKeyedSubscript:@"factorial"];
    JSValue *result = [function callWithArguments:@[imageurlstring]];
    NSLog(@"%@",result);
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //清除webView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}


@end
