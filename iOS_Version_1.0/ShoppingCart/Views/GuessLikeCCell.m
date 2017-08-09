//
//  GuessLikeCCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/4.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "GuessLikeCCell.h"
#import "GuessLikeCell.h"

#define kScreen_W [UIScreen mainScreen].bounds.size.width
#define kScreen_H [UIScreen mainScreen].bounds.size.height
#define item_W (kScreen_W-2*12-10)/2*rating
#define item_H item_W * 234/170*rating
@interface GuessLikeCCell () < UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, GuessLikeItemDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation GuessLikeCCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        [self setupCollectionView];
    }
    return self;
}

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier
{
    GuessLikeCCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setupCollectionView
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(12*rating, 0, (kScreen_W-24)*rating, CGRectGetHeight(self.contentView.frame))];
    [self.contentView addSubview:bottomView];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(item_W, item_H);
    layout.minimumLineSpacing = 10*rating;
    layout.minimumInteritemSpacing = 0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(bottomView.frame), item_H) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [bottomView addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[GuessLikeCell class] forCellWithReuseIdentifier:GuessLikeItemIdentifier];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GuessLikeCell *item = [GuessLikeCell returnResueCellFormTableView:self.collectionView indexPath:indexPath identifier:GuessLikeItemIdentifier];
    item.delegate = self;
    
    return item;
}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 5);
//    
//    return insets;
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark - GuessLikeItemDelegate
- (void)pushGoodsToCart
{
    if (_delegate && [_delegate respondsToSelector:@selector(pushGoodsToCartAction)]) {
        [_delegate pushGoodsToCartAction];
    }
}

@end
