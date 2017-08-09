//
//  TransactionViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/16.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "TransactionViewController.h"
#import "TransactionCell.h"
#import "TransactionSecondCell.h"
@interface TransactionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *transactionview;
@end

@implementation TransactionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"交易记录";
    self.view.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    [self transactionview];
}

- (UITableView *)transactionview
{
    if (!_transactionview) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight=50.0;
        [self.view addSubview:tableView];
        _transactionview = tableView;
        [_transactionview  registerClass:[TransactionCell class] forCellReuseIdentifier:TransactionCellIdentifier];
        [_transactionview  registerClass:[TransactionSecondCell class] forCellReuseIdentifier:TransactionSecondCellIdentifier];
    }
    return _transactionview;
}

-(void)settransactview{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==1) {
    TransactionSecondCell *cell = [ TransactionSecondCell returnResueCellFormTableView:self.transactionview indexPath:indexPath identifier:TransactionSecondCellIdentifier];
        return cell;
        
    }else{
       TransactionCell *cell = [TransactionCell returnResueCellFormTableView:self.transactionview indexPath:indexPath identifier:TransactionCellIdentifier];
        return cell;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//表示图各个分区的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 34;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 68;
}

//表示他各个分区的内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* sectionview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 34)];
    sectionview.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    UILabel *label = [[UILabel alloc] init];
    label.textColor =[UIColor colorWithHex:0xaeaeae];
    label.text=@"2017年5月";
    label.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    label.frame=CGRectMake(10, 0, kScreen_Width, 34);
    label.font = [UIFont boldSystemFontOfSize:13.0f];
    label.textAlignment = NSTextAlignmentLeft;
    [sectionview addSubview:label];
    return  sectionview;
    
}
@end
