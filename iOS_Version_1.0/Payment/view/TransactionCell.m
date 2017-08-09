//
//  TransactionCell.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/16.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "TransactionCell.h"
@interface TransactionCell ()
@end

@implementation TransactionCell

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
    TransactionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];

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
    
    //文字类型view
    UIView* presentview=[[UIView alloc]init];
    [self addSubview:presentview];
    [presentview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(linelabel.mas_right).equalTo(@3);
        make.bottom.equalTo(@-0);
        make.width.equalTo(@150);
    }];
  
    
    UILabel *praiselabel = [[UILabel alloc] init];
    praiselabel.font = [UIFont systemFontOfSize:15];
    praiselabel.textColor=[UIColor blackColor];
    NSString *conststr = @"X1";
    NSString *praisestr = [NSString stringWithFormat:@"赞:%@",conststr];
    NSMutableAttributedString *costattrDescribeStr = [[NSMutableAttributedString alloc] initWithString:praisestr];
    
    [costattrDescribeStr addAttribute:NSForegroundColorAttributeName
     
                                value:[UIColor colorWithHex:0xfc5c98]
     
                                range:[praisestr  rangeOfString:conststr]];
    praiselabel.attributedText = costattrDescribeStr;
    praiselabel.textAlignment=NSTextAlignmentLeft;
    [presentview addSubview:praiselabel];
    [praiselabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@15);
        make.left.equalTo(@0);
    }];
    
    UILabel *content = [[UILabel alloc] init];
    content.font = [UIFont systemFontOfSize:13];
    content.textColor=[UIColor colorWithHex:0xaeaeae];
    content.text=@"赠送给:ALILALA";
    content.textAlignment=NSTextAlignmentLeft;
    [presentview addSubview:content];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(praiselabel.mas_bottom).equalTo(@6);
        make.left.equalTo(@0);
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
    
    
    UIImageView* cashimageview=[[UIImageView alloc]init];
    [self addSubview:cashimageview];
     cashimageview.image=[UIImage imageNamed:@"img_dadabi"];
    [cashimageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@18);
        make.right.equalTo(cashlabel.mas_left).equalTo(@-3);
        make.width.height.equalTo(@25);
    }];
    
    
}

@end
