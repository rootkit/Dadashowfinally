//
//  AdvertisementCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/13.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "AdvertisementCell.h"

#define advertise_H 140* kScreen_Width / 375

@interface AdvertisementCell () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scroImgView;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UIImageView *advImageView;

@end

@implementation AdvertisementCell

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
    AdvertisementCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
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
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, advertise_H)];
//    imgV.image = [UIImage imageNamed:@"good_default"];
    [self.contentView addSubview:imgV];
    imgV.userInteractionEnabled = YES;
    [imgV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)]];
    self.advImageView = imgV;
    /*
    _scroImgView = [UIScrollView new];
    _scroImgView.pagingEnabled = YES;
    _scroImgView.showsHorizontalScrollIndicator = NO;
    _scroImgView.showsVerticalScrollIndicator = NO;
    [view addSubview:_scroImgView];
    
    [_scroImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(@(0));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
    }];
    
    //假设数组为5
    _scroImgView.contentSize = CGSizeMake(kScreen_Width, advertise_H);
    
    for (int i = 0; i < 1; i++) {
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreen_Width*i, 0, kScreen_Width, advertise_H)];
        imgV.image = [UIImage imageNamed:@"good_default"];
        [_scroImgView addSubview:imgV];
        imgV.tag = i+1;
        imgV.userInteractionEnabled = YES;
        [imgV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)]];
    }
    
    if(!self.timer) {
        self.timer = [NSTimer timerWithTimeInterval:4.0f target:self selector:@selector(scrollToNextPage:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        [self.timer fire];
    }
    */
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

- (void)clickAction:(UITapGestureRecognizer *)tap
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickActionWithAdvertisementCellDelegate:forIndexTags:)]) {
        [_delegate clickActionWithAdvertisementCellDelegate:self forIndexTags:tap.view.tag];
    }
}

#pragma mark - set
- (void)setAdvertisementImage:(UIImage *)advertisementImage
{
    self.advImageView.image = advertisementImage;
}

@end
