//
//  TransactionSecondCell.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/16.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "TransactionSecondCell.h"

@implementation TransactionSecondCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self layoutSubviewCell];
    }
    return  self;
}

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier
{
    TransactionSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)layoutSubviewCell
{
    UILabel *timelabel = [[UILabel alloc] init];
    timelabel.font = [UIFont systemFontOfSize:13];
    timelabel.textColor=[UIColor blackColor];
    timelabel.text=@"05-04";
    timelabel.textAlignment=NSTextAlignmentLeft;
    [self addSubview:timelabel];
    [timelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@19);
        make.left.equalTo(@12);
    }];
    
    UILabel *formerlytime = [[UILabel alloc] init];
    formerlytime.font = [UIFont systemFontOfSize:13];
    formerlytime.textColor=[UIColor colorWithHex:0xaeaeae];
    formerlytime.text=@"23:08";
    formerlytime.textAlignment=NSTextAlignmentLeft;
    [self addSubview:formerlytime];
    [formerlytime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timelabel.mas_bottom).equalTo(@6);
        make.left.equalTo(@12);
    }];
    
    UILabel* linelabel=[[UILabel alloc]init];
    linelabel.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    [self addSubview:linelabel];
    [linelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@13);
        make.left.equalTo(timelabel.mas_right).equalTo(@3);
        make.width.equalTo(@0.5);
        make.bottom.equalTo(@-13);
        
    }];    
    /**图文*/
    UIView* imagetextview=[[UIView alloc]init];
    [self addSubview:imagetextview];
    [imagetextview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(linelabel.mas_right).equalTo(@3);
        make.bottom.equalTo(@-0);
        make.width.equalTo(@150);
    }];
    
    UIImageView* giftimageview=[[UIImageView alloc]init];
    [imagetextview addSubview:giftimageview];
    giftimageview.image=[UIImage imageNamed:@"record_img"];
    [giftimageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@19);
        make.left.equalTo(linelabel.mas_right).equalTo(@3);
        make.width.height.equalTo(@39);
    }];
    
    UILabel *giftlabel = [[UILabel alloc] init];
    giftlabel.font = [UIFont systemFontOfSize:13];
    giftlabel.textColor=[UIColor blackColor];
    giftlabel.text=@"小雨伞";
    giftlabel.textAlignment=NSTextAlignmentLeft;
    [imagetextview addSubview:giftlabel];
    [giftlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@19);
        make.left.equalTo(giftimageview.mas_right).equalTo(@3);
    }];
    
    
    UILabel *waylabel = [[UILabel alloc] init];
    waylabel.font = [UIFont systemFontOfSize:13];
    waylabel.textColor=[UIColor colorWithHex:0xaeaeae];
    waylabel.text=@"积分兑换";
    waylabel.textAlignment=NSTextAlignmentLeft;
    [imagetextview addSubview:waylabel];
    [waylabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(giftlabel.mas_bottom).equalTo(@6);
        make.left.equalTo(giftimageview.mas_right).equalTo(@3);
    }];
    
    UILabel *cashlabel= [[UILabel alloc] init];
    cashlabel.font = [UIFont systemFontOfSize:13];
    cashlabel.textColor=[UIColor colorWithHex:0xfc5c98];
    cashlabel.text=@"+680";
    [self addSubview:cashlabel];
    [cashlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@23);
        make.right.equalTo(@-12);
    }];
    
    UILabel *scorenublabel= [[UILabel alloc] init];
    scorenublabel.font = [UIFont systemFontOfSize:13];
    scorenublabel.textColor=[UIColor blackColor];
    scorenublabel.text=@"积分";
    [self addSubview:scorenublabel];
    [scorenublabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cashlabel.mas_top);
        make.right.equalTo(cashlabel.mas_left).equalTo(@-3);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
