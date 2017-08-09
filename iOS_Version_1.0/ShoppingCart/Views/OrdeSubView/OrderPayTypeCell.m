//
//  OrderPayTypeCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/6.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "OrderPayTypeCell.h"

@interface OrderPayTypeCell () <UITextFieldDelegate>

@property (nonatomic, strong) UIButton *wechatSelBtn;
@property (nonatomic, strong) UIButton *alipaySelBtn;
@property (nonatomic, strong) UITextField *creditTextField;

@end

@implementation OrderPayTypeCell

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
    OrderPayTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierString forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

- (void)layoutSubviewCell
{
    UIView *subView1 = [UIView new];
    [self.contentView addSubview:subView1];
    [subView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(@(0));
        make.right.equalTo(@(0));
        make.height.equalTo(@(24*rating));
    }];
    
    UILabel *taglabel = [UILabel new];
    taglabel.text = @"付款方式：";
    taglabel.font = [UIFont systemFontOfSize:11*rating];
    taglabel.textColor = [UIColor colorWithHex:0x323131];
    [subView1 addSubview:taglabel];
    [taglabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(subView1);
        make.left.equalTo(@(12));
    }];
    
    UILabel *line1 = [UILabel new];
    line1.backgroundColor = BackCellColor;
    [subView1 addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12));
        make.right.equalTo(@(-12));
        make.height.equalTo(@(1));
        make.bottom.equalTo(subView1.mas_bottom);
    }];
    
    ////////
    UIView *subView2 = [UIView new];
    [self.contentView addSubview:subView2];
    [subView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(subView1.mas_bottom);
        make.right.equalTo(@(0));
        make.height.equalTo(@(52*rating));
    }];
    
    UIImageView *wechatIcon = [UIImageView new];
    wechatIcon.image = [UIImage imageNamed:@"ico_wechat"];
    [subView2 addSubview:wechatIcon];
    [wechatIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12));
        make.centerY.equalTo(subView2);
        make.width.equalTo(@(20*rating));
        make.height.equalTo(@(18*rating));
    }];
    
    UILabel *wechatTagLb = [UILabel new];
    wechatTagLb.text = @"微信支付";
    wechatTagLb.font = [UIFont systemFontOfSize:12*rating];
    wechatTagLb.textColor = [UIColor colorWithHex:0x3f3f3f];
    [subView2 addSubview:wechatTagLb];
    [wechatTagLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(subView2);
        make.left.equalTo(wechatIcon.mas_right).with.offset(10*rating);
        make.width.equalTo(@(52*rating));
    }];
    
    UILabel *wechatInfoLb = [UILabel new];
    wechatInfoLb.text = @"推荐安装微信5.0及以上版本的用户使用";
    wechatInfoLb.font = [UIFont systemFontOfSize:10*rating];
    wechatInfoLb.textColor = IconTextColor;
    [subView2 addSubview:wechatInfoLb];
    [wechatInfoLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(subView2);
        make.left.equalTo(wechatTagLb.mas_right).with.offset(15*rating);
    }];
    
    UIButton *wechatbutton = [UIButton new];
    wechatbutton.selected = YES;
    [wechatbutton setImage:[UIImage imageNamed:@"goods_unChoose"] forState:UIControlStateNormal];
    [wechatbutton setImage:[UIImage imageNamed:@"ico_address"] forState:UIControlStateSelected];
    [wechatbutton addTarget:self action:@selector(selectedPayAction:) forControlEvents:UIControlEventTouchUpInside];
    [subView2 addSubview:wechatbutton];
    [wechatbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wechatInfoLb.mas_right).with.offset(10*rating);
        make.right.equalTo(@(-12));
        make.centerY.equalTo(subView2);
        make.width.equalTo(@(22*rating));
        make.height.equalTo(@(22*rating));
    }];
    _wechatSelBtn = wechatbutton;
    
    ////////
    UIView *subView3 = [UIView new];
    [self.contentView addSubview:subView3];
    [subView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(subView2.mas_bottom);
        make.right.equalTo(@(0));
        make.height.equalTo(@(44*rating));
    }];
    
    UILabel *line3 = [UILabel new];
    line3.backgroundColor = BackCellColor;
    [subView3 addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.height.equalTo(@(1));
        make.bottom.equalTo(subView3.mas_bottom);
    }];
    
    UIImageView *alipayIcon = [UIImageView new];
    alipayIcon.image = [UIImage imageNamed:@"ico_alipay"];
    [subView3 addSubview:alipayIcon];
    [alipayIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12));
        make.centerY.equalTo(subView3);
        make.width.equalTo(@(20*rating));
        make.height.equalTo(@(15*rating));
    }];
    
    UILabel *alipayTagLb = [UILabel new];
    alipayTagLb.text = @"支付宝支付";
    alipayTagLb.font = [UIFont systemFontOfSize:12*rating];
    alipayTagLb.textColor = [UIColor colorWithHex:0x3f3f3f];
    [subView3 addSubview:alipayTagLb];
    [alipayTagLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(subView3);
        make.left.equalTo(alipayIcon.mas_right).with.offset(10*rating);
        make.width.equalTo(@(62*rating));
    }];
    
    UILabel *alipayInfoLb = [UILabel new];
    alipayInfoLb.text = @"推荐有支付宝账户的用户使用";
    alipayInfoLb.font = [UIFont systemFontOfSize:10*rating];
    alipayInfoLb.textColor = IconTextColor;
    [subView3 addSubview:alipayInfoLb];
    [alipayInfoLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(subView3);
        make.left.equalTo(alipayTagLb.mas_right).with.offset(15*rating);
    }];
    
    UIButton *button = [UIButton new];
    [button setImage:[UIImage imageNamed:@"goods_unChoose"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"ico_address"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(selectedPayAction:) forControlEvents:UIControlEventTouchUpInside];
    [subView3 addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(alipayInfoLb.mas_right).with.offset(10*rating);
        make.right.equalTo(@(-12));
        make.centerY.equalTo(subView3);
        make.width.equalTo(@(22*rating));
        make.height.equalTo(@(22*rating));
    }];
    _alipaySelBtn = button;
    
    ////////
    UIView *subView4 = [UIView new];
    [self.contentView addSubview:subView4];
    [subView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(subView3.mas_bottom);
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
    }];
    
    UILabel *orderDetailTagLb = [UILabel new];
    orderDetailTagLb.text = @"使用积分";
    orderDetailTagLb.font = [UIFont systemFontOfSize:12*rating];
    orderDetailTagLb.textColor = SecondTextColor;
    [subView4 addSubview:orderDetailTagLb];
    [orderDetailTagLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(subView4);
        make.left.equalTo(@(12));
        make.width.equalTo(@(50*rating));
    }];
    
    UILabel *credirsLb = [UILabel new];
    credirsLb.text = @"（剩余200积分）";
    credirsLb.font = [UIFont systemFontOfSize:10*rating];
    credirsLb.textColor = IconTextColor;
    [subView4 addSubview:credirsLb];
    [credirsLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(orderDetailTagLb);
        make.left.equalTo(orderDetailTagLb.mas_right);
        make.width.equalTo(@(100*rating));
    }];
    
    UILabel *credirsUseInfoLb = [UILabel new];
    credirsUseInfoLb.text = @"（抵消0元）";
    credirsUseInfoLb.font = [UIFont systemFontOfSize:10*rating];
    credirsUseInfoLb.textColor = ThemeColor;
    [subView4 addSubview:credirsUseInfoLb];
    [credirsUseInfoLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(orderDetailTagLb);
        make.right.equalTo(subView4.mas_right).with.offset(-8*rating);
    }];
    
    UITextField *creditTextField = [UITextField new];
    creditTextField.placeholder = @"请填写使用积分数";
    creditTextField.font = [UIFont systemFontOfSize:12*rating];
    creditTextField.textColor = IconTextColor;
    creditTextField.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
    [subView4 addSubview:creditTextField];
    creditTextField.delegate = self;
    _creditTextField = creditTextField;
    
    [creditTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(orderDetailTagLb);
        make.right.equalTo(credirsUseInfoLb.mas_left);
    }];
}

#pragma mark - button
- (void)selectedPayAction:(UIButton *)button
{
    PayTypes type = GoodsPayTypesWithWeChat;
    if (button == _wechatSelBtn) {
        _wechatSelBtn.selected = YES;
        _alipaySelBtn.selected = NO;
        type = GoodsPayTypesWithWeChat;
    } else if (button == _alipaySelBtn) {
        _wechatSelBtn.selected = NO;
        _alipaySelBtn.selected = YES;
        type = GoodsPayTypesWithAlipay;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(payChoosePayTypeActionDelegate:withPayType:)]) {
        [_delegate payChoosePayTypeActionDelegate:self withPayType:type];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    UIWindow* keyWindow = [UIApplication sharedApplication].keyWindow;
    CGRect rect = [_creditTextField convertRect: _creditTextField.bounds toView:keyWindow];
    CGFloat windowPoint = CGRectGetMaxY(rect);
    
    if (_delegate && [_delegate respondsToSelector:@selector(payChooseEditActionDelegate:withTextfieldMaxY:)]) {
        [_delegate payChooseEditActionDelegate:self withTextfieldMaxY:windowPoint];
    }
    
    return YES;
}


@end
