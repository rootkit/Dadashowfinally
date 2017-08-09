//
//  AddressListCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/4.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "AddressListCell.h"

@interface AddressListCell ()

@property (weak, nonatomic) IBOutlet UILabel *namePhNumLb;
@property (weak, nonatomic) IBOutlet UILabel *addressLb;
@property (weak, nonatomic) IBOutlet UILabel *defaultStateLb;
@property (weak, nonatomic) IBOutlet UIButton *chooseAddressBtn;
@property (weak, nonatomic) IBOutlet UIButton *editingAddressBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteAddressBtn;

@end

@implementation AddressListCell

+ (instancetype)returnReuseCellFormTableView:(UITableView *)tableView
                                  indexPath:(NSIndexPath *)indexPath
                                 identifier:(NSString *)identifierString
{
    AddressListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierString forIndexPath:indexPath];
    
    cell.chooseAddressBtn.tag = indexPath.row;
    cell.editingAddressBtn.tag = indexPath.row;
    cell.deleteAddressBtn.tag = indexPath.row;
    
    return cell;
}

- (void)setConsignee:(DDXConsignee *)consignee
{
    _consignee = consignee;
    
    NSString *phoneStr = consignee.mobile.length ? consignee.mobile : @"";
    phoneStr = [NSString stringWithFormat:@"%@****%@", [phoneStr substringWithRange:NSMakeRange(0, 3)], [phoneStr substringWithRange:NSMakeRange(7, 4)]];
    
    _namePhNumLb.text = [NSString stringWithFormat:@"%@ %@", consignee.consignee, phoneStr];
    
    NSString *addressStr = [NSString stringWithFormat:@"%@ %@ %@ %@",
                            consignee.province.length ? consignee.province : @"",
                            consignee.city.length ? consignee.city : @"",
                            consignee.district.length ? consignee.district : @"",
                            consignee.address.length ? consignee.address : @""];
    _addressLb.text = addressStr.length ? addressStr : @"无";

    if (consignee.isDefault == ConsigneeAddressTypeForDefault) {
        _defaultStateLb.text = @"默认地址";
        [_chooseAddressBtn setImage:[self selectedDefauleAddressImage] forState:UIControlStateNormal];
    } else {
        _defaultStateLb.text = @"设为默认";
        [_chooseAddressBtn setImage:[self unSelectedDefauleAddressImage] forState:UIControlStateNormal];
    }
}

#pragma mark - 默认地址
- (IBAction)chooseDefaultAddressAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(chooseDefaultAddressAction:indexPath:)]) {
        [_delegate chooseDefaultAddressAction:self indexPath:sender.tag];
    }
}

#pragma mark - 地址编辑
- (IBAction)editingAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(editingAddressAction:indexPath:)]) {
        [_delegate editingAddressAction:self indexPath:sender.tag];
    }
}

#pragma Mark - 删除地址
- (IBAction)deleteAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(deleteAddressAction:indexPath:)]) {
        [_delegate deleteAddressAction:self indexPath:sender.tag];
    }
}

#pragma mark - change img
- (void)chooseDefaultAddressIMG:(BOOL)isSelected
{
    [_chooseAddressBtn setImage:(isSelected ? [self selectedDefauleAddressImage] : [self unSelectedDefauleAddressImage]) forState:UIControlStateNormal];
    _defaultStateLb.text = isSelected ? @"默认地址" : @"设为默认";
}

static UIImage *_unSelectedDefauleAddressImage;
- (UIImage *)unSelectedDefauleAddressImage
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _unSelectedDefauleAddressImage = [UIImage imageNamed:@"goods_unChoose"];
    });
    return _unSelectedDefauleAddressImage;
}
static UIImage *_selectedDefauleAddressImage;
- (UIImage *)selectedDefauleAddressImage
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _selectedDefauleAddressImage = [UIImage imageNamed:@"ico_address"];
    });
    return _selectedDefauleAddressImage;
}


@end
