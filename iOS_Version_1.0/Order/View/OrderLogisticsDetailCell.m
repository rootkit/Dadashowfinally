//
//  OrderLogisticsDetailCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/9.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "OrderLogisticsDetailCell.h"

@interface OrderLogisticsDetailCell ()

@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UIImageView *iconHisImg;

@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *timeLb;

@end

@implementation OrderLogisticsDetailCell

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
    OrderLogisticsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierString forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = [UIColor whiteColor];
    return cell;
}

-(void)layoutSubviewCell//myOrder_logistics
{
    UILabel *titleLb = [UILabel new];
    titleLb.text = @"[深圳市]快件已经签收，感谢您使用中通快递，感谢您使用中通快递，感谢您使用中通快递";
    titleLb.numberOfLines = 0;
    titleLb.lineBreakMode = NSLineBreakByWordWrapping;
    titleLb.font = [UIFont systemFontOfSize:12*rating];
    titleLb.textColor = InfoTextColor;
    [self.contentView addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(51*rating));
        make.top.equalTo(@(16*rating));
        make.right.equalTo(@(-17*rating));
    }];
    
    UILabel *timeLb = [UILabel new];
    timeLb.text = @"2017-05-25 19:26";
    timeLb.font = [UIFont systemFontOfSize:12*rating];
    timeLb.textColor = InfoTextColor;
    [self.contentView addSubview:timeLb];
    [timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(51*rating));
        make.top.equalTo(titleLb.mas_bottom).with.offset(10*rating);
        make.right.equalTo(titleLb.mas_right);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor colorWithHex:0xd9d9d9];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeLb.mas_bottom).with.offset(11*rating);
        make.height.equalTo(@(1));
        make.left.equalTo(timeLb.mas_left);
        make.right.equalTo(titleLb.mas_right);
        make.bottom.equalTo(@(0));
    }];
    
    UIView *topLine = [UIView new];
    topLine.backgroundColor = [UIColor colorWithHex:0xd9d9d9];
    [self.contentView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.width.equalTo(@(1));
        make.left.equalTo(@(29*rating));
        make.height.equalTo(@(22*rating));
    }];
    
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = [UIColor colorWithHex:0xd9d9d9];
    [self.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(22*rating));
        make.width.equalTo(@(1));
        make.centerX.equalTo(topLine);
        make.bottom.equalTo(@(0));
    }];
    
    UIImageView *iconImg = [UIImageView new];
    [self.contentView addSubview:iconImg];
    iconImg.image = [UIImage imageNamed:@"myOrder_logistics"];
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topLine);
        make.width.and.height.equalTo(@(10*rating));
        make.top.equalTo(titleLb.mas_top).with.offset(3*rating);
    }];
    
    UIImageView *iconHisImg = [UIImageView new];
    [self.contentView addSubview:iconHisImg];
    iconHisImg.image = [UIImage imageNamed:@"myOrder_logistics_history"];
    [iconHisImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topLine);
        make.width.and.height.equalTo(@(5*rating));
        make.top.equalTo(titleLb.mas_top).with.offset(5*rating);
    }];
    
 
    self.topLine = topLine;
    self.bottomLine = bottomLine;
    self.line = line;
    
    self.iconImg = iconImg;
    self.iconHisImg = iconHisImg;
    
    self.titleLb = titleLb;
    self.timeLb = timeLb;
}


- (void)logisticsIsFirst:(BOOL)first isLast:(BOOL)last
{
    if (first && last) {
        if (first || last) { //只有一条时
            self.topLine.hidden = YES;
            self.bottomLine.hidden = YES;
            self.line.hidden = YES;
            
            _iconImg.hidden = NO;
            _iconHisImg.hidden = YES;
            
            _titleLb.textColor = InfoTextColor;
            _timeLb.textColor = InfoTextColor;
        } else {
            self.topLine.hidden = NO;
            self.bottomLine.hidden = NO;
            self.line.hidden = NO;
            
            _iconImg.hidden = YES;
            _iconHisImg.hidden = NO;
            
            _titleLb.textColor = [UIColor colorWithHex:0xbfbfbf];
            _timeLb.textColor = [UIColor colorWithHex:0xbfbfbf];
        }
    } else {
        if (first) {
            self.topLine.hidden = YES;
            self.bottomLine.hidden = NO;
            self.line.hidden = NO;
            
            _iconImg.hidden = NO;
            _iconHisImg.hidden = YES;
            
            _titleLb.textColor = InfoTextColor;
            _timeLb.textColor = InfoTextColor;
        } else if (last) {
            self.topLine.hidden = NO;
            self.bottomLine.hidden = YES;
            self.line.hidden = YES;
            
            _iconImg.hidden = YES;
            _iconHisImg.hidden = NO;
            
            _titleLb.textColor = [UIColor colorWithHex:0xbfbfbf];
            _timeLb.textColor = [UIColor colorWithHex:0xbfbfbf];
        } else {
            self.topLine.hidden = NO;
            self.bottomLine.hidden = NO;
            self.line.hidden = NO;
            
            _iconImg.hidden = YES;
            _iconHisImg.hidden = NO;
            
            _titleLb.textColor = [UIColor colorWithHex:0xbfbfbf];
            _timeLb.textColor = [UIColor colorWithHex:0xbfbfbf];
        }
    }
}


@end
