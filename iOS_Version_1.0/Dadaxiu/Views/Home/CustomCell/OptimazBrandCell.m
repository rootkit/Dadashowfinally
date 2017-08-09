//
//  OptimazBrandCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/11.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "OptimazBrandCell.h"
#import "CardView/CardScrollView.h"
#import "DDXHomeModel.h"
#import "UIImageView+WebCache.h"
#import "DDXHomeModel.h"
#define cell_top_padding 15* kScreen_Width / 375
#define cell_left_padding 12
#define cell_bottom_padding cell_top_padding
#define cell_right_padding cell_left_padding

#define scroll_W (kScreen_Width-cell_left_padding-18)
#define scroll_H 160*scroll_W/345
#define ItemSpacing 6* kScreen_Width / 375

#define img_H_W 75* kScreen_Width / 375
#define img_img_padding (kScreen_Width-cell_left_padding*2 - img_H_W*4)/3

#define scroll_img_padding 10* kScreen_Width / 375

@interface OptimazBrandCell () <CardScrollViewDelegate>

@property (nonatomic, strong) CardScrollView *topView;
@property (nonatomic, strong) UIView *bottomView;
@property(nonatomic,strong) UIImageView *imageV ;

@end

@implementation OptimazBrandCell

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
    OptimazBrandCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
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
    _topView = [[CardScrollView alloc] initWithFrame:CGRectMake(cell_left_padding, 0, kScreen_Width-cell_left_padding, scroll_H) forItemWidth:scroll_W forItemHeight:scroll_H forItemSpacing:ItemSpacing];
    _topView.delegate = self;
    [view addSubview:_topView];
    
    _bottomView = [UIView new];
    [view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.mas_bottom).with.offset(scroll_img_padding);
        make.left.equalTo(@(cell_left_padding));
        make.right.equalTo(@(-cell_right_padding));
        make.height.equalTo(@(img_H_W));
    }];
    
    for (int i = 0; i < 4; i++) {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake((img_H_W+img_img_padding)*i, 0, img_H_W, img_H_W)];
        imageV.backgroundColor =DefaultImgBgColor;
        [imageV handleCornerRadiusWithRadius:2];
        [_bottomView addSubview:imageV];
        imageV.tag = i+100;
        imageV.userInteractionEnabled = YES;
        [imageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)]];
        _imageV=imageV;
    }
    
  

}


-(void)layoutSubviews{
    NSLog(@"%@",[Brandsselectarray sharedArray].brandselectarray);
    if ([Brandsselectarray sharedArray].brandselectarray.count>0) {
        
        for (int i=0; i<[Brandsselectarray sharedArray].brandselectarray.count; i++) {
            _imageV = [self viewWithTag:i+100];
            DDXPlateModel* model=[Brandsselectarray sharedArray].brandselectarray[i];
            [_imageV sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageWithColor:DefaultImgBgColor]];
        };
    }
}

#pragma mark - tap action
- (void)clickAction:(UITapGestureRecognizer *)tap
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickOptimazBrandPickWith:forIndexTags:)]) {
        [_delegate clickOptimazBrandPickWith:self forIndexTags:tap.view.tag];
    }
}

- (void)cardScrollViewDidSelectedAt:(NSInteger)index
{
    NSLog(@"选中了：%zd",index);
    if (_delegate && [_delegate respondsToSelector:@selector(clickOptimazBrandBannerPicWith:forIndexTags:)]) {
        [_delegate clickOptimazBrandBannerPicWith:self forIndexTags:index];
    }
}


@end

