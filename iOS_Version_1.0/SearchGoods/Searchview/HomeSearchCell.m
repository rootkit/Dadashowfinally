//
//  HomeSearchCell.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/6/12.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "HomeSearchCell.h"

@implementation HomeSearchCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
         [self layoutSubs];
        
        
    }
    return  self;
}

- (void)layoutSubs{
    _titleLb = [UILabel new];
    _titleLb.text=@"商品";
    _titleLb.font = [UIFont systemFontOfSize:12*kScreen_Width/375];
    _titleLb.textColor = [UIColor colorWithHex:0xaeaeae];
     [self addSubview:_titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(15*kScreen_Width/375));
        make.left.equalTo(@(12*kScreen_Width/375));

   }];
    
   UILabel* kindlabel = [UILabel new];
   kindlabel.font = [UIFont systemFontOfSize:12*kScreen_Width/375];
   kindlabel.textColor = [UIColor colorWithHex:0x3f3f3f];
    [self addSubview:kindlabel];
    [kindlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(15*kScreen_Width/375));
        make.left.equalTo(_titleLb.mas_right).equalTo(@(18*kScreen_Width/375));
        
    }];
    _kindlabel=kindlabel;
}




@end
