//
//  SelectedLimitedCell.m
//  testSecondsView
//
//  Created by ping_L on 2017/6/2.
//  Copyright © 2017年 ping_L. All rights reserved.
//

#import "SelectedLimitedCell.h"
#import "SelectedLimitedCollectCell.h"

#define left_padding 12
#define right_padding left_padding

#define info_font 13*kScreen_Width/375
#define info_height 38*kScreen_Width/375
#define headView_height 14*kScreen_Width/375
#define headView_width 60*kScreen_Width/375

#define thingView_Height 165*kScreen_Width/375
#define collectionview_padding 8*kScreen_Width/375
#define item_height 165*kScreen_Width/375
#define item_width 105*kScreen_Width/375
#define item_padding 10*kScreen_Width/375

@interface SelectedLimitedCell () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *thingView;

@end

@implementation SelectedLimitedCell

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
    SelectedLimitedCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)layoutSubviewCell
{
    UILabel *label = [UILabel new];
    label.text = @"距离全场结束还剩 16：40：06";
    label.font = [UIFont systemFontOfSize:info_font];
    label.textColor = [UIColor colorWithHex:0x515151];
    label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.top.equalTo(@(0));
        make.height.equalTo(@(info_height));
    }];
    
    /////
    UIView *headLine = [UIView new];
    headLine.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:headLine];
    
    [headLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.top.equalTo(label.mas_bottom).with.offset(0);
        make.height.equalTo(@(headView_height));
    }];
    
    UILabel *titleLb = [UILabel new];
    titleLb.text = @"精选秒杀";
    titleLb.font = [UIFont systemFontOfSize:info_font];
    titleLb.textColor = ThemeColor;
    titleLb.textAlignment = NSTextAlignmentCenter;
    [headLine addSubview:titleLb];
    
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headLine);
        make.centerY.equalTo(headLine);
        make.width.equalTo(@(headView_width));
    }];
    
    UILabel *leftLine = [UILabel new];
    leftLine.text = @"....................................";
    leftLine.font = [UIFont systemFontOfSize:info_font];
    leftLine.textColor = ThemeColor;
    leftLine.textAlignment = NSTextAlignmentCenter;
    [headLine addSubview:leftLine];
    
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headLine).with.offset(-3);
        make.left.equalTo(@(12));
        make.right.equalTo(titleLb.mas_left).with.offset(-12);
    }];
    
    UILabel *rightLine = [UILabel new];
    rightLine.text = @"....................................";
    rightLine.font = [UIFont systemFontOfSize:info_font];
    rightLine.textColor = ThemeColor;
    rightLine.textAlignment = NSTextAlignmentCenter;
    [headLine addSubview:rightLine];
    
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headLine).with.offset(-3);
        make.right.equalTo(@(-12));
        make.left.equalTo(titleLb.mas_right).with.offset(12);
    }];
    
    /////
    UIView *thingView = [UIView new];
    thingView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:thingView];
    
    [thingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(left_padding));
        make.right.equalTo(@(-right_padding));
        make.top.equalTo(headLine.mas_bottom).with.offset(0);
        make.bottom.equalTo(@(0));
    }];
    self.thingView = thingView;
    [thingView addSubview:self.collectionView];
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        UICollectionView *collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 2 , kScreen_Width-left_padding-right_padding , thingView_Height) collectionViewLayout:flowLayout];
        collectionView.showsHorizontalScrollIndicator=NO;//隐藏滚动条
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [collectionView setBackgroundColor:[UIColor whiteColor]];
        //注册Cell，必须要有
        [collectionView registerClass:[SelectedLimitedCollectCell class] forCellWithReuseIdentifier:SelectedLimitedCollectCellIdentifier];
        _collectionView = collectionView;

    }
    return _collectionView;
}

#pragma mark - UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SelectedLimitedCollectCell *cell = [SelectedLimitedCollectCell returnResueCellFormTableView:self.collectionView indexPath:indexPath identifier:SelectedLimitedCollectCellIdentifier];
    
    return cell;
}

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(item_width, item_height);
}
//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return item_padding;
}

//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//定义每个UICollectionView 的 margin缝隙
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, collectionview_padding, 0, collectionview_padding);
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"collection selected action %ld", (long)indexPath.row);
}

@end
