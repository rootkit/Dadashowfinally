//
//  ToStoreCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/7.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "ToStoreCell.h"

@interface ToStoreCell ()

@property (nonatomic, strong) UIButton *chooseBtn;

@end

@implementation ToStoreCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self layoutSubviewCell];
    }
    return  self;
}

+(instancetype)returnReuseCellFormTableView:(UITableView *)tableView
                                  indexPath:(NSIndexPath *)indexPath
                                 identifier:(NSString *)identifierString
{
    ToStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierString forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = BackCellColor;

    return cell;
}

- (void)layoutSubviewCell
{
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(@(10));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
    }];
    
    UILabel *shopnamelabel = [UILabel new];
    shopnamelabel.text = @"cherrykoko 南山店";
    shopnamelabel.font = [UIFont systemFontOfSize:12*rating];
    shopnamelabel.textColor = FirstTextColor;
    [bottomView addSubview:shopnamelabel];
    [shopnamelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12));
        make.right.equalTo(@(-12));
        make.top.equalTo(@(6*rating));
    }];

    UIView *lineView = [UIView new];
    lineView.backgroundColor = BackCellColor;
    [bottomView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shopnamelabel.mas_left);
        make.right.equalTo(shopnamelabel.mas_right);
        make.top.equalTo(shopnamelabel.mas_bottom).with.offset(6*rating);
        make.height.equalTo(@(1));
    }];
    
    UIImageView *shopImg = [UIImageView new];
    shopImg.backgroundColor = DefaultImgBgColor;
    [shopImg handleCornerRadiusWithRadius:25*rating];
    [bottomView addSubview:shopImg];
    [shopImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shopnamelabel.mas_left);
        make.top.equalTo(lineView.mas_bottom).with.offset(10*rating);
        make.width.and.height.equalTo(@(50*rating));
    }];
    
    UIButton *contactBtn = [UIButton new];
    [contactBtn setTitle:@"联系" forState:UIControlStateNormal];
    [contactBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    contactBtn.titleLabel.font = [UIFont systemFontOfSize:12*rating];
    contactBtn.backgroundColor = ThemeColor;
    contactBtn.layer.cornerRadius = 2;
    contactBtn.tag = 1;
    [contactBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:contactBtn];
    [contactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(shopnamelabel.mas_right);
        make.top.equalTo(lineView.mas_bottom).with.offset(10*rating);
        make.width.equalTo(@(60*rating));
        make.height.equalTo(@(22*rating));
    }];
    
    UIButton *chooseBtn = [UIButton new];
    [chooseBtn setTitle:@"选择" forState:UIControlStateNormal];
    [chooseBtn setTitle:@"已选择" forState:UIControlStateSelected];
    [chooseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    chooseBtn.titleLabel.font = [UIFont systemFontOfSize:12*rating];
    chooseBtn.backgroundColor = ThemeColor;
    chooseBtn.layer.cornerRadius = 2;
    chooseBtn.tag = 2;
    [chooseBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:chooseBtn];
    [chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contactBtn.mas_right);
        make.top.equalTo(contactBtn.mas_bottom).with.offset(5*rating);
        make.width.equalTo(@(60*rating));
        make.height.equalTo(@(22*rating));
    }];
    _chooseBtn = chooseBtn;
    
    UILabel *shopServiceLb = [UILabel new];
    shopServiceLb.text = @"南山店客服";
    shopServiceLb.font = [UIFont systemFontOfSize:14*rating];
    shopServiceLb.textColor = FirstTextColor;
    [bottomView addSubview:shopServiceLb];
    [shopServiceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(contactBtn);
        make.left.equalTo(shopImg.mas_right).with.offset(9*rating);
        make.right.equalTo(contactBtn.mas_left).with.offset(5*rating);
    }];
    
    UILabel *customerCountLb = [UILabel new];
    customerCountLb.text = @"接客2323人";
    customerCountLb.font = [UIFont systemFontOfSize:11*rating];
    customerCountLb.textColor = [UIColor colorWithHex:0x999999];
    [bottomView addSubview:customerCountLb];
    [customerCountLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shopServiceLb.mas_bottom).with.offset(10*rating);
        make.left.equalTo(shopServiceLb.mas_left);
        make.right.equalTo(shopServiceLb.mas_right);
    }];
    
    UIView *addressView = [UIView new];
    addressView.backgroundColor = [UIColor colorWithHex:0xf9f9f9];
    [bottomView addSubview:addressView];
    [addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shopImg.mas_bottom).with.offset(10*rating);
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
        make.height.equalTo(@(25*rating));
    }];
    
    UILabel *addressLb = [UILabel new];
    addressLb.textColor = [UIColor colorWithHex:0x999999];
    addressLb.text = @"店铺地址：广东省深圳市南山区海岸城A栋0202";
    addressLb.font = [UIFont systemFontOfSize:11*rating];
    [addressView addSubview:addressLb];
    [addressLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addressView.mas_left).with.offset(12);
        make.centerY.equalTo(addressView);
        make.right.equalTo(addressView.mas_right).with.offset(-12);
    }];
}

#pragma mark - action

- (void)buttonAction:(UIButton *)button
{
    if (button.tag == 1) {
        if (_delegate && [_delegate respondsToSelector:@selector(contactForToStoreCell:)]) {
            [_delegate contactForToStoreCell:self];
        }
    } else if (button.tag == 2) {
        if (_delegate && [_delegate respondsToSelector:@selector(chooseForToStoreCell:)]) {
            [_delegate chooseForToStoreCell:self];
        }
    }
}

- (void)setIsChoose:(BOOL)isChoose
{
    _chooseBtn.selected = isChoose;
}

@end
