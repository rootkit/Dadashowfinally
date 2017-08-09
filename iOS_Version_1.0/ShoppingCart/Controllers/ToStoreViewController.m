//
//  ToStoreViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/7.
//  Copyright © 2017年 李萍. All rights reserved.
//

/****** 到店自提（确认订单之后的选择快递方式） ******/
#import "ToStoreViewController.h"
#import "ToStoreCell.h"

@interface ToStoreViewController () <ToStoreCellDelegate>
{
    BOOL isSelected;
}

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL action;

@end

@implementation ToStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"到店自提";
    [self.tableView registerClass:[ToStoreCell class] forCellReuseIdentifier:ToStoreCellIdentifierString];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = BackCellColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - back action
- (void)backAction
{
    if ([(NSObject *)self.target respondsToSelector:self.action]) {
        [(NSObject *)self.target performSelector:self.action withObject:@"ssss"];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ToStoreCell *cell = [ToStoreCell returnReuseCellFormTableView:tableView indexPath:indexPath identifier:ToStoreCellIdentifierString];
    
    cell.delegate = self;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120*rating+10;
}

#pragma mark - ToStoreCellDelegate

- (void)contactForToStoreCell:(ToStoreCell *)cell
{
    NSLog(@"联系 调至聊天界面");
}

- (void)chooseForToStoreCell:(ToStoreCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];

    NSLog(@"选择 %ld 跳回上个界面并显示", (long)indexPath.row);
    [self backAction];
    
    isSelected = !isSelected;
    cell.isChoose = isSelected;
}

#pragma mark - init
- (void)addTarget:(id)target action:(SEL)action
{
    self.target = target;
    self.action = action;
}

@end
