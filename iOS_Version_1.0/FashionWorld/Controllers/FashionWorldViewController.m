//
//  FashionWorldViewController.m
//  iOS_Version_1.0
//
//  Created by 李萍 on 2017/4/17.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "FashionWorldViewController.h"
#import "TitleViewController.h"
#import "FWFriendViewController.h"
#import "FWVideoViewController.h"
#import "MyFriendContentViewController.h"
#import "FashioncircleViewController.h"
#import "MessageListViewController.h"
#import "LoginViewController.h"

#import "Util.h"
#import "DDXAPI.h"
#import "DaHttpTool.h"
#import "UIColorHF.h"
#import "UIView+LPView.h"

#import "SQimageMenuShowView.h"
#import "SQimageMenuShowView.h"
@interface FashionWorldViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    NSArray *_titles;
    NSArray *_controllers;
}

@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) SQimageMenuShowView *sideShowView;
@property (nonatomic, assign) BOOL isShow;
@property(nonatomic,strong)UIView* blackview;

@end

@implementation FashionWorldViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _imageView.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"时尚圈";
    self.view.userInteractionEnabled = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHex:0x464545];
    
    _imageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];

    TitleViewController *titleCtl = [[TitleViewController alloc] initWithFrame:self.view.frame
                                                                        titles:@[@"动态", @"视频"]
                                                               viewControllers:@[[FWFriendViewController new],
                                                                                 [FWVideoViewController new]]
                                                         andIsFixedTitleLength:NO
                                                                   andHasNavig:YES
                                                                  andHasTabbar:YES];
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
    //    [self sendNetWorkingRequest];
    
    __weak typeof(self) weakSelf = self;
    [self.sideShowView selectBlock:^(SQimageMenuShowView *view, NSInteger index) {
        weakSelf.isShow = NO;
        [self spliteAction:index];
    }];
}

#pragma mark - 弹出框 ACTION
- (void)spliteAction:(NSInteger)index
{
    if ([DDXUserinfo getUserId]) {
        switch (index) {
                //        case 0:
                //        {
                //            NSLog(@"联系人");
                //            [self dismiss];
                //            break;
                //        }
            case 0:
            {
                NSLog(@"发布动态");
                FashioncircleViewController *ctl = [FashioncircleViewController new];
                ctl.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:ctl animated:YES];
                [self dismiss];
                break;
            }
            case 1:
            {
                NSLog(@"我的动态");
                MyFriendContentViewController *ctl = [[MyFriendContentViewController alloc] initWithUserId:[DDXUserinfo getUserId]];
                ctl.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:ctl animated:YES];
                [self dismiss];
                break;
            }
            default:
                break;
        }
    } else {
        [self presentViewController:[LoginViewController new] animated:YES completion:nil];
    }
   
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 隐藏导航栏下的横线
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

#pragma mark - side Action

- (IBAction)contactAction:(UIBarButtonItem *)sender {
    MessageListViewController *mevc=[[MessageListViewController alloc]init];
    mevc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mevc animated:YES];
}


- (IBAction)moreAction:(UIBarButtonItem *)sender {
    NSLog(@"展开小列表");
    _isShow = !_isShow;
    NSLog(@"%d",_isShow);
    
    if (_isShow) {
        //点击后弹出背景透明view
        [UIView animateWithDuration:0.0005 animations:^{
            if(!self.blackview){
                //添加各种滑动手势
                self.blackview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
                UISwipeGestureRecognizer *swipeup = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
                UISwipeGestureRecognizer *swipeleft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
                UISwipeGestureRecognizer *swiperight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
                UISwipeGestureRecognizer *swipedown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
                [swipeleft setDirection:UISwipeGestureRecognizerDirectionLeft];
                [swiperight setDirection:UISwipeGestureRecognizerDirectionRight];
                [swipeup setDirection:UISwipeGestureRecognizerDirectionUp];
                [swipedown setDirection:UISwipeGestureRecognizerDirectionDown];
                [self.blackview addGestureRecognizer:swipeleft];
                [self.blackview addGestureRecognizer:swiperight];
                [self.blackview addGestureRecognizer:swipeup];
                [self.blackview addGestureRecognizer:swipedown  ];
                [self.blackview addGestureRecognizer:tap];
            }
            self.blackview.frame=CGRectMake(0, 0, kScreen_Width, kScreen_Height);
            self.blackview.backgroundColor=[UIColor clearColor];
            //把背景blackview放的弹出view的下面
            [self.view insertSubview:self.blackview belowSubview:self.sideShowView];
        } completion:^(BOOL finished) {
            //动画结束后弹出弹出view
            [self.sideShowView showView];
        }];
    }else{
        //弹出view和背景blackview一起消失
        
        [UIView animateWithDuration: 0.35 animations: ^{
            [self.sideShowView dismissView];
        }completion:^(BOOL finished) {
            
            [UIView animateWithDuration: 0.01 animations: ^{
                
                self.blackview.frame =CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
                
            }completion:nil];
            
        }];
}
}

-(void)dismiss{
    _isShow = NO;
    [UIView animateWithDuration: 0.35 animations: ^{
        [self.sideShowView dismissView];
    }completion:^(BOOL finished) {
        
        [UIView animateWithDuration: 0.01 animations: ^{
            
            self.blackview.frame =CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
            
            
        }completion:nil];
        
        
    }];
}






- (SQimageMenuShowView *)sideShowView{
    
    if (_sideShowView) {
        return _sideShowView;
    }
    NSArray* themearray=@[@"发布动态", @"我的动态"];//@"联系人",
    NSArray* imagenamearray=@[@"ico_fbdt",@"ico_wddt"];//@"ico_lxr",
    _sideShowView=[[SQimageMenuShowView alloc] initWithFrame:(CGRect){CGRectGetWidth(self.view.frame)-125*kScreen_Width/375,65,111*kScreen_Width/375,0} items:themearray imagearry:imagenamearray showPoint:(CGPoint){CGRectGetWidth(self.view.frame)-30*kScreen_Width/375,5*kScreen_Width/375}];
    _sideShowView.sq_backGroundColor = [UIColor whiteColor];
    _sideShowView.layer.shadowOffset = CGSizeMake(0.3, 0.3);
    _sideShowView.layer.shadowOpacity = 0.3; //设置阴影的不透明度
    _sideShowView.layer.shadowRadius =3;  //设置阴影的半径

    [self.view addSubview:_sideShowView];
    return _sideShowView;
}


@end
