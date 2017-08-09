//
//  CollectGoodsCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/6.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "CollectGoodsCell.h"

#define portrait_W 70*rating
#define portrait_H portrait_W

@interface CollectGoodsCell ()

@property (nonatomic, strong) UIImageView *portraitIMG;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *priceLb;
@property (nonatomic, strong) UILabel *historyLb;

@end

@implementation CollectGoodsCell

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
    CollectGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = BackCellColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)layoutSubviewCell
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
    _portraitIMG.backgroundColor=DefaultImgBgColor;
    [_portraitIMG handleCornerRadiusWithRadius:3];
    [bottomView addSubview:_portraitIMG];
    
    [_portraitIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(12*rating);
        make.width.equalTo(@(portrait_W));
        make.height.equalTo(@(portrait_H));
        make.centerY.equalTo(self.contentView);
    }];
    
    _titleLb = [UILabel new];
//    _titleLb.text = @"新款韩版收腰显瘦波西米亚性感露背蕾丝裙度假沙滩连衣裙";
    _titleLb.numberOfLines = 2;
    _titleLb.lineBreakMode = NSLineBreakByWordWrapping;
    _titleLb.font = [UIFont systemFontOfSize:14*rating];
    _titleLb.textColor = [UIColor colorWithHex:0x353434];
    [bottomView addSubview:_titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_portraitIMG.mas_right).with.offset(10*rating);
        make.top.equalTo(_portraitIMG.mas_top).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-12*rating);
    }];
    
    _priceLb = [UILabel new];
//    _priceLb.text = @"¥286.00";
    _priceLb.font = [UIFont systemFontOfSize:17*rating];
    _priceLb.textColor = ThemeColor;
    [bottomView addSubview:_priceLb];
    
    [_priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLb.mas_left).with.offset(0);
        make.bottom.equalTo(_portraitIMG.mas_bottom).with.offset(0);
        make.height.equalTo(@(14*rating));
        make.width.equalTo(@(70*rating));
    }];
    
    _historyLb = [UILabel new];
//    _historyLb.text = @"¥369.00";
    _historyLb.font = [UIFont systemFontOfSize:12*rating];
    _historyLb.textColor = IconTextColor;
    [bottomView addSubview:_historyLb];
    
    [_historyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_priceLb.mas_right).with.offset(15*rating);
        make.bottom.equalTo(_portraitIMG.mas_bottom).with.offset(0);
        make.height.equalTo(@(10*rating));
        make.width.equalTo(@(50*rating));
    }];
    
    UILabel* line=[UILabel new];
    line.backgroundColor = IconTextColor;
    [_historyLb addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(6*rating));
        make.left.equalTo(_historyLb.mas_left);
        make.height.equalTo(@1);
        make.right.equalTo(_historyLb.mas_right);
        
    }];
}

-(void)setModel:(MineGoodsmodel *)model{
    _model=model;
    
    [_portraitIMG loadPicture:[NSURL URLWithString:model.imageUrl]];
    
    if (model.goodsName.length>0) {
        _titleLb.text=model.goodsName;
    }else{
        _titleLb.text=@"无";
    }
    
    if (model.shopPrice) {
       _priceLb.text=[NSString stringWithFormat:@"%.2f",model.shopPrice];
    }else{
        _priceLb.text=@"0.00";
    }
    
    if (model.marketPrice) {
        _historyLb.text=[NSString stringWithFormat:@"%.2f",model.marketPrice];
    }else{
        _historyLb.text=@"0.00";
    }
    
 }

-(void)setTranvemodel:(Travelmodel *)tranvemodel{
    _tranvemodel = tranvemodel;
    
    [_portraitIMG loadPicture:[NSURL URLWithString:tranvemodel.imageUrl]];
    
    if (tranvemodel.goodsName.length>0) {
        _titleLb.text=tranvemodel.goodsName;
    }else{
        _titleLb.text=@"无";
    }
    
    if (tranvemodel.shopPrice) {
        _priceLb.text=[NSString stringWithFormat:@"%.2f",tranvemodel.shopPrice];
    }else{
        _priceLb.text=@"0.00";
    }
    
    if (tranvemodel.marketPrice) {
        _historyLb.text=[NSString stringWithFormat:@"%.2f",tranvemodel.marketPrice];
    }else{
        _historyLb.text=@"0.00";
    }
    
    
    
}

@end
