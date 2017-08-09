//
//  OrderGoodsCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/4.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDXShopCartGoods.h"

#define OrderGoodsCellIdentifierString @"OrderGoodsCell"
#define rating kScreen_Width/375

@class OrderGoodsCell;
@protocol OrderGoodsCellDelegate <NSObject>

- (void)clickOrderForGoodsStore:(OrderGoodsCell *)cell;
- (void)clickOrderForGoodsDetail:(OrderGoodsCell *)cell;

@end

@interface OrderGoodsCell : UITableViewCell

+(instancetype)returnReuseCellFormTableView:(UITableView *)tableView
                                  indexPath:(NSIndexPath *)indexPath
                                 identifier:(NSString *)identifierString;

@property (nonatomic, weak) id <OrderGoodsCellDelegate> delegate;

@property (nonatomic, strong) DDXShopCartGoods *goods;

@end
