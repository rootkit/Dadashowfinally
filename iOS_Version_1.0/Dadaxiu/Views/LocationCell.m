//
//  LocationCell.m
//  iOS_Version_1.0
//
//  Created by 李萍 on 2017/4/24.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "LocationCell.h"
#import "UIColor+CustomColor.h"

#define left_padding 12
//#define right_padding 27
#define btn_padding_V 11//(左右间距)
#define btn_padding_H 9//(上下间距)
#define btn_width (([UIScreen mainScreen].bounds.size.width)-left_padding-right_padding - 2*btn_padding_V)/3
#define btn_height 37

@interface LocationCell ()
@property (nonatomic, strong) NSMutableArray *subCitys;

@end

@implementation LocationCell

-(id)initWithStyle:(UITableViewCellStyle)Style
         indexPath:(NSIndexPath *)indexPath
    identifier:(NSString *)identifierString
    subCitys:(NSArray *)citys
{
    self = [super initWithStyle:Style reuseIdentifier:identifierString];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.subCitys = [citys mutableCopy];
        [self subViewLayout];
    }
    return self;
}

- (void)subViewLayout
{
    if (self.subCitys == nil) { return; }
    
    for (int i = 0; i < self.subCitys.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(left_padding+i%3*(btn_width + btn_padding_V), btn_padding_H+i/3*(btn_height + btn_padding_H), btn_width, btn_height);
        [btn setTitle:_subCitys[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:[UIColor colorWithHex:0x585757] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor whiteColor];
        btn.layer.cornerRadius = 3;
        btn.layer.borderColor = [UIColor colorWithHex:0xe2e2e2].CGColor;
        btn.layer.borderWidth = 1;
        [self addSubview:btn];
    }
}

#pragma mark - 
- (void)btnClick:(UIButton *)btn
{
    if (_delegate && [_delegate respondsToSelector:@selector(tableviewSelectedIndex:)]) {
        [_delegate tableviewSelectedIndex:btn.titleLabel.text];
    }
}


@end
