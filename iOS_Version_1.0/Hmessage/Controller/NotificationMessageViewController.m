//
//  NotificationMessageViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/4/21.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "NotificationMessageViewController.h"
#import "NotideatilTableViewCell.h"
#import "UIColor+CustomColor.h"

@interface NotificationMessageViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *NotimessagelistTableView;

@end

@implementation NotificationMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackCellColor;
    self.title = @"通知消息";
    
    [self.NotimessagelistTableView registerClass:[NotideatilTableViewCell class] forCellReuseIdentifier:NotideatilTableViewCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NotideatilTableViewCell *cell = [NotideatilTableViewCell returnResueCellFormTableView:tableView indexPath:indexPath identifier:NotideatilTableViewCellIdentifier];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
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
    UIView *customHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.NotimessagelistTableView.width, 20)];
    customHeaderView.backgroundColor = BackCellColor;
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(16, 5, 90, 20)];
    lable.backgroundColor = [UIColor colorWithHex:0xd8d8d8];
    lable.textColor = [UIColor colorWithHex:0xffffff];
    lable.font = [UIFont systemFontOfSize:11];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.text = @" 2017年4月14日";
    lable.layer.cornerRadius = 4;
    
    [customHeaderView addSubview:lable];
    
    return customHeaderView;
}

#pragma mark - init
- (UITableView *)NotimessagelistTableView
{
    if (!_NotimessagelistTableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        _NotimessagelistTableView = tableView;
    }
    return _NotimessagelistTableView;
}


@end
