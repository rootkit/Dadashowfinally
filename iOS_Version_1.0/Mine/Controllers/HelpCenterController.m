//
//  HelpCenterController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/9.
//  Copyright © 2017年 李萍. All rights reserved.
//

/********  我的钱包-帮助中心页面 *********/
#import "HelpCenterController.h"
#import "HelpCenterCell.h"
#import "HelpCenterDescCell.h"

@interface HelpCenterController () <HelpCenterCellDelegate>
{
    CGSize _textSize;
}

//@property (nonatomic, assign) BOOL isOpen;
//@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSMutableArray <HelpCenterModel *> *titles;

@end

@implementation HelpCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"帮助中心";
    _titles = [NSMutableArray new];
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = BackCellColor;
    self.tableView.sectionHeaderHeight = 55;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"HelpCenterDescCell" bundle:nil] forCellReuseIdentifier:HelpCenterDescCellIdentifier];
    [self.tableView registerClass:[HelpCenterCell class] forHeaderFooterViewReuseIdentifier:HelpCenterCellIdentifier];
    
    [self fetchData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - data
- (void)fetchData
{
    NSArray *array = @[@"1.如何使用搭搭币？", @"2.充值失败，但是扣费成功？", @"3.如何赚取积分？", @"4.如何使用积分？", @"5.积分商城兑换积分，多久能到？"];
    
    [array enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HelpCenterModel *model = [HelpCenterModel new];
        model.title = obj;
        model.desc = @"如何使用搭搭币,充值失败，但是扣费成功,如何赚取积分,如何使用积分,积分商城兑换积分，多久能到";
        [_titles addObject:model];
    }];
    
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _textSize.height+35;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    HelpCenterModel *model = _titles[section];
    NSInteger count = model.isOpened ? 1 : 0;
    
    return count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HelpCenterDescCell *cell = [HelpCenterDescCell returnReuseCellFormTableView:self.tableView indexPath:indexPath identifier:HelpCenterDescCellIdentifier];
    
    HelpCenterModel *model = _titles[indexPath.section];;
    cell.textViewLabel.text = model.desc;
    _textSize = [self getLabelSizeFortextFont:[UIFont systemFontOfSize:12] textLabel:model.desc];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HelpCenterCell *headView = [HelpCenterCell returnReuseCellFormTableView:self.tableView identifier:HelpCenterCellIdentifier];

    headView.delegate = self;
    HelpCenterModel *model = _titles[section];
    headView.model = model;
    
    return headView;
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

- (CGSize)getLabelSizeFortextFont:(UIFont *)font textLabel:(NSString *)text{
    NSDictionary * totalMoneydic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    CGSize totalMoneySize =[text boundingRectWithSize:CGSizeMake(kScreen_Width - 24, 1000) options:NSStringDrawingUsesLineFragmentOrigin  attributes:totalMoneydic context:nil].size;
    
    return totalMoneySize;
}

#pragma mark - HelpCenterCellDelegate
- (void)clickToPulldownAction:(HelpCenterCell *)cell
{
//    cell.model.opened = !cell.model.opened;

    [self.tableView reloadData];
}

@end
