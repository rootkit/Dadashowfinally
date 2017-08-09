//
//  MineViewController.m
//  iOS_Version_1.0
//
//  Created by 李萍 on 2017/4/17.
//  Copyright © 2017年 李萍. All rights reserved.
//

/******  个人中心 *******/
#import "MineViewController.h"
#import "LoginViewController.h"
#import "MineHeaderView.h"

#import "FollowListViewController.h"
#import "CollectViewController.h"
#import "HistoryListViewController.h"
#import "ToolViewController.h"
#import "VMemberViewController.h"
#import "OpinionViewController.h"
#import "MessageListViewController.h"
#import "MyFavotableViewController.h"
#import "MyInfoViewController.h"
#import "DIYWebController.h"

#import "GoodsOrderViewController.h"
#import "OrderListViewController.h"
#import "MywalletViewController.h"
#import "SearchListViewController.h"
#import "StarFaceViewController.h"
#import "JSCallOCViewController.h"
#define rating kScreen_Width/375
#define kHeader_H 339*rating
#define kHeaderIMG_W kScreen_Width
#define kHeaderIMG_H 234*rating

@interface MineViewController () <MineHeaderViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MineHeaderView *headerView;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *icons;

@end

@implementation MineViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    self.tableView.tableFooterView = [UIView new];
    self.tableView.tableHeaderView = self.headerView;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titles = @[@"必选工具", @"优惠券", @"我的试衣间", @"我的DIY", @"意见反馈"];//, @"我的钱包", @"虚拟屋"
    _icons = @[@"mine_wallet", @"mine_fitting", @"mine_DIY", @"mine_feedback"];//, @"mine_discountCoupon", @"mine_virtual"
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 弹性HeaderView 刷新
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    //*
//    //获取偏移量
//    CGPoint offset = scrollView.contentOffset;
//    
//    CGRect rect = self.headerView.headIMG.frame;
//    //判断是否改变
//    if (offset.y < 0) {
//        
//        //我们只需要改变图片的y值和高度即可
//        rect.origin.y = offset.y;
//        
//        rect.size.height = kHeaderIMG_H - offset.y;
//        
//        
//        self.headerView.headIMG.frame = rect;
//    } else {
//        self.headerView.headIMG.frame = rect;
//    }
    
    
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40*rating;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"mineCell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    
    cell.textLabel.font = [UIFont systemFontOfSize:14*rating];
    cell.textLabel.textColor = FirstTextColor;
    cell.textLabel.text = _titles[indexPath.row];
    if (indexPath.row > 0) {
        cell.imageView.image = [UIImage imageNamed:_icons[indexPath.row-1]];
    } else {}
    
    if (indexPath.row == 0 || indexPath.row == 4) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {}
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            //必选工具
            ToolViewController *toolCtl = [ToolViewController new];
            toolCtl.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:toolCtl animated:YES];
            break;
        }
        case 1:
        {
//            //我的钱包
//            MywalletViewController* rvc=[MywalletViewController new];
//            rvc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:rvc animated:YES];
            
            //优惠券
            MyFavotableViewController *viewContrller = [MyFavotableViewController new];
            viewContrller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:viewContrller animated:YES];
            break;
        }
        case 2:
        {
            JSCallOCViewController* jsvc=[[JSCallOCViewController alloc]init];
            jsvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:jsvc animated:YES];
//            //优惠券
//            MyFavotableViewController *viewContrller = [MyFavotableViewController new];
//            viewContrller.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:viewContrller animated:YES];
            //我的试衣间
            break;
        }
        case 3:
        {
//            JSCallOCViewController* jsvc=[[JSCallOCViewController alloc]init];
//            jsvc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:jsvc animated:YES];
            
            [self presentViewController:[[DIYWebController alloc] initWithUrl:DDXAPI_DIY] animated:YES completion:nil];
            break;
        }
        case 4:
        {
            //我的试衣间//
            //意见反馈
            OpinionViewController* opevc=[[OpinionViewController alloc]init];
            opevc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:opevc animated:YES];
            break;
        }
        case 5:
        {
            //我的DIY//
            
            break;
        }
        case 6:
        {
            //意见反馈
            OpinionViewController* opevc=[[OpinionViewController alloc]init];
            opevc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:opevc animated:YES];
            break;
        }
        default:
            break;
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

#pragma mark - bar button action
- (IBAction)messageAction:(id)sender
{
    NSLog(@"message ....");
    
    MessageListViewController *mevc=[[MessageListViewController alloc]init];
    mevc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mevc animated:YES];
}

#pragma mark - MineHeaderViewDelegate

- (void)chooseUserPortrait
{
    NSLog(@"click portrait");
    if ([DDXUserinfo getUserId] > 0) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
        MyInfoViewController *ctl = [storyboard instantiateViewControllerWithIdentifier:@"MyInfoViewController"];
        ctl.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:ctl animated:YES];
    } else {
         [self presentViewController:[LoginViewController new] animated:YES completion:nil];
    }
}

- (void)chooseVMember
{
    NSLog(@"申请加V");
    
    VMemberViewController *viewContrller = [VMemberViewController new];
    viewContrller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewContrller animated:YES];
}


- (void)chooseAction:(NSInteger)tag
{
    switch (tag) {
        case 1:
        {
            NSLog(@"关注");
            FollowListViewController *viewContrller = [FollowListViewController new];
            viewContrller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:viewContrller animated:YES];
            break;
        }
        case 2:
        {
            NSLog(@"收藏");
            if ([DDXUserinfo  getUserCode].length) {
                CollectViewController *viewContrller = [CollectViewController new];
                viewContrller.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:viewContrller animated:YES];
            }else{
              [self presentViewController:[LoginViewController new] animated:YES completion:nil];   
            }
          
            break;
        }
        case 3:
        {
            NSLog(@"足迹");
            if ([DDXUserinfo  getUserCode].length) {
                HistoryListViewController *viewContrller = [HistoryListViewController new];
                viewContrller.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:viewContrller animated:YES];
            }else{
                [self presentViewController:[LoginViewController new] animated:YES completion:nil];
            }
           
            break;
        }
        case 4:
        {
            NSLog(@"全部订单");
            
            if ([DDXUserinfo getUserId] > 0) {
                GoodsOrderViewController *viewContrller = [[GoodsOrderViewController alloc] initWithOrderType:GoodsOrderTypesWithAll];
                viewContrller.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:viewContrller animated:YES];
            } else {
                
                [self presentViewController:[LoginViewController new] animated:YES completion:nil];
            }
            
            break;
        }
        case 5:
        {
            NSLog(@"待付款");
            /*
            SearchListViewController* selistvc=[SearchListViewController new];
            selistvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:selistvc animated:YES];
             */
            
            
            if ([DDXUserinfo getUserId] > 0) {
                GoodsOrderViewController *viewContrller = [[GoodsOrderViewController alloc] initWithOrderType:GoodsOrderTypesWithObligation];
                viewContrller.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:viewContrller animated:YES];
            } else {
                
                [self presentViewController:[LoginViewController new] animated:YES completion:nil];
            }
            
            break;
        }
        case 6:
        {
            NSLog(@"待收货");
            
            if ([DDXUserinfo getUserId] > 0) {
                GoodsOrderViewController *viewContrller = [[GoodsOrderViewController alloc] initWithOrderType:GoodsOrderTypesWithWaitForReceiv];
                viewContrller.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:viewContrller animated:YES];
            } else {
                
                [self presentViewController:[LoginViewController new] animated:YES completion:nil];
            }
            
            break;
        }
        case 7:
        {
            NSLog(@"待评价");
            if ([DDXUserinfo getUserId] > 0) {
                GoodsOrderViewController *viewContrller = [[GoodsOrderViewController alloc] initWithOrderType:GoodsOrderTypesWithRemainTobeEvaluated];
                viewContrller.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:viewContrller animated:YES];
            } else {
                
                [self presentViewController:[LoginViewController new] animated:YES completion:nil];
            }
            
            break;
        }
        case 8:
        {
            NSLog(@"售后");
            
            if ([DDXUserinfo getUserId] > 0) {
                GoodsOrderViewController *viewContrller = [[GoodsOrderViewController alloc] initWithOrderType:GoodsOrderTypesWithAfterSale];
                viewContrller.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:viewContrller animated:YES];
            } else {
                
                [self presentViewController:[LoginViewController new] animated:YES completion:nil];
            }
            
            break;
        }
        default:
            break;
    }
    
}

#pragma mark - init

- (MineHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[MineHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kHeader_H)];
        _headerView.backgroundColor = BackCellColor;
        _headerView.delegate = self;
    }
    
    _headerView.userInfo = [DDXUserinfo loadUserInfoFromSanbox];
    
    return _headerView;
}


@end
