//
//  SalesExchangeCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/9.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "SalesExchangeCell.h"

@implementation SalesExchangeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self layoutSubviewCell];
    }
    return self;
}


+ (instancetype)returnReuseCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifierString
{
    SalesExchangeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierString forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)layoutSubviewCell//myOrder_logistics
{
    UIImageView *iconImg = [UIImageView new];
    iconImg.image = [UIImage imageNamed:@"ico_salesExchange"];
    iconImg.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:iconImg];
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12));
        make.centerY.equalTo(self);
        make.width.and.height.equalTo(@(23*rating));
    }];
    
    UILabel *tagLb = [UILabel new];
    tagLb.text = @"换货";
    tagLb.textColor = FirstTextColor;
    tagLb.font = [UIFont systemFontOfSize:13*rating];
    [self.contentView addSubview:tagLb];
    [tagLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImg.mas_right).with.offset(16*rating);
        make.top.equalTo(@(13*rating));
    }];
    
    UILabel *infoLb = [UILabel new];
    infoLb.attributedText = [Util changeAttributedStrWithfrontStr:@"已确认收货，因产品问题或特殊原因需要进行换货，优选联系卖家客服。或拨打卖家电话 " withBehindStr:@"13896279120" withFrontColor:IconTextColor withBehindColor:[UIColor colorWithHex:0x206fa7]];
    infoLb.font = [UIFont systemFontOfSize:11*rating];
    infoLb.numberOfLines = 0;

    infoLb.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:infoLb];
    [infoLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tagLb.mas_left);
        make.top.equalTo(tagLb.mas_bottom).with.offset(13*rating);
        make.right.equalTo(@(-12));
    }];
}

@end
