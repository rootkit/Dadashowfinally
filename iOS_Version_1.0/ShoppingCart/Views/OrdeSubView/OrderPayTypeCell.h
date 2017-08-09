//
//  OrderPayTypeCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/6.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

#define OrderPayTypeCellIdentifierString @"OrderPayTypeCell"
#define rating kScreen_Width/375

@class OrderPayTypeCell;
@protocol OrderPayTypeCellDelegate <NSObject>

- (void)payChooseEditActionDelegate:(OrderPayTypeCell *)cell withTextfieldMaxY:(CGFloat)maxY;
- (void)payChoosePayTypeActionDelegate:(OrderPayTypeCell *)cell withPayType:(PayTypes)type;

@end


@interface OrderPayTypeCell : UITableViewCell

+(instancetype)returnReuseCellFormTableView:(UITableView *)tableView
                                  indexPath:(NSIndexPath *)indexPath
                                 identifier:(NSString *)identifierString;

@property (nonatomic, weak) id <OrderPayTypeCellDelegate> delegate;

@end
