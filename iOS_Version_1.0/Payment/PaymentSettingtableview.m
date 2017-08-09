//
//  PaymentSettingtableview.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/16.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "PaymentSettingtableview.h"
#import "WxandalipayViewController.h"
@interface PaymentSettingtableview ()

@end

@implementation PaymentSettingtableview

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    self.tableView.rowHeight=50.0;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);//调整内边距
    self.tableView.scrollEnabled=NO;
    self.navigationItem.title=@"支付设置";
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

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"PaymentSetting";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    cell.textLabel.text=@"默认付款方式";
    cell.textLabel.font=[UIFont systemFontOfSize:14.0];
    cell.textLabel.textColor=[UIColor colorWithHex:0x353535];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"支付设置");
    WxandalipayViewController* wxvc=[[WxandalipayViewController alloc]init];
    [self.navigationController pushViewController:wxvc animated:YES];
    
}

@end
