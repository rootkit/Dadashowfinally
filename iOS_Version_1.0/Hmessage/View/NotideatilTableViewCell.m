//
//  NotideatilTableViewCell.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/4/21.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "NotideatilTableViewCell.h"
#import "UIColor+CustomColor.h"

#define icon_W 80
#define icon_H 76

#define cell_left_padding 12
#define cell_right_padding cell_left_padding
#define cell_top_padding 10
#define cell_bottom_padding cell_top_padding

#define title_icon_padding 14
#define icon_desc_padding 10

#define title_Font 15
#define desc_Font 13

@interface NotideatilTableViewCell ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *notifititleLabel;
@property (nonatomic, strong) UILabel *describeLabel;

@end

@implementation NotideatilTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setNotidetailCell];
    }
    return  self;
}

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier
{
    NotideatilTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = BackCellColor;
    
    return cell;
}

-(void)setNotidetailCell
{
    UIView* backview = [UIView new];
    backview.layer.cornerRadius = 10;
    backview.layer.masksToBounds = YES;
    backview.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:backview];
    [backview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(cell_top_padding));
        make.left.equalTo(@(cell_left_padding));
        make.right.equalTo(@(-cell_right_padding));
        make.bottom.equalTo(@(-cell_bottom_padding));
    }];
    
    backview.layer.cornerRadius = 5;
    backview.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    backview.layer.shadowOffset = CGSizeMake(1, 1);
    backview.layer.shadowOpacity = 0.7; //设置阴影的不透明度
    backview.layer.shadowRadius = 4.0;  //设置阴影的半径

    _notifititleLabel = [[UILabel alloc] init];
    _notifititleLabel.font = [UIFont systemFontOfSize:title_Font];
    _notifititleLabel.textColor = [UIColor colorWithHex:0x353535];
    _notifititleLabel.text=@"您有可领取的折扣";
    [backview addSubview:_notifititleLabel];
    [_notifititleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(cell_top_padding));
        make.left.equalTo(@(cell_left_padding));
        make.right.equalTo(@(-cell_right_padding));
    }];

    _iconView = [[UIImageView alloc] init];
    _iconView.image=[UIImage imageNamed:@"首页"];
    _iconView.layer.cornerRadius = 5;
    _iconView.layer.masksToBounds = YES;
    [backview addSubview:_iconView];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_notifititleLabel.mas_bottom).offset(title_icon_padding);
        make.left.equalTo(@(cell_left_padding));
        make.width.equalTo(@(icon_W));
        make.height.equalTo(@(icon_H));
    }];
    
    _describeLabel = [[UILabel alloc] init];
    _describeLabel.font = [UIFont systemFontOfSize:desc_Font];
    _describeLabel.textColor=[UIColor colorWithHex:0x353535];
    _describeLabel.text=@"旅行FUN轻松,吃喝玩乐,还有100元红包等你来拆";
    _describeLabel.numberOfLines = 4;
    [backview addSubview:_describeLabel];
    [_describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconView.mas_top).with.offset(0);
        make.left.equalTo(_iconView.mas_right).with.offset(icon_desc_padding);
        make.right.equalTo(@(-cell_right_padding));
    }];
}


@end
