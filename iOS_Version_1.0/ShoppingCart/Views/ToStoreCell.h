//
//  ToStoreCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/7.
//  Copyright © 2017年 李萍. All rights reserved.
//

/****** 到店自提cell（确认订单之后的选择快递方式） ******/
#import <UIKit/UIKit.h>

#define ToStoreCellIdentifierString @"ToStoreCell"
#define rating kScreen_Width/375

@class ToStoreCell;
@protocol ToStoreCellDelegate <NSObject>

- (void)contactForToStoreCell:(ToStoreCell *)cell;
- (void)chooseForToStoreCell:(ToStoreCell *)cell;

@end

@interface ToStoreCell : UITableViewCell

+(instancetype)returnReuseCellFormTableView:(UITableView *)tableView
                                  indexPath:(NSIndexPath *)indexPath
                                 identifier:(NSString *)identifierString;

@property (nonatomic, weak) id <ToStoreCellDelegate> delegate;
@property (nonatomic, assign) BOOL isChoose;

@end
