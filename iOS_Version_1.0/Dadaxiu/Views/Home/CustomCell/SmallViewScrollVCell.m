//
//  SmallViewScrollHCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/13.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "SmallViewScrollVCell.h"

#define cell_top_padding 15* kScreen_Width / 375
#define cell_left_padding 12
#define cell_bottom_padding cell_top_padding
#define cell_right_padding cell_left_padding

#define scro_H 155* kScreen_Width / 375
#define scro_IMG_W 122* kScreen_Width / 375
#define scro_padding 10* kScreen_Width / 375

@interface SmallViewScrollVCell ()

@property (nonatomic, strong) UIScrollView *scroImgView;

@end

@implementation SmallViewScrollVCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self layoutSubviewCell];
    }
    return  self;
}

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier
{
    SmallViewScrollVCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = BackCellColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)layoutSubviewCell
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(@(0));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
    }];
    
    _scroImgView = [UIScrollView new];
    _scroImgView.showsHorizontalScrollIndicator = NO;
    _scroImgView.showsVerticalScrollIndicator = NO;
    [view addSubview:_scroImgView];
    
    [_scroImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(cell_left_padding));
        make.top.equalTo(@(0));
        make.height.equalTo(@(scro_H));
        make.right.equalTo(view.mas_right).with.offset(0);
    }];
    
    //假设数组为5
    _scroImgView.contentSize = CGSizeMake((scro_IMG_W+scro_padding)*5, scro_H);
    
    for (int i = 0; i < 5; i++) {
        SubImgView *imgTitlev = [[SubImgView alloc] initWithFrame:CGRectMake((scro_IMG_W+scro_padding)*i, 0, scro_IMG_W, scro_H)];
        [_scroImgView addSubview:imgTitlev];
        imgTitlev.tag = i+1;
        [imgTitlev addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)]];
    }
}

#pragma mark - /*点击滚动图片*/
- (void)clickAction:(UITapGestureRecognizer *)tap
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickActionWithSmallViewScrollVCellDelegate:forIndexTags:)]) {
        [_delegate clickActionWithSmallViewScrollVCellDelegate:self forIndexTags:tap.view.tag];
    }
}

@end

//////

#define img_W CGRectGetWidth(self.frame)
#define img_H img_W

#define img_title_font 10*kScreen_Width/375
#define price_font 12* kScreen_Width/375

@interface SubImgView ()

@property (nonatomic, strong) UIImageView *imgV;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *priceLb;

@end

@implementation SubImgView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutImgTitle];
    }
    return self;
}

- (void)layoutImgTitle
{
    _imgV = [UIImageView new];
    [_imgV handleCornerRadiusWithRadius:2];
    _imgV.image = [UIImage imageNamed:@"good_default"];
    [self addSubview:_imgV];
    
    [_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(@(0));
        make.right.equalTo(@(0));
        make.height.equalTo(@(img_H));
    }];
    
    _titleLb = [UILabel new];
    _titleLb.text = @"蔓越曲奇 200克";
    _titleLb.font = [UIFont systemFontOfSize:img_title_font];
    _titleLb.textColor = [UIColor colorWithHex:0x333333];
    [self addSubview:_titleLb];
    
    
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.top.equalTo(_imgV.mas_bottom).with.offset(5);
        make.height.equalTo(@(10));
    }];
    
    _priceLb = [UILabel new];
    _priceLb.text = @"¥36.00";
    _priceLb.font = [UIFont systemFontOfSize:price_font];
    _priceLb.textColor = ThemeColor;
    [self addSubview:_priceLb];
    
    [_priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.top.equalTo(_titleLb.mas_bottom).with.offset(3);
        make.height.equalTo(@(11));
    }];
}

@end



