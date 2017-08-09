//
//  SalesReturnCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/9.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "SalesReturnCell.h"

@implementation SalesReturnCell

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
    SalesReturnCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierString forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    return cell;
}

-(void)layoutSubviewCell//myOrder_logistics
{
    UIImageView *iconImg = [UIImageView new];
    iconImg.image = [UIImage imageNamed:@"ico_salesReturn"];
    [self.contentView addSubview:iconImg];
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12));
        make.centerY.equalTo(self);
        make.width.and.height.equalTo(@(23*rating));
    }];
    
    UILabel *tagLb = [UILabel new];
    tagLb.text = @"退货退款";
    tagLb.textColor = FirstTextColor;
    tagLb.font = [UIFont systemFontOfSize:13*rating];
    [self.contentView addSubview:tagLb];
    [tagLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImg.mas_right).with.offset(16*rating);
        make.top.equalTo(@(13*rating));
    }];
    
    UILabel *infoLb = [UILabel new];
    infoLb.text = @"未确认货物，需要对目前的货物进行退款";
    infoLb.textColor = IconTextColor;
    infoLb.font = [UIFont systemFontOfSize:11*rating];
    [self.contentView addSubview:infoLb];
    [infoLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tagLb.mas_left);
        make.top.equalTo(tagLb.mas_bottom).with.offset(13*rating);
    }];
    
    UIImageView *pushImg = [UIImageView new];
    pushImg.image = [UIImage imageNamed:@"ico_push"];
    [self.contentView addSubview:pushImg];
    [pushImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-12));
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(@(6*rating));
        make.height.equalTo(@(12*rating));
    }];
}

@end
