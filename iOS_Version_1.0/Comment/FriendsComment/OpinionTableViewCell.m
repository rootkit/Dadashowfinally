//
//  OpinionTableViewCell.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/10.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "OpinionTableViewCell.h"

@implementation OpinionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self settextviewcell];
        
        
    }
    return self;
}


-(void)settextviewcell{
    
    UILabel *typelabel = [[UILabel alloc] init];
    typelabel.font = [UIFont systemFontOfSize:14*(kScreen_Width/375)];
    typelabel.textColor=[UIColor colorWithHex:0x4f4f4f];
    typelabel.text=@"功能异常";
    [self addSubview:typelabel];
    [typelabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(16*(kScreen_Width/375)));
        make.left.equalTo(@(13*(kScreen_Width/375)));
    }];
    _typelabel=typelabel;
    
    UILabel *detailproblem = [[UILabel alloc] init];
    detailproblem.font = [UIFont systemFontOfSize:14*(kScreen_Width/375)];
    detailproblem.textColor=[UIColor colorWithHex:0x4f4f4f];
    detailproblem.text=@"不能正常使用现在功能";
    [self addSubview:detailproblem];
    [detailproblem  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(typelabel.mas_right).equalTo(@(16*(kScreen_Width/375)));
        make.top.equalTo(typelabel.mas_top);
    }];
    _detailproblem=detailproblem;
    
    
    UIButton * selectedbtn=[[UIButton alloc]init];
    [selectedbtn setBackgroundImage:[UIImage imageNamed:@"意见选中前"] forState:UIControlStateNormal];
    [selectedbtn setBackgroundImage:[UIImage imageNamed:@"gouxuan"] forState:UIControlStateSelected];
    selectedbtn.userInteractionEnabled=NO;
    [self addSubview:selectedbtn];
//    selectedbtn.backgroundColor=[UIColor redColor];
    [selectedbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(typelabel.mas_top);
        make.right.equalTo(@(-12*(kScreen_Width/375)));
        make.width.height.equalTo(@(20*(kScreen_Width/375)));
    }];
    _selectedbtn=selectedbtn;
}
@end
