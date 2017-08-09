//
//  AddNewContactCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/17.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "AddNewContactCell.h"

#define cell_left_padding 12
#define cell_right_padding cell_left_padding

#define icon_W_H 48
#define icon_name_padding 10

@implementation AddNewContactCell

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
    AddNewContactCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

-(void)setCell
{
    UIImageView *icon = [UIImageView new];
    icon.image = [UIImage imageNamed:@"icon_phone"];
    [icon handleCornerRadiusWithRadius:icon_W_H/2];
    [self.contentView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(cell_left_padding));
        make.width.equalTo(@(icon_W_H));
        make.height.equalTo(@(icon_W_H));
        make.centerY.equalTo(self);
    }];
    
    UILabel *label = [UILabel new];
    label.text = @"添加手机联系人";
    label.textColor = FirstTextColor;
    label.font = [UIFont systemFontOfSize:17];
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.mas_right).with.offset(icon_name_padding);
        make.right.equalTo(@(-cell_right_padding));
        make.centerY.equalTo(self);
    }];
}

@end
