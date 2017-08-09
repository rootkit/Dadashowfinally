//
//  OrderLogisticsDetailHeadView.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/9.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "OrderLogisticsDetailHeadView.h"

@implementation OrderLogisticsDetailHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self drawSubviews];
    }
    return self;
}

//+(instancetype)returnReuseCellFormTableView:(UITableView *)tableView
//                                 identifier:(NSString *)identifierString
//{
//    OrderLogisticsDetailHeadView *headview = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifierString];
//    
//    [headview drawSubviews];
//    
//    return headview;
//}

- (void)drawSubviews
{
    UIImageView *goodsImg = [UIImageView new];
    goodsImg.backgroundColor = DefaultImgBgColor;
    [goodsImg handleCornerRadiusWithRadius:2];
    [self addSubview:goodsImg];
    [goodsImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12));
        make.width.and.height.equalTo(@(58*rating));
        make.centerY.equalTo(self);
    }];
    
    ////
    UILabel *stateTagLb = [UILabel new];
    stateTagLb.text = @"物流状态";
    stateTagLb.textColor = InfoTextColor;
    stateTagLb.font = [UIFont systemFontOfSize:12*rating];
    [self addSubview:stateTagLb];
    [stateTagLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(10*rating));
        make.left.equalTo(goodsImg.mas_right).with.offset(19*rating);
        make.width.equalTo(@(55*rating));
    }];
    
    UILabel *stateLb = [UILabel new];
    stateLb.text = @"发货中";
    stateLb.textColor = [UIColor colorWithHex:0x74e5e9];
    stateLb.font = [UIFont systemFontOfSize:12*rating];
    [self addSubview:stateLb];
    [stateLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(stateTagLb.mas_right).with.offset(5*rating);
        make.centerY.equalTo(stateTagLb);
        make.right.equalTo(@(-12));
    }];
    
    ////
    UILabel *logisTagLb = [UILabel new];
    logisTagLb.text = @"承运对象:";
    logisTagLb.textColor = [UIColor colorWithHex:0xbfbfbf];
    logisTagLb.font = [UIFont systemFontOfSize:11*rating];
    [self addSubview:logisTagLb];
    [logisTagLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(stateTagLb.mas_bottom).with.offset(6*rating);
        make.left.equalTo(stateTagLb.mas_left);
        make.right.equalTo(stateTagLb.mas_right);
    }];
    
    UILabel *logisLb = [UILabel new];
    logisLb.text = @"中通快递";
    logisLb.textColor = [UIColor colorWithHex:0xbfbfbf];
    logisLb.font = [UIFont systemFontOfSize:11*rating];
    [self addSubview:logisLb];
    [logisLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(stateLb.mas_left);
        make.centerY.equalTo(logisTagLb);
        make.right.equalTo(stateLb.mas_right);
    }];
    
    ////
    UILabel *wayNumbTagLb = [UILabel new];
    wayNumbTagLb.text = @"运单编号:";
    wayNumbTagLb.textColor = [UIColor colorWithHex:0xbfbfbf];
    wayNumbTagLb.font = [UIFont systemFontOfSize:11*rating];
    [self addSubview:wayNumbTagLb];
    [wayNumbTagLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logisTagLb.mas_bottom).with.offset(6*rating);
        make.left.equalTo(stateTagLb.mas_left);
        make.right.equalTo(stateTagLb.mas_right);
    }];
    
    UILabel *wayNumbLb = [UILabel new];
    wayNumbLb.text = @"438823859610";
    wayNumbLb.textColor = [UIColor colorWithHex:0xbfbfbf];
    wayNumbLb.font = [UIFont systemFontOfSize:11*rating];
    [self addSubview:wayNumbLb];
    [wayNumbLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(stateLb.mas_left);
        make.centerY.equalTo(wayNumbTagLb);
        make.right.equalTo(stateLb.mas_right);
    }];
    
    ////
    UILabel *officePhoneTagLb = [UILabel new];
    officePhoneTagLb.text = @"官方电话:";
    officePhoneTagLb.textColor = [UIColor colorWithHex:0xbfbfbf];
    officePhoneTagLb.font = [UIFont systemFontOfSize:11*rating];
    [self addSubview:officePhoneTagLb];
    [officePhoneTagLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wayNumbTagLb.mas_bottom).with.offset(6*rating);
        make.left.equalTo(stateTagLb.mas_left);
        make.right.equalTo(stateTagLb.mas_right);
    }];
    
    UILabel *officePhoneLb = [UILabel new];
    officePhoneLb.text = @"暂无";
    officePhoneLb.textColor = [UIColor colorWithHex:0xbfbfbf];
    officePhoneLb.font = [UIFont systemFontOfSize:11*rating];
    [self addSubview:officePhoneLb];
    [officePhoneLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(stateLb.mas_left);
        make.centerY.equalTo(officePhoneTagLb);
        make.right.equalTo(stateLb.mas_right);
    }];
    
}
@end
