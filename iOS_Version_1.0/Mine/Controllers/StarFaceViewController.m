//
//  StarFaceViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/6/23.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "StarFaceViewController.h"
#import "UIImageView+WebCache.h"
#import "Loadingview.h"
@interface StarFaceViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) UIImage *image;
@property(nonatomic,strong)NSString* imageurl;
@property(nonatomic,strong)UIImageView* faceimage;
@end

@implementation StarFaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"点击屏幕中心换脸";
    UIImageView* faceimage=[UIImageView new];
    faceimage.contentMode=UIViewContentModeScaleAspectFit;
    NSUserDefaults* imagedefault=[NSUserDefaults standardUserDefaults];
    if ([imagedefault objectForKey:@"faceimage"]) {
        NSLog(@"存在url");
        [faceimage sd_setImageWithURL:[imagedefault objectForKey:@"faceimage"] placeholderImage:[UIImage imageWithColor:DefaultImgBgColor]];
    }else{
        NSLog(@"不存在url");
         faceimage.image=[UIImage imageWithColor:[UIColor greenColor]];
    }
//    [image  sd_setImageWithURL:[NSURL URLWithString:self.url] placeholderImage:[UIImage imageWithColor:DefaultImgBgColor]];
   
    [self.view addSubview:faceimage];
    [faceimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@64);
        make.left.equalTo(@0);
        make.right.equalTo(@-0);
        make.bottom.equalTo(@-0);
    }];
    faceimage.userInteractionEnabled=YES;
     UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeface)];
    [faceimage addGestureRecognizer:tap];
    _faceimage=faceimage;
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
            
            [self presentViewController:alertCtlCam animated:YES completion:nil];
            
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
    
    [self presentViewController:alertCtlPhoto animated:YES completion:nil];
}

#pragma mark - UIImagePickerController
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    _image = info[UIImagePickerControllerEditedImage];
    
    [picker dismissViewControllerAnimated:YES completion:^ {
        
        [self fetchToChangeUserPortrait];
    }];
}



#pragma mark - change info post

/* 更改头像 */
- (void)fetchToChangeUserPortrait
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.color=[UIColor whiteColor];
    hud.dimBackground=NO;//四周的渐变效果
    hud.mode = MBProgressHUDModeCustomView;
    hud.minSize = CGSizeMake(kScreen_Width, kScreen_Height);
    Loadingview* lovc=[[Loadingview alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    lovc.backgroundColor=[UIColor whiteColor];
    hud.customView=lovc;
    //    NSString *strUrl = [NSString stringWithFormat:@"%@%@%@", DDXAPI_HTTP_PREFIX_Loign, DDXAPI_SHOPPASSWORD_SR, DDXAPI_SHOPPASSWORD_SR_USERPHOTO];
    NSString* strUrl=@"http://39.108.148.25:8080/shop-fitdiy/sr/faceUser/faceUserPhoto";
    [DaHttpTool postImageArray:@[_image]
                        andUrl:strUrl
                        params:@{@"id":@(1)}.mutableCopy
                       success:^(id json) {
                           NSLog(@"上传图片返回回来的数据json==== %@", json);
                           self.imageurl=json[@"data"];
                           NSUserDefaults* imagedefault=[NSUserDefaults standardUserDefaults];
                           [imagedefault setObject:self.imageurl forKey:@"faceimage"];
                          [_faceimage  sd_setImageWithURL:[NSURL URLWithString:self.imageurl] placeholderImage:[UIImage imageWithColor:DefaultImgBgColor]];
                                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                           
                       } failure:^(NSError *error) {
                           NSLog(@"error === %@", error);
                           MBProgressHUD *HUD = [Util createHUD];
                           HUD.mode = MBProgressHUDModeCustomView;
                           HUD.labelText = @"网络错误!";
                           [HUD hide:YES afterDelay:5];
                       }];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
