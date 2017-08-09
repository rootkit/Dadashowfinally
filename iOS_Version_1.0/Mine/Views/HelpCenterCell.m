//
//  HelpCenterCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/26.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "HelpCenterCell.h"

#define img_width 16
#define img_height 8

@interface HelpCenterCell ()

@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UIImageView *img;

@end

@implementation HelpCenterCell

+(instancetype)returnReuseCellFormTableView:(UITableView *)tableView
                                 identifier:(NSString *)identifierString
{
    HelpCenterCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifierString];
    
    [cell drawSubviews];
    
    return cell;
}

- (void)drawSubviews
{
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
        make.left.equalTo(@(0));
    }];
    
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = BackCellColor;
    [bottomView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(1));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
        make.left.equalTo(@(0));
    }];
    
    UIButton *button = [UIButton new];
    [bottomView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
        make.width.equalTo(@(50));
    }];
    [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *img = [UIImageView new];
//    img.image = [UIImage imageNamed:@"MyWalletHelp_off_icon"];//MyWalletHelp_on_icon
    [button addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-12));
        make.width.equalTo(@(img_width));
        make.height.equalTo(@(img_height));
        make.centerY.equalTo(button);
    }];
    _img = img;
    
    UILabel *label = [UILabel new];
//    label.text = @"1、如何使用搭搭币？";
    label.textColor = [UIColor colorWithHex:0x353535];
    label.font = [UIFont systemFontOfSize:16];
    [bottomView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12));
        make.centerY.equalTo(self);
        make.right.equalTo(button.mas_left).with.offset(10);
    }];
    _titleLb = label;
}

- (void)setModel:(HelpCenterModel *)model
{
    _model = model;
    _img.image = [UIImage imageNamed:(model.opened ? @"MyWalletHelp_on_icon" : @"MyWalletHelp_off_icon")];
    _titleLb.text = model.title;
}

#pragma mark - action
- (void)clickAction:(UIButton *)button
{
    _model.opened = !_model.isOpened;
    if (_delegate && [_delegate respondsToSelector:@selector(clickToPulldownAction:)]) {
        [_delegate clickToPulldownAction:self];
    }
    
}

- (void)changePulldownImg:(BOOL)isPulldown
{
    _img.image = [UIImage imageNamed:(isPulldown ? @"MyWalletHelp_on_icon" : @"MyWalletHelp_off_icon")];
}

@end


/********/

@implementation HelpCenterModel



@end

