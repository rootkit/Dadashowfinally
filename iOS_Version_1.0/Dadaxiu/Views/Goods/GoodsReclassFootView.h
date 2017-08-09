//
//  GoodsReclassFootView.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/9.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

#define GoodsReclassFootViewIdentifier @"GoodsReclassFootView"
@interface GoodsReclassFootView : UICollectionReusableView

+ (instancetype)returnResueCellFormTableView:(UICollectionView *)collectionView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@end
