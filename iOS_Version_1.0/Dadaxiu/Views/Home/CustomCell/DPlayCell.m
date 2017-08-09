//
//  DPlayCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/13.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "DPlayCell.h"
#import "ImgAndPriceView.h"
#import "UIImageView+WebCache.h"
#define cell_top_padding 15* kScreen_Width / 375
#define cell_left_padding 12
#define cell_bottom_padding cell_top_padding
#define cell_right_padding cell_left_padding

#define bigImg_H_W 232* kScreen_Width / 375
#define smallImg_H_W 113* kScreen_Width / 375

@interface DPlayCell ()

@property (nonatomic, strong) UIImageView *bigImg;
@property (nonatomic, strong) UIImageView *smallTopImg;
@property (nonatomic, strong) UIImageView *smallBottomImg;
@property(nonatomic,strong)ImgAndPriceView *imgPriV;

@end

@implementation DPlayCell

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
    DPlayCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
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
    
    _bigImg = [UIImageView new];
    _bigImg.image = [UIImage imageWithColor:DefaultImgBgColor];
    _bigImg.tag =99;
    _bigImg.userInteractionEnabled = YES;
    [_bigImg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)]];
    [view addSubview:_bigImg];
    [_bigImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.equalTo(view.mas_left).with.offset(cell_left_padding);
        make.height.equalTo(@(bigImg_H_W));
        make.width.equalTo(@(bigImg_H_W));
    }];
    
    UIView *rightView = [UIView new];
    [view addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-cell_right_padding));
        make.top.equalTo(@(0));
        make.height.equalTo(@(bigImg_H_W));
        make.width.equalTo(@(smallImg_H_W));
    }];
    
    CGFloat smallPadding = bigImg_H_W-smallImg_H_W*2;
    
    for (int i = 0; i < 2; i++) {
        ImgAndPriceView *imgPriV = [[ImgAndPriceView alloc] initWithFrame:CGRectMake(0, (smallPadding+smallImg_H_W)*i, smallImg_H_W, smallImg_H_W)];
        
        [rightView addSubview:imgPriV];
        _imgPriV=imgPriV;
        imgPriV.tag = i+100;
        [imgPriV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)]];
    }
}

- (void)clickAction:(UITapGestureRecognizer *)tap
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickActionWithDPlayCellDelegate:forIndexTags:)]) {
        [_delegate clickActionWithDPlayCellDelegate:self forIndexTags:tap.view.tag];
    }
}


-(void)setHotpeoplemodel:(NSMutableArray<DDXPlateModel *> *)hotpeoplemodel{
    _hotpeoplemodel=hotpeoplemodel;
        if (hotpeoplemodel.count!=0) {
          [_bigImg  sd_setImageWithURL:[NSURL URLWithString:hotpeoplemodel[0].imageUrl] placeholderImage:[UIImage imageWithColor:DefaultImgBgColor]];
            if (hotpeoplemodel.count==2){
            _imgPriV=[self viewWithTag:100];
            _imgPriV.priceLb.text=[NSString stringWithFormat:@"%.2f",hotpeoplemodel[1].shopPrice];
            [_imgPriV.imageV  sd_setImageWithURL:[NSURL URLWithString:hotpeoplemodel[1].imageUrl] placeholderImage:[UIImage imageWithColor:DefaultImgBgColor]];
            }
            else{
            _imgPriV=[self viewWithTag:100];
            [_imgPriV.imageV  sd_setImageWithURL:[NSURL URLWithString:hotpeoplemodel[1].imageUrl] placeholderImage:[UIImage imageWithColor:DefaultImgBgColor]];
            _imgPriV.priceLb.text=[NSString stringWithFormat:@"%.2f",hotpeoplemodel[1].shopPrice];
            _imgPriV=[self viewWithTag:101];
            [_imgPriV.imageV  sd_setImageWithURL:[NSURL URLWithString:hotpeoplemodel[2].imageUrl] placeholderImage:[UIImage imageWithColor:DefaultImgBgColor]];
            _imgPriV.priceLb.text=[NSString stringWithFormat:@"%.2f",hotpeoplemodel[2].shopPrice];
            }
         }
}


//-(void)setDplaymodel:(NSMutableArray<DDXPlateModel *> *)dplaymodel{
//    _dplaymodel=dplaymodel;
//    if (dplaymodel.count!=0) {
//        [_bigImg  sd_setImageWithURL:[NSURL URLWithString:dplaymodel[0].imageUrl] placeholderImage:[UIImage imageWithColor:DefaultImgBgColor]];
//        if (dplaymodel.count==2){
//            _imgPriV=[self viewWithTag:100];
//            [_imgPriV.imageV  sd_setImageWithURL:[NSURL URLWithString:dplaymodel[1].imageUrl] placeholderImage:[UIImage imageWithColor:DefaultImgBgColor]];
//        }
//        else{
//            _imgPriV=[self viewWithTag:100];
//            [_imgPriV.imageV  sd_setImageWithURL:[NSURL URLWithString:dplaymodel[1].imageUrl] placeholderImage:[UIImage imageWithColor:DefaultImgBgColor]];
//            _imgPriV=[self viewWithTag:101];
//            [_imgPriV.imageV  sd_setImageWithURL:[NSURL URLWithString:dplaymodel[2].imageUrl] placeholderImage:[UIImage imageWithColor:DefaultImgBgColor]];
//        }
//    }
//}






@end
