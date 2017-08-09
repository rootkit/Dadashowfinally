//
//  AddressListCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/4.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDXConsignee.h"

@class AddressListCell;
@protocol AddressListCellDelegate <NSObject>

- (void)chooseDefaultAddressAction:(AddressListCell *)cell indexPath:(NSInteger)indexPath;
- (void)editingAddressAction:(AddressListCell *)cell indexPath:(NSInteger)indexPath;
- (void)deleteAddressAction:(AddressListCell *)cell indexPath:(NSInteger)indexPath;

@end

#define AddressListCellIdentifier @"AddressListCell"
@interface AddressListCell : UITableViewCell

+(instancetype)returnReuseCellFormTableView:(UITableView *)tableView
                                  indexPath:(NSIndexPath *)indexPath
                                 identifier:(NSString *)identifierString;

@property (nonatomic, weak) id <AddressListCellDelegate> delegate;
@property (nonatomic, strong) DDXConsignee *consignee;
- (void)chooseDefaultAddressIMG:(BOOL)isSelected; //改变选择图片

@end
