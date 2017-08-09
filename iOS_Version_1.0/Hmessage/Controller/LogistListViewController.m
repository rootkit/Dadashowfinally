//
//  LogistListViewController.m
//  iOS_Version_1.0
//
//  Created by 李萍 on 2017/4/21.
//  Copyright © 2017年 李萍. All rights reserved.
//

/****** 物流消息列表  *****/
#import "LogistListViewController.h"
#import "OrderLogisticsDetailViewController.h"

#import "LogistCell.h"
#import "UIColor+CustomColor.h"
#import "UIColorHF.h"
#import "UIView+LPView.h"

static NSString * const logistCellReuseIdentifier = @"LogistCell";
@interface LogistListViewController ()

@end

@implementation LogistListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self subViewLayout];
}

- (void)subViewLayout
{
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStyleGrouped];
    self.tableView = tableview;
    self.title = @"物流消息";
    [self.tableView registerNib:[UINib nibWithNibName:@"LogistCell" bundle:nil] forCellReuseIdentifier:logistCellReuseIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = BackCellColor;

    [self.tableView showEmptyPageViewWithImage:[UIImage imageNamed:@"ico_empty_none"]
                                           tip:@"小搭未发现任何数据"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LogistCell *cell = [LogistCell returnReuseCellFormTableView:tableView
                                                      indexPath:indexPath
                                                     identifier:logistCellReuseIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 126;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //订单完成，显示物流；订单未完成，显示订单详情
    OrderLogisticsDetailViewController *ctl = [[OrderLogisticsDetailViewController alloc] initWithOrderId:0];
    [self.navigationController pushViewController:ctl animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self customHeaderView];
}

#pragma mark - custom head view

- (UIView *)customHeaderView
{
    UIView *customHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 20)];
    customHeaderView.backgroundColor = [UIColor clearColor];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(16, 5, 90, 20)];
    lable.backgroundColor = [UIColor colorWithHex:0xd8d8d8];
    lable.textColor = [UIColor colorWithHex:0xffffff];
    lable.font = [UIFont systemFontOfSize:11];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.text = @" 2017年4月21日";
    lable.layer.cornerRadius = 4;
    
    [customHeaderView addSubview:lable];
    
    return customHeaderView;
}

@end
