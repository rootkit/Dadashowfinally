//
//  CouponPopViewCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/26.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CouponPopViewCellIdentifier @"CouponPopViewCell"
@class CouponPopViewCell;
@protocol CouponPopViewCellDelegate <NSObject>

- (void)clickGetCouponAction:(CouponPopViewCell *)cell;

@end

@interface CouponPopViewCell : UITableViewCell

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@property (nonatomic, weak) id <CouponPopViewCellDelegate> delegate;

- (void)changeButtonState:(BOOL)isGet;

@end
