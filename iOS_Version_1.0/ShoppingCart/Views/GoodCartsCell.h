//
//  GoodCartsCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/3.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDXShopCartGoods.h"

#define GoodsCartsCellIdentifier  @"GoodCartsCell"

@class GoodCartsCell;
@protocol GoodCartsCellDelegate <NSObject>

- (void)chooseGoodsWithGoodCartsCell:(GoodCartsCell *)cell;
- (void)changeGoodsNumActionWithGoodCartsCell:(GoodCartsCell *)cell forTag:(NSInteger)tag;

@end

@interface GoodCartsCell : UITableViewCell

@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) UIButton *deleteBtn;

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@property (nonatomic, weak) id <GoodCartsCellDelegate> delegate;
//@property (nonatomic, assign) BOOL isChooseGoods;
//@property (nonatomic, assign) BOOL changeEditingStyle;
@property (nonatomic, strong) DDXShopCartGoods *goods;

+ (UIImage *)goodsSelectedImage;
+ (UIImage *)unGoodsSelectedImage;

@end
