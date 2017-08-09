//
//  CollectShopsCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/6.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "CollectShopsCell.h"

#define portrait_W_H 34
#define scrollview_H 106*kScreen_Width/375

@interface CollectShopsCell ()

@property (nonatomic, strong) UIImageView *portraitIMG;
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *infoLb;
@property (nonatomic, strong) UIScrollView *pictureSv;

@end

@implementation CollectShopsCell

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
    CollectShopsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = BackCellColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)layoutSubviewCell//
{
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
        make.top.equalTo(self.contentView.mas_top).with.offset(3);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-3);
    }];
    
    _portraitIMG = [UIImageView new];
    _portraitIMG.image = [UIImage imageNamed:@"collect_shop_userPortrait"];
    [_portraitIMG handleCornerRadiusWithRadius:3];
    [bottomView addSubview:_portraitIMG];
    
    [_portraitIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(12);
        make.top.equalTo(self.contentView.mas_top).with.offset(12);
        make.width.equalTo(@(portrait_W_H));
        make.height.equalTo(@(portrait_W_H));
    }];
    
    _nameLb = [UILabel new];
    _nameLb.text = @"千草花叶";
    _nameLb.font = [UIFont systemFontOfSize:14];
    _nameLb.textColor = FirstTextColor;
    [bottomView addSubview:_nameLb];
    
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_portraitIMG.mas_right).with.offset(10);
        make.top.equalTo(_portraitIMG.mas_top).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-12);
    }];
    
    _infoLb = [UILabel new];
    _infoLb.text = @"销量5520 | 收藏9837";
    _infoLb.font = [UIFont systemFontOfSize:12];
    _infoLb.textColor = IconTextColor;
    [bottomView addSubview:_infoLb];
    
    [_infoLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLb.mas_left).with.offset(0);
        make.top.equalTo(_nameLb.mas_bottom).with.offset(5);
        make.right.equalTo(_nameLb.mas_right).with.offset(0);
        make.bottom.equalTo(_portraitIMG.mas_bottom).with.offset(0);
    }];
    
    _pictureSv = [UIScrollView new];
    _pictureSv.showsVerticalScrollIndicator = NO;
    _pictureSv.showsHorizontalScrollIndicator = NO;
    [bottomView addSubview:_pictureSv];
    
    [_pictureSv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_portraitIMG.mas_left).with.offset(0);
        make.top.equalTo(_portraitIMG.mas_bottom).with.offset(12);
        make.right.equalTo(_nameLb.mas_right).with.offset(0);
        make.height.equalTo(@(scrollview_H));
    }];
    
    [self contentImageScrollView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self contentImageScrollView];
}

- (void)contentImageScrollView
{
    NSArray *images = @[@"collect_goods", @"collect_goods", @"collect_goods", @"collect_goods", @"collect_goods"];
    
    CGFloat imageHeight = CGRectGetHeight(_pictureSv.frame);
    CGFloat imageWidth = imageHeight;
    CGFloat imagePadding = 5;
    
    _pictureSv.contentSize = CGSizeMake(imageWidth*images.count + imagePadding*(images.count-1), CGRectGetHeight(_pictureSv.frame));
    
    for (int i = 0; i < images.count; i++) {
        UIImageView *imageView = [UIImageView new];
        [imageView handleCornerRadiusWithRadius:3];
        imageView.image = [UIImage imageNamed:images[i]];
//        [imageView loadPortrait:[NSURL URLWithString:images[i]]];
        imageView.frame = CGRectMake((imageWidth+imagePadding)*i, 0, imageWidth, imageHeight);
        [_pictureSv addSubview:imageView];
    }
}

@end
