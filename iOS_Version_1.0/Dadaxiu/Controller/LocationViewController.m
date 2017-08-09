//
//  LocationViewController.m
//  iOS_Version_1.0
//
//  Created by 李萍 on 2017/4/21.
//  Copyright © 2017年 李萍. All rights reserved.
//

/****** 首页定位  *****/
#import "LocationViewController.h"
#import "LocationCell.h"

#import "UIColorHF.h"
#import "UIColor+CustomColor.h"
#import "UIView+LPView.h"
#import "Util.h"

static NSString * const identifier = @"LocationCell";
@interface LocationViewController () <UISearchBarDelegate, UISearchControllerDelegate, UITableViewDelegate, UITableViewDataSource, LocationCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *searchResultList;//搜索数组

@property (nonatomic, strong) NSMutableArray *hotCitys; //热门城市
@property (nonatomic, strong) NSMutableArray *titleSections; //标题数组
@property (nonatomic, strong) NSMutableArray *sectionsArray; //城市数组数组

@end

@implementation LocationViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _searchResultList = [NSMutableArray array];
            
        if (!_locationCity.length) {
            _locationCity = @"深圳";
        }
        _sectionsArray = [NSMutableArray new];
        _titleSections = [NSMutableArray new];
        _hotCitys = [NSMutableArray new];
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.translucent = NO;
//   self.automaticallyAdjustsScrollViewInsets =         NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _hotCitys = [@[@"北京", @"上海", @"广州", @"深圳", @"成都", @"杭州", @"南京", @"武汉"] mutableCopy];
    _titleSections = [@[@"定位", @"热门"] mutableCopy];
//    [self layoutSegmentedCtl];/* 标题 暂去*/
    self.title = @"地区";
    
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.tableView];
    
    [self customTableViewHeadView];
    
    
    NSArray *titleArray = [Util indexTitleWithArray:[self fetchDateFromList].mutableCopy];
    [_titleSections addObjectsFromArray:titleArray];
    _sectionsArray = [[Util arrayWithArray:[self fetchDateFromList].mutableCopy] mutableCopy];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
//    if (self.searchController.active) {
//        self.searchController.active = NO;
//        [self.searchController.searchBar removeFromSuperview];
//    }
}

- (void)layoutSegmentedCtl
{
    UISegmentedControl *segmentCtl = [[UISegmentedControl alloc] initWithItems:@[@"国内"]];
    segmentCtl.frame = CGRectMake(0, 0, 80, 28);
    segmentCtl.backgroundColor = [UIColor whiteColor];
    segmentCtl.layer.cornerRadius = 2;
    segmentCtl.selectedSegmentIndex = 0;
    self.navigationItem.titleView = segmentCtl;
    segmentCtl.tintColor = ThemeColor;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 获取地区plist数据
- (NSMutableArray *)fetchDateFromList
{
    NSMutableArray *locations = [NSMutableArray new];
    //读文件 locations
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"locations" ofType:@"plist"];
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    NSArray *array = dictionary[@"address"];
    
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *firstArray = obj[@"sub"];
        NSLog(@"*****************************************");

        [firstArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *secondName = obj[@"name"];//市
//            NSArray *secondArray = obj[@"sub"];

            NSLog(@"市 === %@", secondName);
            [locations addObject:secondName];
            
//            [secondArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                //区/县
//                NSLog(@"区/县==%@", obj);
//                [locations addObject:obj];
//            }];
        }];
    }];
    
    return locations;
}

#pragma mark - 懒加载
- (UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"输入城市名或拼音查询";
        _searchBar.barTintColor = [UIColor whiteColor];
        _searchBar.tintColor = ThemeColor;
        [_searchBar setContentMode:UIViewContentModeLeft];
        [_searchBar sizeToFit];
        
        UITextField *searchField = [_searchBar valueForKey:@"searchField"];
        if (searchField) {
            searchField.backgroundColor = [UIColor whiteColor];
            searchField.layer.cornerRadius = 14;
            searchField.layer.borderWidth = 0;
            searchField.clipsToBounds = YES;
            searchField.layer.borderColor = [UIColor whiteColor].CGColor;
        }
    }
    return _searchBar;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        //
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.view.width, self.view.height - 44) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView registerClass:[LocationCell class] forCellReuseIdentifier:identifier];
        self.tableView.tableFooterView = [UIView new];
        
        self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        self.tableView.sectionIndexColor = ThemeColor;
        self.tableView.sectionIndexTrackingBackgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
    }
    return _tableView;
}

- (void)customTableViewHeadView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 45)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 1)];
    lineView.backgroundColor = BackCellColor;
    [view addSubview:lineView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 7, self.view.width - 24, 31)];
    label.text = [NSString stringWithFormat:@"当前：%@", _locationCity];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor colorWithHex:0x2e2e2e];
    [view addSubview:label];
    
    self.tableView.tableHeaderView = view;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _titleSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section < 2) {
        return 1;
    } else {
        if (_sectionsArray.count > 0) {
            return ((NSMutableArray *)(_sectionsArray[section-2])).count;
        } else {
            return 0;
        }
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        LocationCell *cell = [[LocationCell alloc] initWithStyle:UITableViewCellStyleDefault indexPath:indexPath identifier:identifier subCitys:@[@"深圳"]];
        cell.backgroundColor = BackCellColor;
        cell.delegate = self;
        
        return cell;
    } else if (indexPath.section == 1) {
        LocationCell *cell = [[LocationCell alloc] initWithStyle:UITableViewCellStyleDefault indexPath:indexPath identifier:identifier subCitys:_hotCitys] ;
        cell.backgroundColor = BackCellColor;
        cell.delegate = self;
        
        return cell;
    } else {
        static NSString *cellIdentifier = @"DadaxiuCollectionViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = _sectionsArray[indexPath.section-2][indexPath.row];
        cell.textLabel.textColor = [UIColor colorWithHex:0x2a2a2a];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
        return cell;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 30)];
    view.backgroundColor = BackCellColor;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(13, 5, self.view.width-26, 20)];
    label.text = _titleSections[section];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor colorWithHex:0xa8a8a8];
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 55;
    } else if (indexPath.section == 1) {
        CGFloat height = 0;
        if (_hotCitys.count > 0) {
            height = 9;
            
            int i = (_hotCitys.count-1)/3;

            height += (37+9)*(i+1);

        } else {
            height = 0;
        }
        
        
        return height;
    }
    return 45;
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

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _titleSections.copy;
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    // 获取所点目录对应的indexPath值
    NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:index];
    // 让table滚动到对应的indexPath位置
    [tableView scrollToRowAtIndexPath:selectIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    
    return index;
}

//#pragma mark - UISearchBar
//- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
//    
//}

#pragma mark - LocationCellDelegate
- (void)tableviewSelectedIndex:(NSString *)city
{
    NSLog(@"city ==== %@", city);
}

#pragma mark - scrollview
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"dddd");
    [self.view endEditing:YES];
}


@end
