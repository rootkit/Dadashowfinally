//
//  CardScrollView.m
//  TestScrollCardView
//
//  Created by ping_L on 2017/5/12.
//  Copyright © 2017年 ping_L. All rights reserved.
//

#import "CardScrollView.h"
#import "CardScrollViewFlowLayout.h"
#import "CardScrollViewCell.h"
#import "DDXHomeModel.h"
@interface CardScrollView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    NSInteger _currentIndex;
    CGFloat _dragStartX;
    CGFloat _dragEndX;
    
    CGFloat itemCellWidth;//卡片宽度
    CGFloat itemCellHeight;//卡片高度
    CGFloat itemCellSpacing;//卡片间距
}

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation CardScrollView

- (instancetype)initWithFrame:(CGRect)frame
                 forItemWidth:(CGFloat)itemWidth
                forItemHeight:(CGFloat)itemHeight
               forItemSpacing:(CGFloat)itemSpacing
{
    self = [super initWithFrame:frame];
    if (self) {
        itemCellWidth = itemWidth;
        itemCellHeight = itemHeight;
        itemCellSpacing = itemSpacing;
        
        [self layoutUI];
    }
    return self;
}

- (void)layoutUI
{
    self.backgroundColor = [UIColor whiteColor];
    
    CardScrollViewFlowLayout *flowLayout = [[CardScrollViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(itemCellWidth, itemCellHeight)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setMinimumLineSpacing:itemCellSpacing];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    _collectionView.showsHorizontalScrollIndicator = false;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[CardScrollViewCell class] forCellWithReuseIdentifier:CardScrollViewCellIdentifier];
    [_collectionView setUserInteractionEnabled:YES];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self addSubview:_collectionView];
}

#pragma mark CollectionDelegate

//配置cell居中
-(void)fixCellToCenter
{
    //最小滚动距离
    float dragMiniDistance = self.bounds.size.width/20.0f;
    
    if (_dragStartX -  _dragEndX >= dragMiniDistance) {
        _currentIndex -= 1;//向右
    } else if(_dragEndX -  _dragStartX >= dragMiniDistance){
        _currentIndex += 1;//向左
    }
    
    NSInteger maxIndex = [_collectionView numberOfItemsInSection:0] - 1;
    _currentIndex = _currentIndex <= 0 ? 0 : _currentIndex;
    _currentIndex = _currentIndex >= maxIndex ? maxIndex : _currentIndex;
    
    [self scrollToCenter];
}

-(void)scrollToCenter
{
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];

    if ([_delegate respondsToSelector:@selector(cardScrollViewDidSelectedAt:)]) {
        [_delegate cardScrollViewDidSelectedAt:_currentIndex];
    }
}

#pragma mark -
#pragma mark CollectionDelegate
//手指拖动开始
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _dragStartX = scrollView.contentOffset.x;
}

//手指拖动停止
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    _dragEndX = scrollView.contentOffset.x;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self fixCellToCenter];
    });
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _currentIndex = indexPath.row;
    [self scrollToCenter];
}

#pragma mark -
#pragma mark CollectionDataSource


//设置左右缩进
-(CGFloat)collectionInset
{
    return self.bounds.size.width/2.0f - itemCellWidth/2.0f;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, [self collectionInset]);
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([Brandsselectarray sharedArray].brandselectarray.count==0) {
        return 1;
    }else{
       return  [Brandsselectarray sharedArray].brandselectarray.count;
    }
 }

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CardScrollViewCell *cell = [CardScrollViewCell returnResueCellFormTableView:self.collectionView indexPath:indexPath identifier:CardScrollViewCellIdentifier];
    
    
    return cell;
}
@end
