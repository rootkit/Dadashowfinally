//
//  FollowListCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/6.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "FollowListCell.h"

#define portrait_W_H 34*kScreen_Width/375
#define btn_W 62
#define btn_H 24

@interface FollowListCell ()
{
    BOOL _touchPortrait;
}

@property (nonatomic, strong) UIImageView *portraitIMG;
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *descLb;
@property (nonatomic, strong) UIButton *followBtn;

@end

@implementation FollowListCell

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
    FollowListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)layoutSubviewCell
{
    _portraitIMG = [UIImageView new];
    _portraitIMG.image = [UIImage imageNamed:@"mine_bg"];
    [_portraitIMG handleCornerRadiusWithRadius:3];
    [self.contentView addSubview:_portraitIMG];
    
    [_portraitIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(12);
        make.width.equalTo(@(portrait_W_H));
        make.height.equalTo(@(portrait_W_H));
        make.centerY.equalTo(self.contentView);
    }];
    
    _nameLb = [UILabel new];
    _nameLb.text = @"妖精的口袋";
    _nameLb.font = [UIFont systemFontOfSize:14];
    _nameLb.textColor = FirstTextColor;
    [self.contentView addSubview:_nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_portraitIMG.mas_right).with.offset(9);
        make.top.equalTo(_portraitIMG.mas_top).with.offset(0);
    }];
    
    _descLb = [UILabel new];
    _descLb.text = @"粉丝福利多多，欢迎点赞关注";
    _descLb.font = [UIFont systemFontOfSize:12];
    _descLb.textColor = IconTextColor;
    [self.contentView addSubview:_descLb];
    
    [_descLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_portraitIMG.mas_right).with.offset(9);
        make.right.equalTo(_nameLb.mas_right).with.offset(0);
        make.top.equalTo(_nameLb.mas_bottom).with.offset(2);
//        make.bottom.equalTo(_portraitIMG.mas_bottom).with.offset(0);
        
    }];
    
    _followBtn = [UIButton new];
    [_followBtn setTitleColor:IconTextColor forState:UIControlStateNormal];
    _followBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_followBtn setTitle:@"关 注" forState:UIControlStateNormal];
    _followBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_followBtn handleBoardWidth:1 andBorderColor:IconTextColor];
    [_followBtn handleCornerRadiusWithRadius:12];
    [_followBtn addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_followBtn];
    [_followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(btn_W));
        make.height.equalTo(@(btn_H));
        make.left.equalTo(_nameLb.mas_right).with.offset(10);
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(@(-12));
    }];
}

- (void)changeBtnTitle:(BOOL)isFollow
{
    [_followBtn setTitle:(isFollow ? @"已关注" : @"关注") forState:UIControlStateNormal];
}

#pragma mark - clickButtonAction
- (void)clickButtonAction:(UIButton *)button
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickFollowingAction:indexPathRow:)]) {
        [_delegate clickFollowingAction:self indexPathRow:self.selectedIndex];
    }
}

#pragma mark --- touch handle
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _touchPortrait = NO;
    UITouch* t = [touches anyObject];
    CGPoint p1 = [t locationInView:self.portraitIMG];
    if (CGRectContainsPoint(self.portraitIMG.bounds, p1)) {
        _touchPortrait = YES;
    } else {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_touchPortrait) {
        if (_delegate && [_delegate respondsToSelector:@selector(clickPortraitAction:indexPathRow:)]) {
            [_delegate clickPortraitAction:self indexPathRow:self.selectedIndex];
        }
    } else{
        [super touchesEnded:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!_touchPortrait) {
        
        [super touchesCancelled:touches withEvent:event];
    }
}

@end
