//
//  MyFavotableViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/20.
//  Copyright © 2017年 李萍. All rights reserved.
//

/****  我的优惠信息  ****/
#import "MyFavotableViewController.h"
#import "TitleViewController.h"
#import "CouponListViewController.h"

@interface MyFavotableViewController ()

@end

@implementation MyFavotableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的优惠信息";
    self.view.backgroundColor = BackCellColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"兑换" style:UIBarButtonItemStylePlain target:self action:@selector(exchangeAction)];
    [self layoutScrollTitle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - back action

- (void)exchangeAction
{
    NSLog(@"兑换...");
}

- (void)layoutScrollTitle
{
    TitleViewController *titleCtl = [[TitleViewController alloc] initWithFrame:self.view.frame
                                                                        titles:@[@"店铺优惠券", @"现金券"]
                                                               viewControllers:@[[CouponListViewController new],
                                                                                 [CouponListViewController new]]
                                                         andIsFixedTitleLength:NO
                                                                   andHasNavig:YES
                                                                  andHasTabbar:NO];
    titleCtl.titleScrollViewHeight = 44;
    titleCtl.buttonBackgroundColor = [UIColor whiteColor];
    titleCtl.buttonSelectedColor = ThemeColor;
    titleCtl.buttonUnSelectedColor = [UIColor blackColor];
    titleCtl.buttonTitleSelectedColor = ThemeColor;
    titleCtl.buttonTitleUnSelectedColor = FirstTextColor;
    titleCtl.footHeight = 1;
    titleCtl.selectedType = TitleSelectedTypeWithFoot;
    titleCtl.font = [UIFont systemFontOfSize:14];
    
    [self addChildViewController:titleCtl];
    [self.view addSubview:titleCtl.view];
}

@end
