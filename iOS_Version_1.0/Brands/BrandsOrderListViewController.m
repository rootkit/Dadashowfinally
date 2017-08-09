//
//  BrandsOrderListViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/27.
//  Copyright © 2017年 李萍. All rights reserved.
//

/**** 品牌街 -> 品牌推荐列表 ****/
#import "BrandsOrderListViewController.h"
#import "BrandsListCell.h"

@interface BrandsOrderListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation BrandsOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"品牌推荐";
    [self.tableView registerNib:[UINib nibWithNibName:@"BrandsListCell" bundle:nil] forCellReuseIdentifier:BrandsListCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BrandsListCell *cell = [BrandsListCell returnReuseCellFormTableView:self.tableView indexPath:indexPath identifier:BrandsListCellIdentifier];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 35)];

    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kScreen_Width, 25)];
    titleView.backgroundColor = [UIColor whiteColor];
    [view addSubview:titleView];
    
    UILabel *lb = [UILabel new];
    lb.text = @"A";
    lb.font = [UIFont systemFontOfSize:14];
    [titleView addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12));
        make.right.equalTo(@(-12));
        make.centerY.equalTo(titleView);
    }];
    
    return view;
}

#pragma mark - init

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = 35;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = BackCellColor;
        [self.view addSubview:self.tableView];
        
    }
    return _tableView;
}

@end
