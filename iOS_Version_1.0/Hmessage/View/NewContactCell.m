//
//  NewContactCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/17.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "NewContactCell.h"

#define cell_left_padding 12
#define cell_right_padding cell_left_padding
#define cell_top_padding 10
#define cell_bottom_padding cell_top_padding

#define icon_W_H 34
#define icon_name_padding 13
#define btn_Width 45
#define btn_Height 27

@interface NewContactCell ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *infoLabel;

@end

@implementation NewContactCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setCell];
    }
    return  self;
}

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier
{
    NewContactCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)setCell
{
    _icon = [UIImageView new];
    _icon.image = [UIImage imageNamed:@"ico_tx"];
    [_icon handleCornerRadiusWithRadius:icon_W_H/2];
    [self.contentView addSubview:_icon];
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(cell_left_padding));
        make.width.equalTo(@(icon_W_H));
        make.height.equalTo(@(icon_W_H));
        make.centerY.equalTo(self);
    }];
    
    _nameLabel = [UILabel new];
    _nameLabel.text = @"程思思";
    _nameLabel.textColor = FirstTextColor;
    _nameLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_icon.mas_right).with.offset(icon_name_padding);
        make.right.equalTo(@(-cell_right_padding));
        make.top.equalTo(_icon.mas_top).with.offset(0);
    }];
    
    _infoLabel = [UILabel new];
    _infoLabel.text = @"手机联系人：程思思";
    _infoLabel.textColor = [UIColor colorWithHex:0xaaaaaa];
    _infoLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_infoLabel];
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_icon.mas_right).with.offset(icon_name_padding);
        make.right.equalTo(@(-cell_right_padding));
        make.bottom.equalTo(@(-cell_bottom_padding));
    }];
    
    _followBtn = [UIButton new];
    [_followBtn setTitle:@"已添加" forState:UIControlStateNormal];
    [_followBtn setTitleColor:IconTextColor forState:UIControlStateNormal];
    _followBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_followBtn];
    [_followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(btn_Width));
        make.height.equalTo(@(btn_Height));
        make.right.equalTo(@(-cell_right_padding));
        make.centerY.equalTo(self);
    }];
    [_followBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setModel:(ContactModel *)model
{
    _nameLabel.text = model.name;
    _infoLabel.text = model.phoneNumber.length ? model.phoneNumber : @"<无>";
    [self buttonStyleByState:NO withButton:_followBtn];
}

- (void)buttonStyleByState:(BOOL)isAdd withButton:(UIButton *)button
{
    if (isAdd) {
        [button setTitle:@"已添加" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:IconTextColor forState:UIControlStateNormal];
        [button handleBoardWidth:0 andBorderColor:ThemeColor];
    } else {
        [button setTitle:@"添加" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:ThemeColor forState:UIControlStateNormal];
        [button handleBoardWidth:1 andBorderColor:ThemeColor];
        button.layer.cornerRadius = 2;
    }
}

#pragma mark - clickButton
- (void)clickButton:(UIButton *)button
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickFollowAction:)]) {
        [_delegate clickFollowAction:self];
    }
}

@end

///////


@implementation ContactModel

//

@end
