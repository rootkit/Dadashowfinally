//
//  OrderLogisticsDetailViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/9.
//  Copyright © 2017年 李萍. All rights reserved.
//

/**** 查看物流 ****/
#import "OrderLogisticsDetailViewController.h"
#import "OrderLogisticsDetailCell.h"
#import "OrderLogisticsDetailHeadView.h"

@interface OrderLogisticsDetailViewController ()

@property (nonatomic, strong) OrderLogisticsDetailHeadView *headView;
@property (nonatomic, strong) NSMutableArray *logisticses;

@end

@implementation OrderLogisticsDetailViewController

- (instancetype)initWithOrderId:(NSInteger)orderId
{
    self = [super init];
    if (self) {
        _logisticses = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查看物流";
    
    self.tableView.tableHeaderView = self.headView;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[OrderLogisticsDetailCell class] forCellReuseIdentifier:OrderLogisticsDetailCellIdentifier];
    _logisticses = @[@"", @"", @"", @""].mutableCopy;
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
    return _logisticses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderLogisticsDetailCell *cell = [OrderLogisticsDetailCell returnReuseCellFormTableView:tableView indexPath:indexPath identifier:OrderLogisticsDetailCellIdentifier];
    if (_logisticses.count) {
        if (_logisticses.count == 1) {
            [cell logisticsIsFirst:YES isLast:YES];
        } else {
            if (indexPath.row == 0) {
                [cell logisticsIsFirst:YES isLast:NO];
            } else if (indexPath.row == _logisticses.count-1) {
                [cell logisticsIsFirst:NO isLast:YES];
            } else {
                [cell logisticsIsFirst:NO isLast:NO];
            }
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UILabel *label = [UILabel new];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.font = [UIFont systemFontOfSize:12*rating];
    label.text = @"[深圳市]快件已经签收，感谢您使用中通快递，感谢您使用中通快递，感谢您使用中通快递";
    CGFloat heigth = (CGFloat)[label.text boundingRectWithSize:(CGSize){(kScreen_Width - 63*rating), MAXFLOAT}
                                                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                    attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12*rating]}
                                                       context:nil].size.height;
    
    return 48*rating+heigth;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 12*rating;
}

#pragma mark - init
- (OrderLogisticsDetailHeadView *)headView
{
    if (!_headView) {
        _headView = [[OrderLogisticsDetailHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 87*rating)];
        _headView.backgroundColor = [UIColor whiteColor];
    }
    return _headView;
}

@end
