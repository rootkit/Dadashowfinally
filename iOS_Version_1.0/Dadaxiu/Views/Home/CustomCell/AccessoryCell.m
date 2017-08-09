//
//  AccessoryCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/12.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "AccessoryCell.h"
#import "ImgAndPriceView.h"
#import "UIImageView+WebCache.h"
#define cell_top_padding 15* kScreen_Width / 375
#define cell_left_padding 12
#define cell_bottom_padding cell_top_padding
#define cell_right_padding cell_left_padding

#define IMG_W (kScreen_Width-2*cell_left_padding)
#define IMG_H 200*IMG_W/351

#define img_H_W 113*IMG_W/351
#define img_img_padding 5*IMG_W/351

#define bottom_img_padding (kScreen_Width-2*cell_left_padding - img_H_W*3)/2

@interface AccessoryCell ()

@property (nonatomic, strong) UIImageView *IMG;


@end

@implementation AccessoryCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imagecount=[Carcenter sharedCount].carcentercount;
        self.tammycount=[Tammytangs sharedTcount].tammycount;
        NSLog(@"%ld", (long)[Tammytangs sharedTcount].tammycount);
        [self layoutSubviewCell];
        
        
    }
    return  self;
}



+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier
{
    AccessoryCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
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
    
    _IMG = [UIImageView new];
    _IMG.image =[UIImage imageWithColor:DefaultImgBgColor];
    [view addSubview:_IMG];
    _IMG.userInteractionEnabled = YES;
    [_IMG addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickIMGAction:)]];
    [_IMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.equalTo(@(cell_left_padding));
        make.width.equalTo(@(IMG_W));
        make.height.equalTo(@(IMG_H));
    }];
    
    UIView *botview = [UIView new];
    [view addSubview:botview];
    [botview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(cell_left_padding));
        make.top.equalTo(_IMG.mas_bottom).with.offset(img_img_padding);
        make.height.equalTo(@(img_H_W));
        make.width.equalTo(@(IMG_W));
    }];
   for(int i = 0; i <3; i++) {
        ImgAndPriceView *imgPriV = [[ImgAndPriceView alloc] initWithFrame:CGRectMake((img_H_W+bottom_img_padding)*i, 0, img_H_W, img_H_W)];
        [botview addSubview:imgPriV];
        imgPriV.tag = i+100;
        [imgPriV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)]];
    }
}

#pragma mark - tap action
- (void)clickAction:(UITapGestureRecognizer *)tap
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickActionWithAccessoryCell:forIndexTags:)]) {
        [_delegate clickActionWithAccessoryCell:self forIndexTags:tap.view.tag];
    }
}

- (void)clickIMGAction:(UITapGestureRecognizer *)tap
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickActionWithAccessoryCell:forIndexTags:)]) {
        [_delegate clickActionWithAccessoryCell:self forIndexTags:99];
    }
}


-(void)setCartiermodel:(NSMutableArray<DDXPlateModel *> *)cartiermodel{
    
    _cartiermodel=cartiermodel;
    if (cartiermodel.count!=0) {
    [_IMG  sd_setImageWithURL:[NSURL URLWithString:cartiermodel[0].imageUrl] placeholderImage:[UIImage imageWithColor:DefaultImgBgColor]];
    }
    for (int i=0; i<self.imagecount-1; i++) {
        ImgAndPriceView *imgPriV=[self viewWithTag:i+100];
        [imgPriV.imageV sd_setImageWithURL:[NSURL URLWithString:cartiermodel[i+1].imageUrl] placeholderImage:[UIImage imageWithColor:DefaultImgBgColor]];
        imgPriV.priceLb.text=[NSString stringWithFormat:@"%.2f",cartiermodel[i+1].shopPrice];
    }
}



//-(void)setTammymodel:(NSMutableArray<DDXPlateModel *> *)tammymodel{
//    _tammymodel=tammymodel;
//    if (tammymodel.count!=0) {
//        [_IMG  sd_setImageWithURL:[NSURL URLWithString:tammymodel[0].imageUrl] placeholderImage:[UIImage imageWithColor:DefaultImgBgColor]];
//    }
//    for (int i=0; i<self.tammycount-1; i++) {
//        ImgAndPriceView *imgPriV=[self viewWithTag:i+100];
//        [imgPriV.imageV sd_setImageWithURL:[NSURL URLWithString:tammymodel[i+1].imageUrl] placeholderImage:[UIImage imageWithColor:DefaultImgBgColor]];
//    }
//    
//}

@end
