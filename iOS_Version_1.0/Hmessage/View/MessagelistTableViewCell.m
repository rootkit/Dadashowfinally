//
//  MessagelistTableViewCell.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/4/21.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "MessagelistTableViewCell.h"

#define cell_left_padding 12
#define cell_right_padding cell_left_padding

#define icon_W_H 48
#define icon_name_padding 10

#define nickname_Font 15
#define desc_Font 14
#define time_Font 12

@interface MessagelistTableViewCell ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nickLabel;
@property (nonatomic, strong) UILabel *timesLabel;
@property (nonatomic, strong) UILabel *messageLabel;

@end

@implementation MessagelistTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self settablecell];
    }
       return  self;
}

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier
{
    MessagelistTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    return cell;
}

-(void)settablecell{
    _iconView = [[UIImageView alloc] init];
    _iconView.image=[UIImage imageNamed:@"首页"];
    _iconView.layer.cornerRadius = 25;
    _iconView.layer.masksToBounds = YES;
    [self.contentView addSubview:_iconView];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(cell_left_padding));
        make.width.equalTo(@(icon_W_H));
        make.height.equalTo(@(icon_W_H));
        make.centerY.equalTo(self);
    }];
    
    _nickLabel = [[UILabel alloc] init];
    _nickLabel.font = [UIFont systemFontOfSize:nickname_Font];
    _nickLabel.text = @"雅典娜";
    _nickLabel.textColor = FirstTextColor;
    [self.contentView addSubview:_nickLabel];
    [_nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconView.mas_top).with.offset(0);
        make.left.equalTo(_iconView.mas_right).with.offset(icon_name_padding);
    }];
    
    _timesLabel = [[UILabel alloc] init];
    _timesLabel.font = [UIFont systemFontOfSize:time_Font];
    _timesLabel.text = @"16/12/19";
    _timesLabel.textColor = IconTextColor;
    _timesLabel.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:_timesLabel];
    [_timesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconView.mas_top).with.offset(0);
        make.left.equalTo(_nickLabel.mas_right).with.offset(5);
        make.right.equalTo(@(-cell_right_padding));
        make.width.equalTo(@100);
    }];
    
    _messageLabel = [[UILabel alloc] init];
    _messageLabel.font = [UIFont systemFontOfSize:desc_Font];
    _messageLabel.textColor = IconTextColor;
    _messageLabel.text = @"心想事成";
    [self.contentView addSubview:_messageLabel];
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_iconView.mas_bottom).with.offset(0);
        make.left.equalTo(_iconView.mas_right).with.offset(icon_name_padding);
        make.right.equalTo(@(-cell_right_padding));
    }];
}

- (void)setMessage:(MessageModel *)message
{
    _message = message;
    
    _iconView.image = [UIImage imageNamed:message.imageName];
    _nickLabel.text = message.title;
    _messageLabel.text = message.desc;
    _timesLabel.text = message.time;
}

@end

////
@implementation MessageModel

@end
