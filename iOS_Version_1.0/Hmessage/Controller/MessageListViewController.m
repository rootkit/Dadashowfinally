//
//  MessageListViewController.m
//  iOS_Version_1.0/Users/liping/Desktop/DDX_iOSApp/iOS_Version_1.0/ddstore_ios_development/iOS_Version_1.0/iOS_Version_1.0
//
//  Created by liping on 2017/4/21.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "MessageListViewController.h"
#import "NotificationMessageViewController.h"
#import "LogistListViewController.h"
#import "AddNewFriendViewController.h"

#import "MessagelistTableViewCell.h"


@interface MessageListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *messagelistTableView;

@end

@implementation MessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"消息";
    self.view.backgroundColor = BackCellColor;
    [self setBarbuttion];
//    [self messagelistTableView];
    
    [self.messagelistTableView registerClass:[MessagelistTableViewCell class] forCellReuseIdentifier:MessagelistTableViewCellIdentifier];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor whiteColor]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - barbutton

-(void)setBarbuttion {
    
    UIBarButtonItem *addbtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageRendingMode:@"icon_message_add"] style:UIBarButtonItemStylePlain target:self action:@selector(addfriends)];
    UIBarButtonItem *connectbtn= [[UIBarButtonItem alloc] initWithTitle:@"联系人" style:UIBarButtonItemStylePlain target:self action:@selector(contactAction)];
    [connectbtn setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:0];
    NSArray *arr=[[NSArray alloc]initWithObjects:addbtn, connectbtn, nil];
    self.navigationItem.rightBarButtonItems=arr;
}

#pragma mark -  UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessagelistTableViewCell *cell = [MessagelistTableViewCell returnResueCellFormTableView:tableView indexPath:indexPath identifier:MessagelistTableViewCellIdentifier];
    
    if (indexPath.section == 0) {
//        MessageModel *model = [MessageModel new];
//        model.imageName = @[@"icon_wuliu", @"icon_xiaoxi"][indexPath.row];
//        model.title = @[@"交易物流消息", @"通知消息"][indexPath.row];
//        model.desc = @[@"订单已签收！您购买的[韩都衣舍韩版立领]", @"新年巨献，深圳专属特权，最高30元优惠"][indexPath.row];
//        model.time = @[@"17/05/17", @"17/05/17"][indexPath.row];
//        cell.message = model;
        MessageModel *model = [MessageModel new];
        model.imageName = @[@"icon_xiaoxi"][indexPath.row];
        model.title = @[@"通知消息"][indexPath.row];
        model.desc = @[@"新年巨献，深圳专属特权，最高30元优惠"][indexPath.row];
        model.time = @[@"17/05/17"][indexPath.row];
        cell.message = model;
        
    }
    else {
        MessageModel *model = [MessageModel new];
        model.imageName = @"mine_portrait";
        model.title = @"cherrykoko旗舰店";
        model.desc = @"亲爱哒！亲爱哒！亲爱哒！亲爱哒！亲爱哒！亲爱哒！亲爱哒！亲爱哒！亲爱哒！亲爱哒！";
        model.time = @"17/05/16";
        cell.message = model;
    }
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 6;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //
            NSLog(@"交易物流消息");
            LogistListViewController *ctl = [LogistListViewController new];
            [self.navigationController pushViewController:ctl animated:YES];
        } else if (indexPath.row == 1) {
            //
            NSLog(@"通知消息");
            NotificationMessageViewController* nvc=[[NotificationMessageViewController alloc]init];
            [self.navigationController pushViewController:nvc animated:YES];
            
        } else {}
    } else {
        NSLog(@"每条消息");
    }
}

#pragma mark - bar Action

- (void)contactAction
{
    NSLog(@"联系人");
    AddNewFriendViewController *ctl = [[AddNewFriendViewController alloc] initWithTitle:@"新的好友" contactType:1];
    [self.navigationController pushViewController:ctl animated:YES];
}

-(void)addfriends
{
    NSLog(@"添加好友");
    AddNewFriendViewController *ctl = [[AddNewFriendViewController alloc] initWithTitle:@"添加好友" contactType:2];
    [self.navigationController pushViewController:ctl animated:YES];
}

#pragma mark - init
- (UITableView *)messagelistTableView
{
    if (!_messagelistTableView) {
        UITableView *tableView = [[UITableView alloc] init];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        tableView.backgroundColor = BackCellColor;
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(@0);
            make.width.equalTo(@(kScreen_Width));
            make.height.equalTo(@(kScreen_Height));
        }];
        _messagelistTableView = tableView;
    }
    return _messagelistTableView;
}



@end
