//
//  PhoneNumListController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/28.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "PhoneNumListController.h"
#import "NewContactCell.h"

#import <Contacts/Contacts.h>

@interface PhoneNumListController ()

@property (nonatomic, strong) NSMutableArray *titleSections; //标题数组
@property (nonatomic, strong) NSMutableArray *sectionsArray; //数组数组
@property (nonatomic, strong) NSMutableArray <ContactModel *> *contactArray;//电话薄数组

@end

@implementation PhoneNumListController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"通讯录";
    
    self.tableView.backgroundColor = BackCellColor;
    [self.tableView registerClass:[NewContactCell class] forCellReuseIdentifier:NewContactCellIdentifier];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.sectionIndexColor = ThemeColor;
    self.tableView.sectionIndexTrackingBackgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
    [self requestAuthorizationAddrssBook];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - addressBook
- (void)requestAuthorizationAddrssBook
{
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (status == CNAuthorizationStatusNotDetermined) {
        
        [self getContactData];
    } else if (status == CNAuthorizationStatusRestricted) {
        MBProgressHUD *hud = [MBProgressHUD new];
        [self.view addSubview:hud];
        hud.labelText = @"应用不仅不能够访问联系人数据，并且用户也不能在设置中改变这个状态。这个状态的可能原因可能是某些被激活的限制所导致的（比如说家长控制）。";
        //        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:1.0];
    } else if (status == CNAuthorizationStatusDenied) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    } else if (status == CNAuthorizationStatusAuthorized) {
        
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
                                    
                                    [self.contactArray addObject:model];
                                }
                            }];
                            [self fetchData];
                            
                        } else {
                            
                        }
                        
                    }];
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

#pragma mark - delegate

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
    static NSString *identifier = @"NoRefuse";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    ContactModel *model = _sectionsArray[indexPath.section][indexPath.row];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.phoneNumber;
    cell.textLabel.textColor = SecondTextColor;
    cell.detailTextLabel.textColor = InfoTextColor;
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

    NSLog(@"添加手机联系人");
    ContactModel *model = _sectionsArray[indexPath.section][indexPath.row];
    
    AddressEditViewController *addressEditVc = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    addressEditVc.phoneNum = model.phoneNumber;
    [self.navigationController popToViewController:addressEditVc animated:YES];
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

@end
