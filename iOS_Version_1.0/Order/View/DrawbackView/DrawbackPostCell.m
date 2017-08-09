//
//  DrawbackPostCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/13.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "DrawbackPostCell.h"

@interface DrawbackPostCell ()

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *stateLb;
@property (nonatomic, strong) UILabel *infoLb;

@end

@implementation DrawbackPostCell

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
    DrawbackPostCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierString forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)layoutSubviewCell
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithHex:0xefefef];
    view.layer.cornerRadius = 5*rating;
    [self.contentView addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12*rating));
        make.top.equalTo(@(12*rating));
        make.right.equalTo(@(-12*rating));
        make.bottom.equalTo(@(0));
    }];
    
    UILabel *firstLb = [UILabel new];
    firstLb.text = @"买家发起了申请";
    firstLb.textColor = SecondTextColor;
    firstLb.font = [UIFont systemFontOfSize:12*rating];
    [view addSubview:firstLb];
    [firstLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12*rating));
        make.right.equalTo(@(-12*rating));
        make.top.equalTo(@(12*rating));
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = SecondTextColor;
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstLb.mas_left);
        make.right.equalTo(firstLb.mas_right);
        make.top.equalTo(firstLb.mas_bottom).with.offset(12*rating);
        make.height.equalTo(@(0.5));
    }];
    
    UILabel *secondLb = [UILabel new];
    secondLb.text = @"发起了退货退款申请，货物状态：已发货，原因：未按照约定的物品详情发货，金额168.00元。";
    secondLb.textColor = SecondTextColor;
    secondLb.font = [UIFont systemFontOfSize:12*rating];
    secondLb.numberOfLines = 0;
    secondLb.lineBreakMode = NSLineBreakByWordWrapping;
    [view addSubview:secondLb];
    [secondLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstLb.mas_left);
        make.right.equalTo(firstLb.mas_right);
        make.top.equalTo(line.mas_bottom).with.offset(12*rating);
        make.bottom.equalTo(@(-12*rating));
    }];
    
    _bottomView = view;
    _lineView = line;
    _stateLb = firstLb;
    _infoLb = secondLb;
}

- (void)setModel:(DrawbackModel *)model
{
    _stateLb.text = model.stateStr;
    _infoLb.text = model.info;
}

- (void)setPopColor:(UIColor *)popColor
{
    _bottomView.backgroundColor = popColor;
}

- (void)setTextAndBgColor:(UIColor *)textAndBgColor
{
    _lineView.backgroundColor = textAndBgColor;
    _stateLb.textColor = textAndBgColor;
    _infoLb.textColor = textAndBgColor;
}

@end

@implementation DrawbackModel

@end
