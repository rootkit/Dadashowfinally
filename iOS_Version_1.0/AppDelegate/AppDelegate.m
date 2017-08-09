//
//  AppDelegate.m
//  iOS_Version_1.0
//
//  Created by 李萍 on 2017/4/14.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "AppDelegate.h"
#import "FashionWorldViewController.h"
#import "LeadingViewController.h"
#import "LPCustomController.h"
#import "AdvertiseViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

@interface AppDelegate ()<UITabBarControllerDelegate>

@property (nonatomic, strong) LPCustomController  *tabBarViewController;
@property (nonatomic, assign) NSInteger firstSelectedIndex;
@property(nonatomic,strong) BMKMapManager* mapManager;//百度地图对象

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /*//第一种方式
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    */
//    [NSThread sleepForTimeInterval:1];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self setupLookAndFeel];
    
    [self setTabbarSubviews];
    [self setbaidumapdelegate];
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstStart"];
        NSLog(@"第一次启动");
         //添加引导图
        LeadingViewController *lead = [[LeadingViewController alloc] init];
        self.window.rootViewController = lead;
        [self.window makeKeyAndVisible];
    } else {
        NSLog(@"不是第一次启动");
//        [self setTabbarSubviews];
        AdvertiseViewController *advervc = [[AdvertiseViewController alloc] init];
        self.window.rootViewController = advervc;
        [self.window makeKeyAndVisible];
    }
    
    return YES;
}

-(void)setbaidumapdelegate{
    
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"WtouROoWAkx6WQMDwRm0gSVAOxrsgl54"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"注册失败!");
    }

}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//设置控件外观
- (void)setupLookAndFeel
{
    [[UINavigationBar appearance] setBarTintColor:NavigationColor];
    
    UIImage *backImage = [UIImage imageRendingMode:@"btn-back"];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[backImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, backImage.size.width, 0, 0)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    [menuController setMenuVisible:YES animated:YES];
    [menuController setMenuItems:@[
                                   [[UIMenuItem alloc] initWithTitle:@"复制" action:NSSelectorFromString(@"copyText:")],
                                   [[UIMenuItem alloc] initWithTitle:@"删除" action:NSSelectorFromString(@"deleteObject:")],
                                   ]];
}

//第二种方式
#pragma mark - tabbar sub Controller
- (void)setTabbarSubviews
{
    self.tabBarViewController = [[LPCustomController alloc] init];
    self.tabBarViewController.delegate = self;
    
    self.window.rootViewController = self.tabBarViewController;
    
    self.tabBarViewController.selectedViewController.tabBarItem.title = @"首页";
    [self.window makeKeyAndVisible];
}

#pragma mark - UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    UITabBarItem *barItem = [tabBarController.tabBar.items objectAtIndex:0];
    if (tabBarController.selectedIndex == 0) {
        
        UIImage *img = nil;
        if (_firstSelectedIndex == 0) {
            img = [[UIImage imageNamed:@"like_icon_tab"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//第二种选中的状态
            _firstSelectedIndex++;
            NSLog(@"选中第二种状态");
            if (self.clickblock) {
                self.clickblock(2);
            }
            
        } else if (_firstSelectedIndex == 1){
            img = [[UIImage imageNamed:@"Home_icon_tab"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            _firstSelectedIndex--;
            NSLog(@"选中第一种状态");
            if (self.clickblock) {
                self.clickblock(1);
            }
        }
        barItem.selectedImage = img;
    } else {
        _firstSelectedIndex = 1;
    }
}

@end
