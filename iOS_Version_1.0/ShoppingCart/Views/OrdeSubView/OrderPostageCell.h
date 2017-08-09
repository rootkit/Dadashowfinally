//
//  OrderPostageCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/4.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrderPostageCell;
@protocol OrderPostageCellDelegate <NSObject>

- (void)postageStateActionDelegate:(OrderPostageCell *)cell;
- (void)postageChooseShopAddressActionDelegate:(OrderPostageCell *)cell;
- (void)postageChooseEditOrderDetailInfoActionDelegate:(OrderPostageCell *)cell withTextfieldMaxY:(CGFloat)maxY;

@end

#define OrderPostageCellIdentifierString @"OrderPostageCell"
#define rating kScreen_Width/375

@interface OrderPostageCell : UITableViewCell

+(instancetype)returnReuseCellFormTableView:(UITableView *)tableView
                                  indexPath:(NSIndexPath *)indexPath
                                 identifier:(NSString *)identifierString;

- (void)setPostageWayChangeForHelpSelf:(BOOL)isSelf;

@property (nonatomic, weak) id <OrderPostageCellDelegate> delegate;

@property (nonatomic, assign) float price;


@end
