//
//  VMemberViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/8.
//  Copyright © 2017年 李萍. All rights reserved.
//

/*******  会员中心 ******/
#import "VMemberViewController.h"
#import "VMemberHeaderView.h"
#import "VMemeberCell.h"
#import "VMemberEncycCell.h"
#import "VMemberEquViewController.h"

#define kHeader_H kScreen_Width*218/375

@interface VMemberViewController ()

@property (nonatomic, strong) VMemberHeaderView *headerView;

@end

@implementation VMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"会员中心";
    
    self.tableView.backgroundColor = BackCellColor;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _headerView = [[VMemberHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kHeader_H)];
    _headerView.backgroundColor = BackCellColor;
//    _headerView.delegate = self;
    self.tableView.tableHeaderView = _headerView;
    [self.tableView registerNib:[UINib nibWithNibName:@"VMemeberCell" bundle:nil] forCellReuseIdentifier:VMemeberCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"VMemberEncycCell" bundle:nil] forCellReuseIdentifier:VMemberEncycCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        VMemeberCell *cell = [VMemeberCell returnReuseCellFormTableView:self.tableView indexPath:indexPath identifier:VMemeberCellIdentifier];
        
        return cell;
    } else {
        VMemberEncycCell *cell = [VMemberEncycCell returnReuseCellFormTableView:self.tableView indexPath:indexPath identifier:VMemberEncycCellIdentifier];

        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 138;
    } else {
        return 180;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[VMemberEquViewController new] animated:YES];
    } else {}
}

@end
