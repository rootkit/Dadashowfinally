//
//  HomeVedioCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/12.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "HomeVedioCell.h"

#define cell_top_padding 15* kScreen_Width / 375
#define cell_left_padding 12
#define cell_bottom_padding cell_top_padding
#define cell_right_padding cell_left_padding

#define scroV_H 149* kScreen_Width / 375

@interface HomeVedioCell ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scroImgView;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation HomeVedioCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _currentIndex = 0;
        [self layoutSubviewCell];
    }
    return  self;
}

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier
{
    HomeVedioCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
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
    _scroImgView.pagingEnabled = YES;
    _scroImgView.showsHorizontalScrollIndicator = NO;
    _scroImgView.showsVerticalScrollIndicator = NO;
    _scroImgView.backgroundColor = ThemeColor;
    _scroImgView.delegate = self;
    [view addSubview:_scroImgView];
    
    [_scroImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.bottom.equalTo(view.mas_bottom).with.offset(0);
        make.height.equalTo(@(scroV_H));
    }];
    _scroImgView.contentSize = CGSizeMake(kScreen_Width*3, scroV_H);
    
    for (int i = 0; i < 3; i++) {
        ImgTitleView *imgTitlev = [[ImgTitleView alloc] initWithFrame:CGRectMake(kScreen_Width*i, 0, kScreen_Width, scroV_H)];
        [_scroImgView addSubview:imgTitlev];
        imgTitlev.tag = i+1;
        [imgTitlev addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)]];
    }
    
    if(!self.timer) {
        self.timer = [NSTimer timerWithTimeInterval:4.0f target:self selector:@selector(scrollToNextPage:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        [self.timer fire];
    }
}

#pragma mark - 自动滚动
- (void)scrollToNextPage:(NSTimer *)timer
{
    _currentIndex++;
    if (_currentIndex >= 3) {//设置图片数组为3
        _currentIndex = 0;
    }
    [_scroImgView setContentOffset:CGPointMake(_currentIndex*CGRectGetWidth(_scroImgView.frame), 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _currentIndex = scrollView.contentOffset.x/CGRectGetWidth(self.frame);
}

#pragma mark - /*点击滚动图片*/
- (void)clickAction:(UITapGestureRecognizer *)tap
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickActionWithHomeVedioCell:forIndexTags:)]) {
        [_delegate clickActionWithHomeVedioCell:self forIndexTags:tap.view.tag];
    }
}

@end

///////

#define bottomView_H 24* kScreen_Width / 375
#define imgTitle_Font 12* kScreen_Width / 375

@interface ImgTitleView ()

@property (nonatomic, strong) UIImageView *img;
@property (nonatomic, strong) UILabel *Lb;

@end

@implementation ImgTitleView

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
    _img = [UIImageView new];
    _img.image = [UIImage imageNamed:@"good_default"];
//    _img.backgroundColor = [UIColor whiteColor];
    [self addSubview:_img];
    
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(@(0));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
    }];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, scroV_H-bottomView_H, kScreen_Width, bottomView_H)];
    [self layerForCycleScrollViewTitle:bottomView];
    [_img addSubview:bottomView];
    
    _Lb = [UILabel new];
    _Lb.text = @"《超体2》我，无处不在";
    _Lb.font = [UIFont systemFontOfSize:imgTitle_Font];
    _Lb.textColor = [UIColor whiteColor];
    [_img addSubview:_Lb];
    [_Lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(cell_left_padding));
        make.right.equalTo(@(-cell_right_padding));
        make.bottom.equalTo(_img.mas_bottom).with.offset(-5);
    }];
}

/* 标题背景添加渐变色 */
- (void)layerForCycleScrollViewTitle:(UIView *)bottomView
{
    CAGradientLayer *layer = [CAGradientLayer new];
    layer.colors = @[
                     (__bridge id)[UIColor colorWithHex:0xffffff alpha:0.6].CGColor,
                     (__bridge id)[UIColor colorWithHex:0x000000 alpha:0.6].CGColor,
                     ];
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(0, 1);
    layer.frame = bottomView.bounds;
    
    [bottomView.layer addSublayer:layer];
}

@end

