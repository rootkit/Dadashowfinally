//
//  OrderAdressCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/4.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "OrderAdressCell.h"

@interface OrderAdressCell ()

@property (strong, nonatomic) UILabel *buyerNameLb;
@property (strong, nonatomic) UILabel *buyerPhomeNumLb;
@property (strong, nonatomic) UILabel *buyerAddressLb;

@property (nonatomic, strong) UIView *addressView;
@property (nonatomic, strong) UIView *noneAddressView;

@end

@implementation OrderAdressCell

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
    OrderAdressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierString forIndexPath:indexPath];
    
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
        make.top.equalTo(@(0));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
    }];
    
    UIImageView *iconImg = [UIImageView new];
    iconImg.image = [UIImage imageNamed:@"location"];
    [bottomView addSubview:iconImg];
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(8));
        make.centerY.equalTo(bottomView);
        make.width.equalTo(@(23*rating));
        make.height.equalTo(@(23*rating));
    }];
    
    UIImageView *pushImg = [UIImageView new];
    pushImg.image = [UIImage imageNamed:@"ico_push"];
    [bottomView addSubview:pushImg];
    [pushImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-12));
        make.centerY.equalTo(bottomView);
        make.width.equalTo(@(6*rating));
        make.height.equalTo(@(12*rating));
    }];
    
    //////
    UIView *addressView = [UIView new];
    [bottomView addSubview:addressView];
    [addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImg.mas_right).with.offset(0);
        make.top.equalTo(@(0));
        make.right.equalTo(pushImg.mas_left).with.offset(-10*rating);
        make.bottom.equalTo(@(0));
    }];
    
    UILabel *buyerAddressTagLb = [UILabel new];
    buyerAddressTagLb.textColor = InfoTextColor;
    buyerAddressTagLb.text = @"收货地址：";
    buyerAddressTagLb.font = [UIFont systemFontOfSize:12*rating];
    [addressView addSubview:buyerAddressTagLb];
    [buyerAddressTagLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addressView.mas_left);
        make.centerY.equalTo(addressView);
        make.width.equalTo(@(64*rating));
    }];
    
    UILabel *buyerAddressLb = [UILabel new];
    buyerAddressLb.textColor = InfoTextColor;
    buyerAddressLb.text = @"广东省 深圳市 南山区 粤海街道 科兴科技园 A4栋 401";
    buyerAddressLb.font = [UIFont systemFontOfSize:12*rating];
    buyerAddressLb.numberOfLines = 2;
    buyerAddressLb.lineBreakMode = NSLineBreakByWordWrapping;
    [addressView addSubview:buyerAddressLb];
    [buyerAddressLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(buyerAddressTagLb.mas_right);
        make.top.equalTo(buyerAddressTagLb.mas_top);
        make.right.equalTo(addressView.mas_right).with.offset(-10*rating);
    }];

    
    UILabel *buyerPhomeNumLb = [UILabel new];
    buyerPhomeNumLb.textColor = InfoTextColor;
    buyerPhomeNumLb.text = @"13211133122";
    buyerPhomeNumLb.textAlignment = NSTextAlignmentRight;
    buyerPhomeNumLb.font = [UIFont systemFontOfSize:14*rating];
    [addressView addSubview:buyerPhomeNumLb];
    [buyerPhomeNumLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(buyerAddressLb.mas_top).with.offset(-7*rating);
        make.right.equalTo(addressView.mas_right);
    }];
    
    UILabel *buyerNameTagLb = [UILabel new];
    buyerNameTagLb.textColor = InfoTextColor;
    buyerNameTagLb.text = @"收货人  ：";
    buyerNameTagLb.font = [UIFont systemFontOfSize:12*rating];
    [addressView addSubview:buyerNameTagLb];
    [buyerNameTagLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addressView.mas_left);
        make.centerY.equalTo(buyerPhomeNumLb);
        make.width.equalTo(@(64*rating));
        make.bottom.equalTo(buyerAddressTagLb.mas_top).with.offset(-7*rating);
    }];
    
    UILabel *buyerNameLb = [UILabel new];
    buyerNameLb.textColor = InfoTextColor;
    buyerNameLb.text = @"全凯";
    buyerNameLb.font = [UIFont systemFontOfSize:12*rating];
    [addressView addSubview:buyerNameLb];
    [buyerNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(buyerNameTagLb.mas_right);
        make.centerY.equalTo(buyerPhomeNumLb);
        make.right.equalTo(buyerPhomeNumLb.mas_left).with.offset(-13*rating);
    }];
    
    _buyerNameLb = buyerNameLb;
    _buyerPhomeNumLb = buyerPhomeNumLb;
    _buyerAddressLb = buyerAddressLb;
    
    /////
    
    //////
    UIView *noneAddressView = [UIView new];
    [bottomView addSubview:noneAddressView];
    [noneAddressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImg.mas_right).with.offset(0);
        make.top.equalTo(@(0));
        make.right.equalTo(pushImg.mas_left).with.offset(-10*rating);
        make.bottom.equalTo(@(0));
    }];
    
    UILabel *noneInfoLb = [UILabel new];
    noneInfoLb.textColor = FirstTextColor;
    noneInfoLb.text = @"请填写收货地址";
    noneInfoLb.font = [UIFont systemFontOfSize:14*rating];
    [noneAddressView addSubview:noneInfoLb];
    [noneInfoLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addressView.mas_left);
        make.centerY.equalTo(noneAddressView);
        make.right.equalTo(addressView.mas_right);
    }];
    
    _addressView = addressView;
    _noneAddressView = noneAddressView;
}

- (void)setConsignee:(DDXConsignee *)consignee
{
    if (consignee.consignee.length) {
        _addressView.hidden = NO;
        _noneAddressView.hidden = YES;
        
        _buyerNameLb.text = consignee.consignee;
        _buyerPhomeNumLb.text = consignee.mobile;
        
        NSString *addressStr = [NSString stringWithFormat:@"%@ %@ %@ %@",
                                consignee.province.length ? consignee.province : @"",
                                consignee.city.length ? consignee.city : @"",
                                consignee.district.length ? consignee.district : @"",
                                consignee.address.length ? consignee.address : @""];
        
        _buyerAddressLb.text = addressStr;
        
    } else {
        _addressView.hidden = YES;
        _noneAddressView.hidden = NO;
    }
}

@end
