//
//  LPCustomController.m
//  testTabbar
//
//  Created by ping_L on 2017/5/24.
//  Copyright © 2017年 ping_L. All rights reserved.
//

#import "LPCustomController.h"
#import "CenterBtnBoard.h"
#import "ViewController.h"

#define center_Bottom_H_W 56
@interface LPCustomController ()

@property (nonatomic, weak) UIButton *centerButton;

@end

@implementation LPCustomController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpAllChildVc];
    
    [self setupTabBar];
}

#pragma mark - 初始化tabBar上除了中间按钮之外所有的按钮

- (void)setUpAllChildVc
{
    NSArray *storyboardNames = @[@"Dadaxiu", @"FashionWord", @"", @"ShopingCart", @"Mine"];
    NSMutableArray *controllers = [NSMutableArray arrayWithCapacity:4];
    NSArray *images = @[@"Home_icon_tab", @"Fashion_icon_tab", @"", @"shopping_icon_tab", @"My_icon_tab"];
    NSArray *titles = @[@"搭搭秀", @"时尚圈", @"", @"购物车", @"我的"];
    
    [storyboardNames enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL *stop) {
        if (idx == 2) {
            [controllers addObject:[ViewController new]];
        } else {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:name bundle:nil];
            UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"Nav"];
            
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_default", images[idx]]];
            UIImage *selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@", images[idx]]];
            selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
            navigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:titles[idx] image:image selectedImage:selectedImage];
            self.selectedIndex = 0;
            [controllers addObject:navigationController];
        }
    }];
    
    self.viewControllers = [controllers copy];
}

- (void)setupTabBar {
    //取消tabBar的透明效果。
    [UITabBar appearance].translucent = NO;

    
    //修改文字颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[[UIColor blackColor] colorWithAlphaComponent:0.5], NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateNormal];
    UIColor *titleHighlightedColor = ThemeColor;
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: titleHighlightedColor, NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-center_Bottom_H_W/2 , 48-center_Bottom_H_W, center_Bottom_H_W, center_Bottom_H_W)];
    
    button.layer.cornerRadius = center_Bottom_H_W/2;
    button.layer.masksToBounds = YES;
    
    [button setBackgroundColor:[UIColor whiteColor]];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button setBackgroundImage:[UIImage imageNamed:@"tabbar_certen_bg"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"tabbar_certen_bg"] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:@"more_btn_tab"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"more_btn_tab"] forState:UIControlStateHighlighted];
    [self.tabBar addSubview:button];
    [self.tabBar bringSubviewToFront:button];
    [button addTarget:self action:@selector(selectImagePicker) forControlEvents:UIControlEventTouchUpInside];
    self.centerButton = button;
}

- (void)selectImagePicker {
    NSLog(@"center button");
    [self centerButtonAnimation];
    
    CenterBtnManager *centerView = [CenterBtnManager centerBtnManager];
    [centerView showCenterBtn];
}

#pragma mark -  centerButtonAnimation

- (void)centerButtonAnimation
{
    self.centerButton.transform = CGAffineTransformMakeScale(1.0, 1.0);
    
    [UIView animateWithDuration:0.1
                     animations:^{
                         self.centerButton.transform = CGAffineTransformMakeScale(0.87, 0.87);
                         [self.centerButton setHighlighted:YES];
                     } completion:^(BOOL finished) {
                         self.centerButton.transform = CGAffineTransformMakeScale(1.0, 1.0);
                     }];
}


@end
