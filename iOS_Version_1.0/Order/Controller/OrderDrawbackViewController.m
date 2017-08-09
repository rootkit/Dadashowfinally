//
//  OrderDrawbackViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/9.
//  Copyright © 2017年 李萍. All rights reserved.
//

/**** 申请退款 ****/
#import "OrderDrawbackViewController.h"
#import "SalesReturnViewController.h"

#import "SalesBackHeadView.h"
#import "SalesReturnCell.h"
#import "SalesExchangeCell.h"

@interface OrderDrawbackViewController ()

@property (nonatomic, assign) GoodsOrderTypes drawBackType;
@property (nonatomic, strong) SalesBackHeadView *headView;

@end

@implementation OrderDrawbackViewController

- (instancetype)initWithDrawBackType:(GoodsOrderTypes)type
{
    self = [super init];
    if (self) {
        _drawBackType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"申请退款";
    
    self.tableView.tableHeaderView = self.headView;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = BackCellColor;
    [self.tableView registerClass:[SalesReturnCell class] forCellReuseIdentifier:SalesReturnCellIdentifier];
    [self.tableView registerClass:[SalesExchangeCell class] forCellReuseIdentifier:SalesExchangeCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_drawBackType == GoodsOrderTypesWithWaitForReceiv) {
        return 1;
    } else if (_drawBackType == GoodsOrderTypesWithRemainTobeEvaluated) {
        return 2;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        SalesReturnCell *cell = [SalesReturnCell returnReuseCellFormTableView:tableView indexPath:indexPath identifier:SalesReturnCellIdentifier];
        
        return cell;
    } else if (indexPath.row == 1) {
        SalesExchangeCell *cell = [SalesExchangeCell returnReuseCellFormTableView:tableView indexPath:indexPath identifier:SalesExchangeCellIdentifier];
        
        return cell;
    }
    
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 65*rating;
    } else if (indexPath.row == 1) {
        return 90*rating;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 12*rating;
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
    if (indexPath.row == 0) {
        SalesReturnViewController *ctl = [SalesReturnViewController new];
        [self.navigationController pushViewController:ctl animated:YES];
    }
}

#pragma mark - init

- (SalesBackHeadView *)headView
{
    if (!_headView) {
        _headView = [[SalesBackHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 97*rating)];
        _headView.backgroundColor = [UIColor whiteColor];
    }
    return _headView;
}

@end
