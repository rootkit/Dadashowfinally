//
//  CardScrollViewCell.m
//  TestScrollCardView
//
//  Created by ping_L on 2017/5/12.
//  Copyright © 2017年 ping_L. All rights reserved.
//

#import "CardScrollViewCell.h"
#import "DDXHomeModel.h"
#import "UIImageView+WebCache.h"
@interface CardScrollViewCell ()

@property (nonatomic, strong) UIImageView *IMG;

@end

@implementation CardScrollViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self layoutCell];
        
    }
    return self;
}

+ (instancetype)returnResueCellFormTableView:(UICollectionView *)collectionView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier
{
    CardScrollViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    item.IMG.image = [UIImage imageNamed:@"img_04"];
//    if (!([Brandsselectarray sharedArray].brandselectarray.count==0)) {
//         DDXPlateModel* model=[Brandsselectarray sharedArray].brandselectarray[indexPath.row];
//        [item.IMG sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageWithColor:DefaultImgBgColor]];
        NSLog(@"数组%@",[Brandsselectarray sharedArray].brandselectarray);

//    }
    return item;
}

- (void)layoutCell
{
    _IMG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    _IMG.backgroundColor = DefaultImgBgColor;
    [self.contentView addSubview:_IMG];
}

@end
