//
//  ToolHeaderView.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/8.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "ToolHeaderView.h"

@implementation ToolHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        [self layoutSubs];
    }
    return self;
}
+ (instancetype)returnResueCellFormTableView:(UICollectionView *)collectionView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier
{
    ToolHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier forIndexPath:indexPath];
    
    return headerView;
}

- (void)layoutSubs
{
    self.backgroundColor = _headerViewBgColor;
    
    _titleLb = [UILabel new];
    _titleLb.font = _titleFont;
    _titleLb.textColor = _titleTextColor;
    [self addSubview:_titleLb];
    
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(10));
        make.top.equalTo(@(16));
        make.right.equalTo(@(-10));
        make.bottom.equalTo(@(-10));
        
    }];
}

- (UIFont *)titleFont
{
    if (!_titleFont) {
        _titleFont = [UIFont systemFontOfSize:12];
    }
    
    return _titleFont;
}

- (UIColor *)titleTextColor
{
    if (!_titleTextColor) {
        _titleTextColor = [UIColor colorWithHex:0x7b7b7b];
    }
    return _titleTextColor;
}

- (UIColor *)headerViewBgColor
{
    if (!_headerViewBgColor) {
        _headerViewBgColor = BackCellColor;
    }
    return _headerViewBgColor;
}

@end
