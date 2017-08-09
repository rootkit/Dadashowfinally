//
//  SQMenuShowCell.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/4/29.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "SQMenuShowCell.h"
#import "UIColor+CustomColor.h"
@implementation SQMenuShowCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupavatarView];
        
        
    }
    return self;
}
-(void)setupavatarView{
    UILabel* titlelabel=[UILabel new];
    titlelabel.textColor=[UIColor colorWithHex:0x585757];
    titlelabel.backgroundColor=[UIColor whiteColor];
    titlelabel.text=@"";
    titlelabel.textAlignment=NSTextAlignmentCenter;
    titlelabel.font=[UIFont systemFontOfSize:17*(kScreen_Height/667)];
    _textTitle=titlelabel;
    [self addSubview:titlelabel];
    [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        
        
    }];
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
