//
//  VMemberEquViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/9.
//  Copyright © 2017年 李萍. All rights reserved.
//

/******** 权益说明  ********/
#import "VMemberEquViewController.h"
#import "VMemberEqulCell.h"

@interface VMemberEquViewController ()

@property (nonatomic, strong) NSArray *icons;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *descStrs;

@end

@implementation VMemberEquViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"权益说明";
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"VMemberEqulCell" bundle:nil] forCellReuseIdentifier:VMemberEqulCellIdentifier];
    
    _icons = @[@"vM_integral", @"vM_bioDigital", @"vM_noReason", @"vM_timePost"];
    _titles = @[@"积分抵扣", @"全国包邮服务", @"无理由退货服务", @"发货承诺服务"];
    _descStrs = @[@"在支付订单时可享受使用积分抵扣订单金额的功能，每单可抵扣金额上限将随会员等级的提升而增加",
                  @"在支付订单时可享受使用积分抵扣订单金额的功能，每单可抵扣金额上限将随会员等级的提升而增加，在支付订单时可享受使用积分抵扣订单金额的功能，每单可抵扣金额上限将随会员等级的提升而增加",
                  @"在支付订单时可享受使用积分抵扣订单金额的功能，每单可抵扣金额上限将随会员等级的提升而增加；在支付订单时可享受使用积分抵扣订单金额的功能，每单可抵扣金额上限将随会员等级的提升而增加；在支付订单时可享受使用积分抵扣订单金额的功能，每单可抵扣金额上限将随会员等级的提升而增加",
                  @"在支付订单时可享受使用积分抵扣订单金额的功能，每单可抵扣金额上限将随会员等级的提升而增加在支付订单时可享受使用积分抵扣订单金额的功能"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VMemberEqulCell *cell = [VMemberEqulCell returnReuseCellFormTableView:self.tableView indexPath:indexPath identifier:VMemberEqulCellIdentifier];
    
    EqulModel *model = [EqulModel new];
    model.iconName = _icons[indexPath.row];
    model.titleStr = _titles[indexPath.row];
    model.descStr = _descStrs[indexPath.row];
    cell.model = model;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    NSString *str = _descStrs[indexPath.row];
    if (str.length) {
        height = (CGFloat)[str boundingRectWithSize:(CGSize){(kScreen_Width - 24), MAXFLOAT}
                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                         attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]}
                                            context:nil].size.height;
    } else {
        
    }
    return height + 140;
}


@end
