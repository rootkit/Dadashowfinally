//
//  WxandAlipaycell.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/15.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "WxandAlipaycell.h"

@implementation WxandAlipaycell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setweandailpaylcell];
        
        
    }
    return  self;
}

-(void)setweandailpaylcell{
    UIImageView* wxandailpayimage=[[UIImageView alloc]init];
    wxandailpayimage.image=[UIImage imageNamed:@"payment_wechat"];
    [self addSubview: wxandailpayimage];
    [wxandailpayimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@18);
        make.left.equalTo(@12);
        make.width.height.equalTo(@16);
    }];
    _wxandailpayimage=wxandailpayimage;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor=[UIColor colorWithHex:0x353535];
    titleLabel.text=@"微信支付";
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@18);
        make.left.equalTo(wxandailpayimage.mas_right).equalTo(@8);
    }];
    _titleLabel=titleLabel;
    
    
    UIButton * selectedbtn=[[UIButton alloc]init];
//    [selectedbtn setBackgroundImage:[UIImage imageNamed:@"yuan1"] forState:UIControlStateNormal];
    [selectedbtn setBackgroundImage:[UIImage imageNamed:@"payment_selected"] forState:UIControlStateSelected];
    selectedbtn.userInteractionEnabled=NO;
    [self addSubview:selectedbtn];
    [selectedbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@16);
        make.right.equalTo(@-12);
        make.width.height.equalTo(@20);
    }];
    _selectedbtn=selectedbtn;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
