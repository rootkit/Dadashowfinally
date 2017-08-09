//
//  OrderPostageCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/4.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "OrderPostageCell.h"

@interface OrderPostageCell () <UITextFieldDelegate>

@property (strong, nonatomic) UILabel *postagePriceLb;
@property (strong, nonatomic) UILabel *goodsPriceLb;
@property (strong, nonatomic) UIButton *postageStateBtn;

@property (nonatomic, strong) UIView *inviteView;
@property (nonatomic, strong) UIView *expressView;
@property (strong, nonatomic) UILabel *postageTypeLb;

@end

@implementation OrderPostageCell
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
    OrderPostageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierString forIndexPath:indexPath];
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
    taglabel.text = @"配送方式";
    taglabel.font = [UIFont systemFontOfSize:11*rating];
    taglabel.textColor = [UIColor colorWithHex:0x323131];
    [subView1 addSubview:taglabel];
    [taglabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(subView1);
        make.left.equalTo(@(12));
    }];
    
    UIButton *button = [UIButton new];
    [subView1 addSubview:button];
    subView1.userInteractionEnabled = YES;
    [button addTarget:self action:@selector(postageStateAction:) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
        make.width.equalTo(@(100));
    }];
    
    UIImageView *pushImg = [UIImageView new];
    pushImg.image = [UIImage imageNamed:@"ico_push"];
    [button addSubview:pushImg];
    [pushImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(button.mas_right).with.offset(-12);
        make.centerY.equalTo(button);
        make.width.equalTo(@(6*rating));
        make.height.equalTo(@(12*rating));
    }];
    
    UILabel *postageTypeLb = [UILabel new];
    postageTypeLb.text = @"快递";
    postageTypeLb.font = [UIFont systemFontOfSize:11*rating];
    postageTypeLb.textColor = [UIColor colorWithHex:0x323131];
    [button addSubview:postageTypeLb];
    [postageTypeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(button);
        make.right.equalTo(pushImg.mas_left).with.offset(-7*rating);
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
    UIView *subView2 = [UIView new]; //选择到店自取时View
    [self.contentView addSubview:subView2];
    [subView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(subView1.mas_bottom);
        make.right.equalTo(@(0));
        make.height.equalTo(@(52*rating));
    }];
    
    UILabel *line2 = [UILabel new];
    line2.backgroundColor = BackCellColor;
    [subView2 addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.height.equalTo(@(1));
        make.bottom.equalTo(subView2.mas_bottom);
    }];
    
    UIButton *button2 = [UIButton new];
    [subView2 addSubview:button2];
    subView2.userInteractionEnabled = YES;
    [button2 addTarget:self action:@selector(postageChooseShopAddressAction) forControlEvents:UIControlEventTouchUpInside];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
        make.width.equalTo(@(55));
    }];
    
    UIImageView *pushImg2 = [UIImageView new];
    pushImg2.image = [UIImage imageNamed:@"ico_push"];
    [button2 addSubview:pushImg2];
    [pushImg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(button2.mas_right).with.offset(-12);
        make.centerY.equalTo(button2);
        make.width.equalTo(@(6*rating));
        make.height.equalTo(@(12*rating));
    }];
    
    UILabel *postageTypeLb2 = [UILabel new];
    postageTypeLb2.text = @"已选择";
    postageTypeLb2.font = [UIFont systemFontOfSize:10*rating];
    postageTypeLb2.textColor = [UIColor colorWithHex:0x666666];
    [button2 addSubview:postageTypeLb2];
    [postageTypeLb2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(button2);
        make.right.equalTo(pushImg.mas_left).with.offset(-7*rating);
    }];
    
    UILabel *shopNameLb = [UILabel new];
    shopNameLb.text = @"cherrykoko 南山店";
    shopNameLb.font = [UIFont systemFontOfSize:12*rating];
    shopNameLb.textColor = [UIColor colorWithHex:0x323131];
    [subView2 addSubview:shopNameLb];
    [shopNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12));
        make.top.equalTo(@(10*rating));
        make.right.equalTo(button2.mas_left).with.offset(-7*rating);
    }];
    
    UILabel *shopAddressLb = [UILabel new];
    shopAddressLb.text = @"店铺地址：广东省深圳市南山区海岸城A栋0202";
    shopAddressLb.font = [UIFont systemFontOfSize:11*rating];
    shopAddressLb.textColor = [UIColor colorWithHex:0x666666];
    [subView2 addSubview:shopAddressLb];
    [shopAddressLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12));
        make.top.equalTo(shopNameLb.mas_bottom).with.offset(6*rating);
        make.right.equalTo(button2.mas_left).with.offset(-7*rating);
    }];
    
    ////////
    
    UIView *postagePriceView = [UIView new]; //选择快递邮寄时View
    [self.contentView addSubview:postagePriceView];
    [postagePriceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(subView1.mas_bottom);
        make.right.equalTo(@(0));
        make.height.equalTo(@(52*rating));
    }];
    
    UILabel *postagePriceline = [UILabel new];
    postagePriceline.backgroundColor = BackCellColor;
    [postagePriceView addSubview:postagePriceline];
    [postagePriceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.height.equalTo(@(1));
        make.bottom.equalTo(postagePriceView.mas_bottom);
    }];
    
    UILabel *postagePriceTagLb = [UILabel new];
    postagePriceTagLb.text = @"快递费用";
    postagePriceTagLb.font = [UIFont systemFontOfSize:12*rating];
    postagePriceTagLb.textColor = [UIColor colorWithHex:0x323131];
    [postagePriceView addSubview:postagePriceTagLb];
    [postagePriceTagLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(postagePriceView);
        make.left.equalTo(@(12));
        make.width.equalTo(@(65*rating));
    }];
    
    UILabel *postagePriceLb = [UILabel new];
    postagePriceLb.text = @"¥0.0";
    postagePriceLb.textAlignment = NSTextAlignmentRight;
    postagePriceLb.font = [UIFont systemFontOfSize:14*rating];
    postagePriceLb.textColor = FirstTextColor;
    [postagePriceView addSubview:postagePriceLb];
    [postagePriceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(postagePriceView);
        make.left.equalTo(postagePriceTagLb.mas_right).with.offset(10*rating);
        make.right.equalTo(@(-12));
    }];
    
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
    
    UILabel *priceTagLb = [UILabel new];
    priceTagLb.text = @"价格合计：";
    priceTagLb.font = [UIFont systemFontOfSize:12*rating];
    priceTagLb.textColor = SecondTextColor;
    [subView3 addSubview:priceTagLb];
    [priceTagLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(subView3);
        make.left.equalTo(@(12));
        make.width.equalTo(@(65*rating));
    }];
    
    UILabel *priceLb = [UILabel new];
    priceLb.text = @"¥169.40";
    priceLb.textAlignment = NSTextAlignmentRight;
    priceLb.font = [UIFont systemFontOfSize:14*rating];
    priceLb.textColor = ThemeColor;
    [subView3 addSubview:priceLb];
    [priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(subView3);
        make.left.equalTo(priceTagLb.mas_right).with.offset(10*rating);
        make.right.equalTo(@(-12));
    }];
    
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
    orderDetailTagLb.text = @"订单补充说明：";
    orderDetailTagLb.font = [UIFont systemFontOfSize:12*rating];
    orderDetailTagLb.textColor = SecondTextColor;
    [subView4 addSubview:orderDetailTagLb];
    [orderDetailTagLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(subView4);
        make.left.equalTo(@(12));
        make.width.equalTo(@(90*rating));
    }];
    
    UITextField *goodsDetailTF = [UITextField new];
    goodsDetailTF.font = [UIFont systemFontOfSize:11*rating];
    goodsDetailTF.placeholder = @"选填：对本次交易的说明(建议填写已与卖家商量好的)";
    goodsDetailTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    goodsDetailTF.clearsOnBeginEditing = YES;
    [subView4 addSubview:goodsDetailTF];
    goodsDetailTF.delegate = self;
    [goodsDetailTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(subView4);
        make.left.equalTo(orderDetailTagLb.mas_right).with.offset(5*rating);
        make.right.equalTo(@(-12));
    }];
    
    _postageTypeLb = postageTypeLb;
    _inviteView = subView2;
    _expressView = postagePriceView;
    _goodsPriceLb = priceLb;
    
    subView2.hidden = YES;
    postagePriceView.hidden = NO;
}

- (void)setPostageWayChangeForHelpSelf:(BOOL)isSelf
{
    _inviteView.hidden = !isSelf;
    _expressView.hidden = isSelf;
    _postageTypeLb.text = isSelf ? @"到店自提" : @"快递";
}

- (void)setPrice:(float)price
{
    self.goodsPriceLb.text = [NSString stringWithFormat:@"¥%.2f", price];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    UIWindow* keyWindow = [UIApplication sharedApplication].keyWindow;
    CGRect rect = [textField convertRect: textField.bounds toView:keyWindow];
    CGFloat windowPoint = CGRectGetMaxY(rect);
    
    if (_delegate && [_delegate respondsToSelector:@selector(postageChooseEditOrderDetailInfoActionDelegate:withTextfieldMaxY:)]) {
        [_delegate postageChooseEditOrderDetailInfoActionDelegate:self withTextfieldMaxY:windowPoint];
    }
    
    return YES;
}

#pragma mark - 邮寄类型
- (void)postageStateAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(postageStateActionDelegate:)]) {
        [_delegate postageStateActionDelegate:self];
    }
}

- (void)postageChooseShopAddressAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(postageChooseShopAddressActionDelegate:)]) {
        [_delegate postageChooseShopAddressActionDelegate:self];
    }
}

@end
