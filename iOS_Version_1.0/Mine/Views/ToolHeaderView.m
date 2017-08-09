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
    headerView.backgroundColor = BackCellColor;
    
    return headerView;
}

- (void)layoutSubs
{
    _titleLb = [UILabel new];
    _titleLb.font = [UIFont systemFontOfSize:12];
    _titleLb.textColor = [UIColor colorWithHex:0x7b7b7b];
    [self addSubview:_titleLb];
    
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(10));
        make.top.equalTo(@(16));
        make.right.equalTo(@(-10));
        make.bottom.equalTo(@(-10));
        
    }];
}

@end
