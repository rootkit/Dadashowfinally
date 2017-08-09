//
//  CollectShopsViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/6.
//  Copyright © 2017年 李萍. All rights reserved.
//
/***** 收藏店铺列表 *****/
#import "CollectShopsViewController.h"
#import "CollectShopsCell.h"

#define cell_Height 180*kScreen_Width/375
@interface CollectShopsViewController ()

@end

@implementation CollectShopsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = BackCellColor;
    [self.tableView registerClass:[CollectShopsCell class] forCellReuseIdentifier:CollectShopsCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CollectShopsCell *cell = [CollectShopsCell returnResueCellFormTableView:tableView indexPath:indexPath identifier:CollectShopsCellIdentifier];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cell_Height+6;
}

@end
