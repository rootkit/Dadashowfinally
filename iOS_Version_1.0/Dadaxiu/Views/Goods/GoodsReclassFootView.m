//
//  GoodsReclassFootView.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/9.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "GoodsReclassFootView.h"

@implementation GoodsReclassFootView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view = [[UIView alloc] initWithFrame:frame];
        view.backgroundColor = BackCellColor;
        [self addSubview:view];
    }
    return self;
}

+ (instancetype)returnResueCellFormTableView:(UICollectionView *)collectionView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier
{
    GoodsReclassFootView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifier forIndexPath:indexPath];
    
    return footView;
}

@end
