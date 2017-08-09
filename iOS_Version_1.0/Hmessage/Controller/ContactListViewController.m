//
//  ContactListViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/17.
//  Copyright © 2017年 李萍. All rights reserved.
//

/****  手机联系人 ****/
#import "ContactListViewController.h"
#import "NewContactCell.h"

#import "PopBox.h"
#import "AddNewFriendBox.h"

#import <Contacts/Contacts.h>

#define tableHeaderView_Height 45
#define searchBar_H 28

@interface ContactListViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating, PopBoxDelegate, NewContactCellDelegate, AddNewFriendManagerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *tableHeadView;
@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic, strong) NSMutableArray *titleSections; //标题数组
@property (nonatomic, strong) NSMutableArray *sectionsArray; //数组数组
@property (nonatomic, strong) NSMutableArray <ContactModel *> *contactArray;//电话薄数组

@end

@implementation ContactListViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _titleSections = [NSMutableArray new];
        _sectionsArray = [NSMutableArray new];
        _contactArray = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
     //联系人访问权限弹出框
     PopBox *box = [PopBox popBoxManager];
     box.delegate = self;
     [box showPoxBox];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加联系人";
    
    self.view.backgroundColor = BackCellColor;
    
    [self.view addSubview:self.tableView];
    
    UINavigationBar *dummyNavigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0, 0.0, kScreen_Width, tableHeaderView_Height)];
    [dummyNavigationBar setShadowImage:[UIImage new]];
    [self.tableHeadView addSubview:dummyNavigationBar];
    [self.tableHeadView addSubview:self.searchController.searchBar];
    self.tableView.tableHeaderView = self.tableHeadView;
    
    [self.tableView registerClass:[NewContactCell class] forCellReuseIdentifier:NewContactCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (_sectionsArray.count > 0) {
        return ((NSMutableArray *)(_sectionsArray[section])).count;
    } else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _titleSections.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewContactCell *cell = [NewContactCell returnResueCellFormTableView:self.tableView indexPath:indexPath identifier:NewContactCellIdentifier];
    
    ContactModel *model = _sectionsArray[indexPath.section][indexPath.row];
    cell.model = model;
    cell.delegate = self;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 58;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 20)];
    view.backgroundColor = BackCellColor;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, kScreen_Width-24, 20)];
    label.text = _titleSections[section];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor colorWithHex:0xa8a8a8];
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
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
    } else {
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

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    
}

#pragma mark - scrollview
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchController.searchBar resignFirstResponder];
}

#pragma mark - NewContactCellDelegate
- (void)clickFollowAction:(NewContactCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    ContactModel *model = _sectionsArray[indexPath.section][indexPath.row];
    NSLog(@"section = %ld, row = %ld \n name = %@", (long)indexPath.section, (long)indexPath.row, model.name);
    
    //弹出框
    AddNewFriendManager *manager = [AddNewFriendManager popBoxManager];
    manager.delegate = self;
    [manager showPoxBoxWithNewFriendName:model.name];
}

#pragma mark - PopBoxDelegate
- (void)popBoxStartContactAccess:(BOOL)isStart
{
    if (isStart) {
        NSLog(@"启动");
        [self requestAuthorizationAddrssBook];
    } else {
        NSLog(@"取消");
    }
}

#pragma mark - AddNewFriendManagerDelegate
- (void)clickByInfo:(NSString *)infoString
{
    NSLog(@"发送信息 === %@", infoString);
}

#pragma mark - addressBook
- (void)requestAuthorizationAddrssBook
{
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (status == CNAuthorizationStatusNotDetermined) {
        NSLog(@"这个状态说明用户暂未决定是否允许访问联系人数据库。当应用第一次安装在设备上时将处于此状态。");
        
        [self getContactData];

    } else if (status == CNAuthorizationStatusRestricted) {
        NSLog(@"这个状态说明应用不仅不能够访问联系人数据，并且用户也不能在设置中改变这个状态。这个状态是某些被激活的限制所导致的（比如说家长控制）。");
        
        MBProgressHUD *hud = [MBProgressHUD new];
        [self.view addSubview:hud];
        hud.labelText = @"应用不仅不能够访问联系人数据，并且用户也不能在设置中改变这个状态。这个状态的可能原因可能是某些被激活的限制所导致的（比如说家长控制）。";
//        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:1.0];
    } else if (status == CNAuthorizationStatusDenied) {
        NSLog(@"这个状态说明用户不允许应用访问联系人数据。这个状态只能够被用户改变。");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    } else if (status == CNAuthorizationStatusAuthorized) {
        NSLog(@"这个状态是所有应用都希望拥有的，这表明应用能够自由访问联系人数据库，然后根据联系人数据来处理某些任务。");
        
        [self getContactData];
        
    }
    
}

- (void)getContactData
{
    CNContactStore *store = [[CNContactStore alloc] init];
    [store requestAccessForEntityType:CNEntityTypeContacts
                    completionHandler:^(BOOL granted, NSError * _Nullable error) {
                        if (granted) {
                            CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:@[[CNContactFormatter descriptorForRequiredKeysForStyle:CNContactFormatterStyleFullName],CNContactPhoneNumbersKey]];
                            NSError *error = nil;
                            
                            [store enumerateContactsWithFetchRequest:request error:&error usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
                                CNPhoneNumber * num = nil;
                                if (contact.phoneNumbers.count > 0) {
                                    num = contact.phoneNumbers[0].value;
                                }
                                NSString *phoneNumber = [num valueForKey:@"digits"];
                                NSString *name = [NSString stringWithFormat:@"%@%@", [contact valueForKey:@"familyName"], [contact valueForKey:@"givenName"]];
                                
                                if (name.length > 0 && phoneNumber.length == 11) {
                                    
                                    ContactModel *model = [ContactModel new];
                                    model.name = name;
                                    model.phoneNumber = phoneNumber;
                                    
                                    NSLog(@"姓名：%@ 电话号码：%@", model.name, model.phoneNumber);
                                    [self.contactArray addObject:model];
                                }
                            }];
                            [self fetchData];
                            
                        } else {
                            
                        }
                        
                    }];
    NSLog(@"显示名字");
}

- (void)fetchData
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        
        //子线程处理事件如：处理耗时操作、网络请求等
        NSArray *titleArray = [Util indexPhoneNumerAndNameWithDic:_contactArray];
        [_titleSections addObjectsFromArray:titleArray];
        _sectionsArray = [[Util dicPhoneNumerAndNameWithWithArray:_contactArray] mutableCopy];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            //主线程处理事件部分,刷新UI，将子线程得到的数据结果，展示到UI上
            [self.tableView reloadData];
            
        });
        
    });
    
    
    
}

#pragma mark - init
- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = [UIView new];
        tableView.backgroundColor = BackCellColor;
        tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        tableView.sectionIndexColor = ThemeColor;
        tableView.sectionIndexTrackingBackgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
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
        _searchController.searchBar.placeholder = @"搜索手机联系人";
        [_searchController.searchBar sizeToFit];
        
        _searchController.searchBar.backgroundImage = [UIImage new];
        _searchController.searchBar.backgroundColor = BackCellColor;
        _searchController.searchBar.barTintColor = BackCellColor;
        
        UITextField *searchField = [_searchController.searchBar valueForKey:@"searchField"];
        if (searchField) {
            searchField.backgroundColor = [UIColor whiteColor];
            searchField.layer.cornerRadius = 14;
            searchField.layer.borderWidth = 0;
            searchField.layer.borderColor = [UIColor colorWithHex:0xE1E1E1].CGColor;
        }
    }
    return _searchController;
}

@end




