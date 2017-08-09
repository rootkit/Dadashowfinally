//
//  AddressEditCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/4.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddressEditCell;
@protocol AddressEditCellDelegate <NSObject>

- (void)addressBookAction:(AddressEditCell *)cell;
- (void)locationAddressAction:(AddressEditCell *)cell;
- (void)addressChangeAction:(AddressEditCell *)cell
               textfieldTag:(NSInteger)tag
                 textString:(NSString *)textStr;
- (void)switchDefaultAddressAction:(AddressEditCell *)cell withSwitch:(UISwitch *)switchCt;

@end

#define AddressEditCellIdentifier @"AddressEditCell"
@interface AddressEditCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UITextField *detailAdTF;
@property (weak, nonatomic) IBOutlet UISwitch *defaultSwitch;

+(instancetype)returnReuseCellFormTableView:(UITableView *)tableView
                                  indexPath:(NSIndexPath *)indexPath
                                 identifier:(NSString *)identifierString;

@property (nonatomic, weak) id <AddressEditCellDelegate> delegate;

@end
