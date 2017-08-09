//
//  SecurityCenterViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/6.
//  Copyright © 2017年 李萍. All rights reserved.
//

/***** 账户安全 *****/
#import "SecurityCenterViewController.h"

@interface SecurityCenterViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nickNameLb;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLb;
@property (weak, nonatomic) IBOutlet UILabel *insuraLb;

@end

@implementation SecurityCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    [self setUserInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - data
- (void)setUserInfo
{
    DDXUserinfo *userInfo = [DDXUserinfo loadUserInfoFromSanbox];
    self.nickNameLb.text = userInfo.alias.length ? userInfo.alias : @"无昵称";
    self.phoneNumLb.text = [NSString stringWithFormat:@"%@****%@", [userInfo.mobile substringToIndex:3], [userInfo.mobile substringWithRange:NSMakeRange(7, 4)]];
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 2) {
        
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


@end
