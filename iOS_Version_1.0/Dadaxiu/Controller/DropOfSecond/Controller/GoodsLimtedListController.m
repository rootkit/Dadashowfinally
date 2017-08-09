//
//  GoodsLimtedListController.m
//  testSecondsView
//
//  Created by ping_L on 2017/6/1.
//  Copyright © 2017年 ping_L. All rights reserved.
//

#import "GoodsLimtedListController.h"
#import "SelectedLimitedCell.h"
#import "SetLimitedCell.h"

#define kScreen_Width  [UIScreen mainScreen].bounds.size.width
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define headTimeView_Height 40*kScreen_Width/375

#define item_padding 10*kScreen_Width/375

#define first_item_height 225*kScreen_Width/375
//
#define item_width (kScreen_Width-2*12-item_padding)/2
#define item_height 255*item_width/170

#define secondSec_Headview_H 35*kScreen_Width/375
#define second_item_height item_height*10+34*item_width/170
#define info_font 13*kScreen_Width/375
#define info_height 38*kScreen_Width/375
#define headView_height 14*kScreen_Width/375
#define headView_width 60*kScreen_Width/375

@interface GoodsLimtedListController () <SetLimitedCellDelegate>

@property (nonatomic, strong) UIView *headTimeView;
@property (nonatomic, strong) NSArray *arrays;
@property (nonatomic, assign) NSInteger cellRows;

@end

@implementation GoodsLimtedListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    self.tableView.tableHeaderView = self.headTimeView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[SelectedLimitedCell class] forCellReuseIdentifier:SelectedLimitedCellIdentifier];
    [self.tableView registerClass:[SetLimitedCell class] forCellReuseIdentifier:SetLimitedCellIdentifier];
    _arrays = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7"];
    
    _cellRows = _arrays.count/2 + _arrays.count%2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return _cellRows;
    }
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return first_item_height;
    } else if (indexPath.section == 1) {
        return item_height;
    } else {
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return secondSec_Headview_H;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        SelectedLimitedCell *cell = [SelectedLimitedCell returnResueCellFormTableView:self.tableView indexPath:indexPath identifier:SelectedLimitedCellIdentifier];
        
        return cell;
    } else if (indexPath.section == 1) {
        SetLimitedCell *cell = [SetLimitedCell returnResueCellFormTableView:self.tableView indexPath:indexPath identifier:SetLimitedCellIdentifier];
        
        cell.delegate = self;
        
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row];
        cell.backgroundColor = [UIColor magentaColor];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return self.headTimeView;
    } else {
        return [UIView new];
    }
}

#pragma mark - init
- (UIView *)headTimeView
{
    if (!_headTimeView) {
        _headTimeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, secondSec_Headview_H)];
        _headTimeView.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLb = [UILabel new];
        titleLb.text = @"限量秒杀";
        titleLb.font = [UIFont systemFontOfSize:info_font];
        titleLb.textColor = ThemeColor;
        titleLb.textAlignment = NSTextAlignmentCenter;
        [_headTimeView addSubview:titleLb];
        
        [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_headTimeView);
            make.centerY.equalTo(_headTimeView);
            make.width.equalTo(@(headView_width));
        }];
        
        UILabel *leftLine = [UILabel new];
        leftLine.text = @"....................................";
        leftLine.font = [UIFont systemFontOfSize:info_font];
        leftLine.textColor = ThemeColor;
        leftLine.textAlignment = NSTextAlignmentCenter;
        [_headTimeView addSubview:leftLine];
        
        [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_headTimeView).with.offset(-3);
            make.left.equalTo(@(12));
            make.right.equalTo(titleLb.mas_left).with.offset(-12);
        }];
        
        UILabel *rightLine = [UILabel new];
        rightLine.text = @"....................................";
        rightLine.font = [UIFont systemFontOfSize:info_font];
        rightLine.textColor = ThemeColor;
        rightLine.textAlignment = NSTextAlignmentCenter;
        [_headTimeView addSubview:rightLine];
        
        [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_headTimeView).with.offset(-3);
            make.right.equalTo(@(-12));
            make.left.equalTo(titleLb.mas_right).with.offset(12);
        }];
    }
    return _headTimeView;
}

#pragma mark - SetLimitedCellDelegate
- (void)clickSetLimitedCell:(SetLimitedCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSLog(@"indexPath = %ld", (long)indexPath.row);
}

@end
