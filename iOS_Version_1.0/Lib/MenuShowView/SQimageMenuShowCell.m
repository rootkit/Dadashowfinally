//
//  SQimageMenuShowCell.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/4/29.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "SQimageMenuShowCell.h"
#import "UIColor+CustomColor.h"

@implementation SQimageMenuShowCell

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
    titlelabel.textAlignment=NSTextAlignmentLeft;
    titlelabel.font=[UIFont systemFontOfSize:15*(kScreen_Height/667)];
    _textTitle=titlelabel;
    [self addSubview:titlelabel];
    [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@(35*(kScreen_Height/667)));
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        
        
    }];
    
    UIImageView* imageview=[[UIImageView alloc]init];
    imageview.image=[UIImage imageNamed:@"ico_lxr"];
    [self addSubview:imageview];
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(12*(kScreen_Height/667)));
        make.left.equalTo(@(10*(kScreen_Height/667)));
        make.right.equalTo(_textTitle.mas_left).equalTo(@(-5*(kScreen_Height/667)));
        make.bottom.equalTo(@(-12*(kScreen_Height/667)));
    }];
    _imageview=imageview;
 

}


@end
