//
//  AddNewFriendViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/17.
//  Copyright © 2017年 李萍. All rights reserved.
//

/****  新的好友/添加好友 ****/
#import "AddNewFriendViewController.h"
#import "ContactListViewController.h"

#import "AddNewContactCell.h"
#import "NewContactCell.h"

#define tableHeaderView_Height 45

@interface AddNewFriendViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *tableHeadView;
@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic, assign) NSInteger contactType;//1 新的好友， 2 添加好友

@end

@implementation AddNewFriendViewController

- (instancetype)initWithTitle:(NSString *)title contactType:(NSInteger)type
{
    self = [super init];
    if (self) {
        self.title = title;
        self.contactType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BackCellColor;
    [self.view addSubview:self.tableView];
    
    UINavigationBar *dummyNavigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0, 0.0, kScreen_Width, tableHeaderView_Height)];
    [dummyNavigationBar setShadowImage:[UIImage new]];
    [self.tableHeadView addSubview:dummyNavigationBar];
    [self.tableHeadView addSubview:self.searchController.searchBar];
    if (self.contactType == 2) {
        self.tableView.tableHeaderView = self.tableHeadView;
    } else {
        self.tableView.tableHeaderView = nil;
    }
    
    [self.tableView registerClass:[AddNewContactCell class] forCellReuseIdentifier:AddNewContactCellIdentifier];
    [self.tableView registerClass:[NewContactCell class] forCellReuseIdentifier:NewContactCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else {
        return 2;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        AddNewContactCell *cell = [AddNewContactCell returnResueCellFormTableView:self.tableView indexPath:indexPath identifier:AddNewContactCellIdentifier];
        
        return cell;
    }  else {
        NewContactCell *cell = [NewContactCell returnResueCellFormTableView:self.tableView indexPath:indexPath identifier:NewContactCellIdentifier];
        
        return cell;
    }
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 68;
    } else {
        return 58;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 6;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        NSLog(@"添加手机联系人");
        [self.navigationController pushViewController:[ContactListViewController new] animated:YES];
    } else {
    }
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    
}

#pragma mark - scrollview
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchController.searchBar resignFirstResponder];
}

#pragma mark - init
- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = [UIView new];

        _tableView = tableView;
    }
    return _tableView;
}

- (UIView *)tableHeadView
{
    if (!_tableHeadView) {
        _tableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, tableHeaderView_Height)];
        _tableHeadView.backgroundColor = BackCellColor;
    }
    return _tableHeadView;
}

- (UISearchController *)searchController
{
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.delegate = self;
        _searchController.searchResultsUpdater = self;
        _searchController.obscuresBackgroundDuringPresentation = NO;
        
        _searchController.searchBar.delegate = self;
        _searchController.searchBar.placeholder = @"会员名/手机号";
        [_searchController.searchBar sizeToFit];
        
        _searchController.searchBar.backgroundImage = [UIImage new];
        _searchController.searchBar.backgroundColor = BackCellColor;
        _searchController.searchBar.barTintColor = BackCellColor;
        
        UITextField *searchField = [_searchController.searchBar valueForKey:@"searchField"];
        if (searchField) {
            searchField.backgroundColor = [UIColor whiteColor];
            searchField.layer.cornerRadius = 14;
            searchField.layer.borderWidth = 1;
            searchField.layer.borderColor = BackCellColor.CGColor;
        }
    }
    return _searchController;
}

@end
