//
//  DrawbackSuccessCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/13.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "DrawbackSuccessCell.h"

@implementation DrawbackSuccessCell

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
    DrawbackSuccessCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierString forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)layoutSubviewCell//myOrder_logistics
{
    UIView *view = [UIView new];
    view.backgroundColor = ThemeColor;
    view.layer.cornerRadius = 5*rating;
    [self.contentView addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12*rating));
        make.top.equalTo(@(12*rating));
        make.right.equalTo(@(-12*rating));
        make.bottom.equalTo(@(0));
    }];
    
    UILabel *firstLb = [UILabel new];
    firstLb.text = @"退款成功";
    firstLb.textColor = [UIColor whiteColor];
    firstLb.font = [UIFont systemFontOfSize:12*rating];
    [view addSubview:firstLb];
    [firstLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12*rating));
        make.right.equalTo(@(-12*rating));
        make.top.equalTo(@(12*rating));
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor whiteColor];
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstLb.mas_left);
        make.right.equalTo(firstLb.mas_right);
        make.top.equalTo(firstLb.mas_bottom).with.offset(12*rating);
        make.height.equalTo(@(0.5));
    }];
    
    UILabel *secondLb = [UILabel new];
    secondLb.text = @"退款金额 : 168.00元";
    secondLb.textColor = [UIColor whiteColor];
    secondLb.font = [UIFont systemFontOfSize:12*rating];
    [view addSubview:secondLb];
    [secondLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstLb.mas_left);
        make.right.equalTo(firstLb.mas_right);
        make.top.equalTo(line.mas_bottom).with.offset(12*rating);
    }];
    
    UILabel *thirdLb = [UILabel new];
    thirdLb.text = @"金额返回原支付路径";
    thirdLb.textColor = [UIColor whiteColor];
    thirdLb.font = [UIFont systemFontOfSize:12*rating];
    [view addSubview:thirdLb];
    [thirdLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstLb.mas_left);
        make.right.equalTo(firstLb.mas_right);
        make.top.equalTo(secondLb.mas_bottom).with.offset(8*rating);
    }];
    
    UIView *secondLine = [UIView new];
    secondLine.backgroundColor = [UIColor whiteColor];
    [view addSubview:secondLine];
    [secondLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstLb.mas_left);
        make.right.equalTo(firstLb.mas_right);
        make.top.equalTo(thirdLb.mas_bottom).with.offset(12*rating);
        make.height.equalTo(@(0.5));
    }];
    
    UILabel *numLb = [UILabel new];
    numLb.text = @"编号 : 238127484732829208";
    numLb.textColor = [UIColor whiteColor];
    numLb.font = [UIFont systemFontOfSize:12*rating];
    [view addSubview:numLb];
    [numLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstLb.mas_left);
        make.right.equalTo(firstLb.mas_right);
        make.top.equalTo(secondLine.mas_bottom).with.offset(12*rating);
        make.bottom.equalTo(@(-12*rating));
    }];
}

@end
