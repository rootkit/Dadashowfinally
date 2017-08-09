//
//  CouponListViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/20.
//  Copyright © 2017年 李萍. All rights reserved.
//

/****  优惠券列表  ****/
#import "CouponListViewController.h"

#import "CouponForShopsCell.h"

@interface CouponListViewController () <CouponForShopsCellDelegate>

@property (nonatomic, assign) CouponListType listType;
@property (nonatomic, strong) NSMutableArray <DDXCouponModel *> *contents;

@end

@implementation CouponListViewController

- (instancetype)initWithCouponListType:(CouponListType)type
{
    self = [super init];
    if (self) {
        self.listType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = BackCellColor;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[CouponForShopsCell class] forCellReuseIdentifier:CouponForShopsCellIdentifier];
    
    self.contents = [NSMutableArray new];
    [self testData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - data

- (void)testData
{
    NSArray *prices = @[@(20.00), @(50.00), @(5.00)];
    NSArray *infos = @[@"满389元使用", @"满499元使用", @"满100元使用"];
    NSArray *logo = @[@"hurst", @"elly", @"gelaiwei"];
    NSArray *titles = @[@"hurst官方旗舰店店铺优惠券", @"elly旗舰店店铺优惠券", @"戈莱薇旗舰店店铺优惠券"];
    NSArray *times = @[@"2017.02.06-2017-02-17",
                       @"2017.02.03-2017-02-17",
                       @"2017.02.06-2017-02-11"];
    NSArray *using = @[@(NO), @(NO), @(NO)];
    
    [prices enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        DDXCouponModel *model = [DDXCouponModel new];
        model.price = [prices[idx] integerValue];
        model.info = infos[idx];
        model.logo = logo[idx];
        model.title = titles[idx];
        model.time = times[idx];
        model.isUsing = [using[idx] boolValue];
        
        [self.contents addObject:model];
    }];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CouponForShopsCell *cell = [CouponForShopsCell returnReuseCellFormTableView:tableView indexPath:indexPath identifier:CouponForShopsCellIdentifier];
    
    cell.delegate = self;
    cell.model = self.contents[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return coupon_Height+10;
}

#pragma mark - CouponForShopsCellDelegate
- (void)clickBtnActionWithCouponForShopsCell:(CouponForShopsCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSLog(@"立即使用 第%ld个", (long)indexPath.row);
}


@end
