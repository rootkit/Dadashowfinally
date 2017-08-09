//
//  ToolCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/8.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "ToolCell.h"

#define item_W 35
#define item_H item_W
@interface ToolCell ()

@property (nonatomic, strong) UIImageView *iconIMG;
@property (nonatomic, strong) UILabel *titleLb;

@end

@implementation ToolCell

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
    ToolCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    item.backgroundColor = [UIColor whiteColor];
    
    return item;
}

- (void)layoutSubs
{
    _iconIMG = [UIImageView new];
    [self.contentView addSubview:_iconIMG];
    [_iconIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(20);
        make.width.equalTo(@(item_W));
        make.height.equalTo(@(item_H));
        make.centerX.equalTo(self.contentView);
    }];
    
    _titleLb = [UILabel new];
    _titleLb.font = [UIFont systemFontOfSize:12];
    _titleLb.textColor = FirstTextColor;
    _titleLb.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(10));
        make.top.equalTo(_iconIMG.mas_bottom).with.offset(9);
        make.right.equalTo(@(-10));
        
    }];
}

- (void)setToolModel:(ToolModel *)toolModel
{
    _iconIMG.image = [UIImage imageNamed:toolModel.iconName];
    _titleLb.text = toolModel.title;
}


@end


///////
@implementation ToolModel

@end
