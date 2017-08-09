//
//  ShopClassifyView.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/19.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ShopClassifyViewIdentifier @"ShopClassifyView"

@interface ShopClassifyView : UICollectionReusableView

+ (instancetype)returnResueCellFormCollectionView:(UICollectionView *)collectionView
                                        indexPath:(NSIndexPath *)indexPath
                                       identifier:(NSString *)identifier;


@property (strong, nonatomic) UIButton *pushBtn;
@property (nonatomic, copy) NSString *title;

@end
