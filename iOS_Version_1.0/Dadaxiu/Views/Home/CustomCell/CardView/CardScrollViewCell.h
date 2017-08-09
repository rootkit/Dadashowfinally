//
//  CardScrollViewCell.h
//  TestScrollCardView
//
//  Created by ping_L on 2017/5/12.
//  Copyright © 2017年 ping_L. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CardScrollViewCellIdentifier @"CardScrollViewCell"
@interface CardScrollViewCell : UICollectionViewCell

+ (instancetype)returnResueCellFormTableView:(UICollectionView *)collectionView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@end
