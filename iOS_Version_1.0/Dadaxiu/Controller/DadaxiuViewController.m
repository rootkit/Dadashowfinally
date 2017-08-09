//
//  DadaxiuViewController.m
//  iOS_Version_1.0
//
//  Created by 李萍 on 2017/4/17.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "DadaxiuViewController.h"
#import "LoginViewController.h"

#import "UIColor+CustomColor.h"
#import "UIColorHF.h"
#import "UIImage+image.h"

#import <AFNetworking/AFHTTPSessionManager.h>

@interface DadaxiuViewController () <UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate>

@property (nonatomic, weak) UIButton *locationButton;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, weak) UIButton *storeButton;
@property (nonatomic, weak) UIButton *messageButton;

@end

@implementation DadaxiuViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self customNavigationView];
    
    self.tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customNavigationView
{
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.delegate = self;
    _searchController.searchResultsUpdater = self;
    _searchController.obscuresBackgroundDuringPresentation = NO;
    
    self.navigationItem.titleView = _searchController.searchBar;
    
    _searchController.searchBar.delegate = self;
    _searchController.searchBar.placeholder = @"极简校园系帆布鞋";
    [_searchController.searchBar sizeToFit];
    _searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    
    UITextField *searchField = [_searchController.searchBar valueForKey:@"searchField"];
    if (searchField) {
        searchField.backgroundColor = [UIColor grayColor];
        searchField.layer.cornerRadius = 12;
        searchField.layer.borderWidth = 0;
        searchField.clipsToBounds = YES;
        searchField.layer.borderColor = [UIColor whiteColor].CGColor;
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
}

#pragma mark - 

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    
}

- (IBAction)barButtonAction:(id)sender
{
    LoginViewController *login = [LoginViewController new];
    [self.navigationController presentViewController:login animated:YES completion:nil];
}

@end
