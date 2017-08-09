//
//  MyInfoViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/6.
//  Copyright © 2017年 李萍. All rights reserved.
//

/***** 个人资料 *****/
#import "MyInfoViewController.h"
#import "AddressListViewController.h"
#import "EditMyInfoViewController.h"
#import "MartViewController.h"
#import "BLAreaPickerView.h"

#import <MobileCoreServices/MobileCoreServices.h>

@interface MyInfoViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, BLPickerViewDelegate>
{
    NSDictionary *_dic; //基本请求字典
    NSMutableDictionary *_param; //请求字典
}

@property (weak, nonatomic) IBOutlet UIImageView *userPortraitIMG;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLb;
@property (weak, nonatomic) IBOutlet UILabel *genderLb;
@property (weak, nonatomic) IBOutlet UIImageView *twoDIMG;
@property (weak, nonatomic) IBOutlet UILabel *descLb;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLb;
@property (weak, nonatomic) IBOutlet UILabel *locationLb;
@property (weak, nonatomic) IBOutlet UILabel *addressLb;

@property (nonatomic, strong) BLAreaPickerView *pickView;
@property (nonatomic, strong) NSString *provinceString;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) DDXUserinfo *userInfo;

@end

@implementation MyInfoViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _userInfo = [DDXUserinfo loadUserInfoFromSanbox];
    _dic = @{
             @"id"   : _userInfo.id > 0 ? @(_userInfo.id) : @(0),
             @"code" : _userInfo.code.length > 0 ? _userInfo.code : @"",
             };
    [_userPortraitIMG handleCornerRadiusWithRadius:26];
    [self setDataForUserInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    _param = [[NSMutableDictionary alloc] initWithDictionary:_dic];
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                NSLog(@"更换头像请求");
                
                [self fetchWithCamera];
                
                break;
            }
            case 1:
            {
                NSLog(@"更换昵称请求");
                
                [self.navigationController pushViewController:[[EditMyInfoViewController alloc] initWithNickname:YES] animated:YES];

                break;
            }
            case 2:
            {
                NSLog(@"更换性别请求");
                
                UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                
                [alertCtl addAction:[UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self fetchToChangeUserSex:@"男"];
                }]];
                [alertCtl addAction:[UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self fetchToChangeUserSex:@"女"];
                }]];
                [alertCtl addAction:[UIAlertAction actionWithTitle:@"取 消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    return ;
                }]];
                
                [self.navigationController presentViewController:alertCtl animated:YES completion:nil];
                
                break;
            }
            case 3:
            {
                NSLog(@"查看二维码请求");
                
                [self.navigationController pushViewController:[MartViewController new] animated:YES];
                break;
            }
            case 4:
            {
                NSLog(@"更换个性签名请求");
                
                [self.navigationController pushViewController:[[EditMyInfoViewController alloc] initWithNickname:NO] animated:YES];

                break;
            }
            default:
                break;
        }
    } else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
            {
                NSLog(@"更换手机号码请求");
                break;
            }
            case 1:
            {
//                NSLog(@"更换所在地请求");
//                _pickView = [[BLAreaPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
//                _pickView.pickViewDelegate = self;
//                [_pickView bl_show];
//                break;
//            }
//            case 2:
//            {
                NSLog(@"更换收货地址请求");
                [self.navigationController pushViewController:[AddressListViewController new] animated:YES];
                break;
            }
            
            default:
                break;
        }
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

#pragma mark - change portrait
- (void)fetchWithCamera
{
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
            imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
            
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }
    }]];
    [alertCtlPhoto addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePickerController = [UIImagePickerController new];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePickerController.allowsEditing = YES;
        imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
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

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

#pragma mark - set data 赋值
- (void)setDataForUserInfo
{
    if (_userInfo.headerUrl.length > 0) {
        [_userPortraitIMG loadPortrait:[NSURL URLWithString:_userInfo.headerUrl]];
    }
    
    _nickNameLb.text = _userInfo.alias.length > 0 ? _userInfo.alias : @"无";
    _genderLb.text = (_userInfo.sex == 0) ? @"保密" : ((_userInfo.sex == 1) ? @"男" : @"女");
    _descLb.text = _userInfo.personality.length > 0 ? _userInfo.personality : @"无个人描述";
    _phoneNumLb.text = _userInfo.mobile.length > 0 ? _userInfo.mobile : @"无";
    if (_userInfo.orderConsignee.province ==nil&&_userInfo.orderConsignee.city==nil) {
        NSString *locationStr =@"无";
        _locationLb.text =locationStr;
    }else{
      NSString *locationStr = [NSString stringWithFormat:@"%@%@", _userInfo.orderConsignee.province, _userInfo.orderConsignee.city];
       _locationLb.text =locationStr;
   
    }
    
    DDXConsignee *consignee = [DDXConsignee loadUserDefaultAddress];

    NSString *addressStr = [NSString stringWithFormat:@"%@ %@ %@ %@",
                            consignee.province.length ? consignee.province : @"",
                            consignee.city.length ? consignee.city : @"",
                            consignee.district.length ? consignee.district : @"",
                            consignee.address.length ? consignee.address : @""];
   _addressLb.text = addressStr.length ? addressStr : @"无";
}


#pragma mark - change info post

/* 更改头像 */
- (void)fetchToChangeUserPortrait
{
    
    NSString *strUrl = [NSString stringWithFormat:@"%@%@%@", DDXAPI_HTTP_PREFIX_Loign, DDXAPI_SHOPPASSWORD_SR, DDXAPI_SHOPPASSWORD_SR_USERPHOTO];
//    NSString *strUrl = @"http://192.168.1.128:8080/shop-fitdiy/sr/faceUser/faceUserPhoto";
    
    [DaHttpTool postImageArray:@[_image]
                        andUrl:strUrl
                        params:_param
                       success:^(id json) {
                           //
                           NSLog(@"上传图片返回回来的数据json==== %@", json);
                           if ([json[@"state"] isEqualToString:@"success"]) {
                               _userPortraitIMG.image = _image;
                               NSDictionary *dic = json[@"content"];
                            
                               DDXUserinfo *userInfo = [DDXUserinfo loadUserInfoFromSanbox];
                               userInfo.martUrl = dic[@"martUrl"];
                               userInfo.headerUrl = dic[@"headerUrl"];
                               [DDXUserinfo saveUserInfoToSanbox:userInfo];
                               
                           } else {
                               NSLog(@"请求失败");
                               
                               MBProgressHUD *HUD = [Util createHUD];
                               HUD.mode = MBProgressHUDModeCustomView;
                               HUD.labelText = json[@"content"][@"statusMsg"];
                               
                               [HUD hide:YES afterDelay:5];
                           }
                       } failure:^(NSError *error) {
                           //
                           MBProgressHUD *HUD = [Util createHUD];
                           HUD.mode = MBProgressHUDModeCustomView;
                           HUD.labelText = [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]];
                           NSLog(@"error = %@", [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]]);
                           
                           [HUD hide:YES afterDelay:5];
                       }];
    
}

/* 更改信息 */
- (void)fetchToChangeUserSex:(NSString *)sex
{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@%@", DDXAPI_HTTP_PREFIX_Loign, DDXAPI_SHOPPASSWORD_SR, DDXAPI_SHOPPASSWORD_SR_USERINFO_EDIT];
    [_param setObject:@([sex isEqualToString:@"男"] ? UserSexTypeForMale : UserSexTypeForFemale) forKey:@"sex"];
    
    [DaHttpTool post:strUrl
              params:_param
             success:^(id json) {
                 //
                 NSLog(@"json==== %@", json);
                 
                 MBProgressHUD *HUD = [Util createHUD];
                 HUD.mode = MBProgressHUDModeCustomView;
                 HUD.labelText = json[@"content"][@"statusMsg"];
                 
                 [HUD hide:YES afterDelay:5];
                 
                 if ([json[@"state"] isEqualToString:@"success"]) {
                     DDXUserinfo *userInfo = [DDXUserinfo loadUserInfoFromSanbox];
                     
                     userInfo.sex = [sex isEqualToString:@"男"] ? UserSexTypeForMale : UserSexTypeForFemale;
                     
                     [DDXUserinfo saveUserInfoToSanbox:userInfo];
                     _genderLb.text = sex;
                 }
             } failure:^(NSError *error) {
                 //
                 NSLog(@"error === %@", error);
                 MBProgressHUD *HUD = [Util createHUD];
                 HUD.mode = MBProgressHUDModeCustomView;
                 HUD.labelText = @"网络错误!";
                 
                 [HUD hide:YES afterDelay:5];
             }];
    
    [self.tableView reloadData];
}

#pragma mark - - BLPickerViewDelegate
- (void)bl_selectedAreaResultWithProvince:(NSString *)provinceTitle city:(NSString *)cityTitle area:(NSString *)areaTitle{
    NSLog(@"%@,%@,%@",provinceTitle,cityTitle,areaTitle);
    
    self.provinceString = [NSString stringWithFormat:@"%@%@%@", provinceTitle, cityTitle, areaTitle];
    
    
    
    [self.tableView reloadData];
}

@end
