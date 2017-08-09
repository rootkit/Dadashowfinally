//
//  IopenshopTableViewCell.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/10.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "IopenshopTableViewCell.h"
@interface IopenshopTableViewCell()<UITextFieldDelegate>


@end

@implementation IopenshopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self settextviewcell];
        
        
    }
    return self;
}


-(void)settextviewcell{
    UITextField* passwardTF=[[UITextField alloc]init];
    passwardTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 0)];
    passwardTF.leftViewMode = UITextFieldViewModeAlways;
    passwardTF.font = [UIFont systemFontOfSize:14];
    passwardTF.tintColor = [UIColor themeColor];
    passwardTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:passwardTF];

    
    [passwardTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@(0));
    }];
    _inputwardTF=passwardTF;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
