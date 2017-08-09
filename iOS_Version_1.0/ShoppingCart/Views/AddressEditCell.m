//
//  AddressEditCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/4.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "AddressEditCell.h"

@interface AddressEditCell () <UITextFieldDelegate>

@end

@implementation AddressEditCell

+ (instancetype)returnReuseCellFormTableView:(UITableView *)tableView
                                  indexPath:(NSIndexPath *)indexPath
                                 identifier:(NSString *)identifierString
{
    AddressEditCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierString forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.nameTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.phoneNumTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
     self.phoneNumTF.keyboardType= UIKeyboardTypeNumberPad;
    [self.addressTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.detailAdTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.nameTF.delegate = self;
    self.phoneNumTF.delegate = self;
    self.addressTF.delegate = self;
    self.detailAdTF.delegate = self;
}

#pragma mark - add contact
- (IBAction)addContactAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(addressBookAction:)]) {
        [_delegate addressBookAction:self];
    }
}

#pragma mark - address action
- (IBAction)addressAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(locationAddressAction:)]) {
        [_delegate locationAddressAction:self];
    }
}

#pragma mark - dafault action
- (IBAction)defaultAction:(UISwitch *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(switchDefaultAddressAction:withSwitch:)]) {
        [_delegate switchDefaultAddressAction:self withSwitch:sender];
    }
}

- (void)textFieldDidChange:(UITextField *)textfield
{
    if (textfield.tag == 1) {
        NSLog(@"11111");
    } else if (textfield.tag == 2) {
       
        NSLog(@"22222");
    } else if (textfield.tag == 3) {
        NSLog(@"33333");
    } else if (textfield.tag == 4) {
        NSLog(@"44444");
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(addressChangeAction:textfieldTag:textString:)]) {
        [_delegate addressChangeAction:self textfieldTag:textfield.tag textString:textfield.text];
    }
}

@end
