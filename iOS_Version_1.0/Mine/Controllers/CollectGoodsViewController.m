//
//  CollectGoodsViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/6.
//  Copyright © 2017年 李萍. All rights reserved.
//
/***** 收藏宝贝列表 *****/
#import "CollectGoodsViewController.h"
#import "CollectGoodsCell.h"
#import "GuessLikeCCell.h"
#import "GoodsCartsHeaderView.h"

@interface CollectGoodsViewController () <GuessLikeCCellDelegate>

@end

@implementation CollectGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = BackCellColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[CollectGoodsCell class] forCellReuseIdentifier:CollectGoodsCellIdentifier];
    [self.tableView registerClass:[GuessLikeCCell class] forCellReuseIdentifier:GuessLikeCCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 1;
    } else{
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        GuessLikeCCell *cell = [GuessLikeCCell returnResueCellFormTableView:tableView indexPath:indexPath identifier:GuessLikeCCellIdentifier];
        cell.delegate = self;
        
        return cell;
    } else {
        CollectGoodsCell *cell = [CollectGoodsCell returnResueCellFormTableView:tableView indexPath:indexPath identifier:CollectGoodsCellIdentifier];
        
        
        return cell;
    }
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 240*rating;
    } else {
        return 100*rating + 6;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {//最后一个分区
        return [self customGuessLikeHeaderView];
    } else {
        
        return nil;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 48*rating;
    }
    return 0.001;
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

#pragma mark - init view
- (UIView *)customGuessLikeHeaderView
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 48*rating)];
    bottomView.backgroundColor = [UIColor whiteColor];
    UILabel *label = [UILabel new];
    label.text = @"猜你喜欢";
    label.font = [UIFont systemFontOfSize:14*rating];
    label.textColor = FirstTextColor;
    label.textAlignment = NSTextAlignmentCenter;
    CGFloat labelWidth = 74*rating;
    label.frame = CGRectMake(CGRectGetMidX(bottomView.frame) - labelWidth/2, 11*rating, labelWidth, 26*rating);
    
    
    [bottomView addSubview:label];
    
    UIImageView *leftIMG = [UIImageView new];
    leftIMG.image = [UIImage imageNamed:@"bg_left"];
    leftIMG.frame = CGRectMake((CGRectGetMinX(label.frame) - 20 - 51)*rating, 20*rating, 51*rating, 8*rating);
    [bottomView addSubview:leftIMG];
    
    UIImageView *rightIMG = [UIImageView new];
    rightIMG.image = [UIImage imageNamed:@"bg_right"];
    rightIMG.frame = CGRectMake((CGRectGetMaxX(label.frame) + 20)*rating, 20*rating, 51*rating, 8*rating);
    [bottomView addSubview:rightIMG];
    
    return bottomView;
}

#pragma mark - GuessLikeCCellDelegate
- (void)pushGoodsToCartAction
{
    NSLog(@"加入购物车");
}


@end
