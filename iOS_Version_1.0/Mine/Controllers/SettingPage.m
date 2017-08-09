//
//  SettingPage.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/6.
//  Copyright © 2017年 李萍. All rights reserved.
//

/***** 设置 *****/
#import "SettingPage.h"
#import "MyInfoViewController.h"
#import "LoginViewController.h"

#import "SDImageCache.h"
#import "YYKit.h"

@interface SettingPage ()
@property (weak, nonatomic) IBOutlet UILabel *cacheLb;

@end

@implementation SettingPage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    
    self.tableView.tableFooterView = [UIView new];
    self.cacheLb.text = [self getSize];//7269881
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 12;
    } else if (section == 1) {
        return 30;
    } else {
        return 70;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [DDXUserinfo getUserId] ? 3 : 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            if ([DDXUserinfo getUserId] > 0) {
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
                MyInfoViewController *ctl = [storyboard instantiateViewControllerWithIdentifier:@"MyInfoViewController"];
                ctl.hidesBottomBarWhenPushed = YES;
                
                [self.navigationController pushViewController:ctl animated:YES];
            } else {
                [self presentViewController:[LoginViewController new] animated:YES completion:nil];
            }
            NSLog(@"个人资料");
        } else if (indexPath.row == 1) {
            NSLog(@"安全中心");
        } else if (indexPath.row == 2) {
            NSLog(@"清除缓存");
            
            NSLog(@"缓存 = %@", [self getSize]);
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"确定要清除缓存的图片和文件？" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                                style:UIAlertActionStyleCancel
                                                              handler:^(UIAlertAction * _Nonnull action) {
                                                                  return;
                                                              }]];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * _Nonnull action) {
                                                                  [[NSURLCache sharedURLCache] removeAllCachedResponses];
                                                                  [[SDImageCache sharedImageCache] clearMemory];
                                                                  [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
                                                                  [[[YYImageCache sharedCache] diskCache] removeAllObjects];
                                                                  [[[YYImageCache sharedCache] memoryCache] removeAllObjects];
                                                                  
                                                                  self.cacheLb.text = [self getSize];
                                                                  
                                                              }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        } else { }
    } else if (indexPath.section == 1) {
        NSLog(@"关于搭搭秀");
    } else {
        NSLog(@"退出");
        
        [self quitLoginAction];
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

#pragma mark - quit login
- (void)quitLoginAction
{
    DDXUserinfo *userInfo = [DDXUserinfo loadUserInfoFromSanbox];
    
    [DaHttpTool get:[NSString stringWithFormat:@"%@%@%@/%@", DDXAPI_HTTP_PREFIX_Loign, DDXAPI_SHOPPASSWORD_SR, DDXAPI_SHOPPASSWORD_SR_LOGIN_OUT, userInfo.code]
             params:nil
            success:^(id json) {
                //
                NSLog(@"success json = %@", json);
                if ([json[@"state"] isEqualToString:@"success"]) {
        
                    [userInfo deleteUserInfoFromSanbox];
                    [DDXUserinfo deallocDWUserInfo];
                    
                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    MBProgressHUD *HUD = [Util createHUD];
                    HUD.mode = MBProgressHUDModeCustomView;
                    HUD.labelText = json[@"content"];
                    
                    [HUD hide:YES afterDelay:2];
                }
                
                
                
            } failure:^(NSError *error) {
                NSLog(@"failure error = %@", error);
                
                MBProgressHUD *HUD = [Util createHUD];
                HUD.mode = MBProgressHUDModeCustomView;
                HUD.labelText = [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]];
                
                [HUD hide:YES afterDelay:2];
    }];
}


//计算缓存大小
- (NSString *)getSize
{
    __block NSUInteger size = 0;
    
    size = [[SDImageCache sharedImageCache] getSize];
    
    NSUInteger sizeM = size/(1024*1024);
    NSUInteger sizeK = size%(1024*1024)/10000;

    
    return [NSString stringWithFormat:@"%lu.%luM", (unsigned long)sizeM, (unsigned long)sizeK];
}


@end
