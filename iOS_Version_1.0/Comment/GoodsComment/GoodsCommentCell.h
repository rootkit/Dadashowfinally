//
//  GoodsCommentCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/4/29.
//  Copyright © 2017年 李萍. All rights reserved.
//
/****** 商品评论cell  *****/
#import "FWContentCell.h"
#import "GoodsCommentItem.h"

#define GoodsCommentItemIdentifier @"GoodsCommentItemIdentifier"
@interface GoodsCommentCell : FWContentCell <FWContentCellDelegate>

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@property (nonatomic, strong) GoodsCommentItem *goodsCommentItem;
@property (nonatomic, assign) id <FWContentCellDelegate> delegate;

@end
