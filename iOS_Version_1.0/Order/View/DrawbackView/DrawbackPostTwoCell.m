//
//  DrawbackPostTwoCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/13.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "DrawbackPostTwoCell.h"

@implementation DrawbackPostTwoCell

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
    DrawbackPostTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierString forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)layoutSubviewCell
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithHex:0x62b1e8];
    view.layer.cornerRadius = 5*rating;
    [self.contentView addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12*rating));
        make.top.equalTo(@(12*rating));
        make.right.equalTo(@(-12*rating));
        make.bottom.equalTo(@(0));
    }];
    
    UILabel *firstLb = [UILabel new];
    firstLb.text = @"卖家同意了申请";
    firstLb.textColor = [UIColor whiteColor];
    firstLb.font = [UIFont systemFontOfSize:12*rating];
    [view addSubview:firstLb];
    [firstLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12*rating));
        make.right.equalTo(@(-12*rating));
        make.top.equalTo(@(12*rating));
    }];
}

@end
