//
//  OpenShopsTypeCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/6.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "OpenShopsTypeCell.h"

#define rating kScreen_Width/375

@interface OpenShopsTypeCell ()

@property (nonatomic, strong) UILabel *titleLb;


@end

@implementation OpenShopsTypeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self layoutSubviewCell];
    }
    return self;
}


+(instancetype)returnReuseCellFormTableView:(UITableView *)tableView
                                  indexPath:(NSIndexPath *)indexPath
                                 identifier:(NSString *)identifierString
{
    OpenShopsTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierString forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

-(void)layoutSubviewCell
{
    UILabel *titleLb = [UILabel new];
    titleLb.text = @"女装";
    titleLb.textColor = [UIColor colorWithHex:0x4f4f4f];
    titleLb.font = [UIFont systemFontOfSize:15*rating];
    [self.contentView addSubview:titleLb];
    _titleLb = titleLb;
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(30*rating));
        make.centerY.equalTo(self.contentView);
    }];
    
    UIButton *button = [UIButton new];
    [button setImage:[UIImage imageNamed:@"goods_unChoose"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"ico_address"] forState:UIControlStateSelected];
    button.userInteractionEnabled=NO;
    [self.contentView addSubview:button];
 
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(@(22*rating));
        make.centerY.equalTo(titleLb);
        make.left.equalTo(titleLb.mas_right).with.offset(10*rating);
        make.right.equalTo(@(-33*rating));
    }];
    _button=button;
}

#pragma mark - set

- (void)setTitle:(NSString *)title
{
    _titleLb.text = title;
}

@end
