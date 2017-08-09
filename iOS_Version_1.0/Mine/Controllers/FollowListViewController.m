//
//  FollowListViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/6.
//  Copyright © 2017年 李萍. All rights reserved.
//

/******  关注列表 *******/
#import "FollowListViewController.h"
#import "FollowListCell.h"

#define cell_Height 59*kScreen_Width/375
@interface FollowListViewController () <FollowListCellDelegate>

@end

@implementation FollowListViewController
{
    BOOL _isFollow;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关注";
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = BackCellColor;
    [self.tableView registerClass:[FollowListCell class] forCellReuseIdentifier:FollowListCellIdentifier];
    
    [self.tableView showEmptyPageViewWithImage:[UIImage imageNamed:@"ico_empty_none"]
                                           tip:@"小搭未发现任何数据"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FollowListCell *cell = [FollowListCell returnResueCellFormTableView:tableView indexPath:indexPath identifier:FollowListCellIdentifier];
    cell.delegate = self;
    cell.selectedIndex = indexPath.row;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cell_Height;
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

#pragma mark - FollowListCellDelegate
- (void)clickPortraitAction:(FollowListCell *)cell indexPathRow:(NSInteger)row
{
    NSLog(@"点击头像 %ld", (long)row);
}
- (void)clickFollowingAction:(FollowListCell *)cell indexPathRow:(NSInteger)row
{
    _isFollow = !_isFollow;
    [cell changeBtnTitle:_isFollow];
    NSLog(@"%@ %ld", _isFollow ? @"已关注" : @"关注", (long)row);
}

@end
