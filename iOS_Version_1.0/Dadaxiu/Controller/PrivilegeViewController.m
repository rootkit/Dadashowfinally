//
//  PrivilegeViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/17.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "PrivilegeViewController.h"
#import "CheapcomeViewController.h"
#import "TitleViewController.h"
@interface PrivilegeViewController ()
{
    NSArray *_titles;
    NSArray *_controllers;
}

@end

@implementation PrivilegeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"惠来购";
    self.view.userInteractionEnabled = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    TitleViewController *titleCtl = [[TitleViewController alloc] initWithFrame:self.view.frame
                                                                        titles:@[@"精选",@"女装",@"女鞋",@"包包",@"配饰"]
                                                               viewControllers:@[[CheapcomeViewController new],
                                                                                 [CheapcomeViewController new],
                                                                                 [CheapcomeViewController new],
                                                                                 [CheapcomeViewController new],
                                                                                 [CheapcomeViewController new]
                                                                                 ]
                                                         andIsFixedTitleLength:NO
                                                                   andHasNavig:YES
                                                                  andHasTabbar:NO];
    titleCtl.titleScrollViewHeight = 44;
    titleCtl.buttonBackgroundColor = [UIColor whiteColor];
    titleCtl.buttonSelectedColor = ThemeColor;
    titleCtl.buttonUnSelectedColor = [UIColor blackColor];
    titleCtl.buttonTitleSelectedColor = ThemeColor;
    titleCtl.buttonTitleUnSelectedColor = FirstTextColor;
    titleCtl.footHeight = 2;
    titleCtl.selectedType = TitleSelectedTypeWithFoot;
    titleCtl.font = [UIFont systemFontOfSize:14];
    [self addChildViewController:titleCtl];
    [self.view addSubview:titleCtl.view];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageRendingMode:@"ico_store"] style:UIBarButtonItemStylePlain target:self action:@selector(buyshop)];
    self.navigationItem.rightBarButtonItem = barButton;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //去除导航栏下方的横线
     self.navigationController.navigationBar.clipsToBounds = YES;
    
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
   self.navigationController.navigationBar.clipsToBounds = NO;
}
-(void)buyshop{
    NSLog(@"前往购物车");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
