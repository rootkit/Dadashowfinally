//
//  GoodsOrderCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/15.
//  Copyright © 2017年 李萍. All rights reserved.
//

/****我的订单列表商品订单cell ****/
#import <UIKit/UIKit.h>
#import "DDXGoodsOrderModel.h"

#define rating kScreen_Width/375

@class GoodsOrderCell;
@protocol GoodsOrderCellDelegate <NSObject>

- (void)clickBtnActionWithGoodsOrderCell:(GoodsOrderCell *)cell andBtnTag:(NSInteger)tag;
- (void)clickPushToGoodsDetail:(GoodsOrderCell *)cell;

@end

#define GoodsOrderCellIdentifier @"GoodsOrderCell"
@interface GoodsOrderCell : UITableViewCell

+(instancetype)returnReuseCellFormTableView:(UITableView *)tableView
                                  indexPath:(NSIndexPath *)indexPath
                                 identifier:(NSString *)identifierString;

@property (nonatomic, assign) GoodsOrderTypes orderTypes;
@property (nonatomic, weak) id <GoodsOrderCellDelegate> delegate;
@property (nonatomic, strong) DDXGoodsOrderModel *goodsOrderModel;

@end
