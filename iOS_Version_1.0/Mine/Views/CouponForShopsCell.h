//
//  CouponForShopsCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/20.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

#define rating kScreen_Width/375

#define cell_padding_left 15*rating
#define cell_padding_right cell_padding_left
#define cell_padding_top 10*rating
#define cell_padding_bottom cell_padding_top

#define coupon_Width 345*rating
#define coupon_Height 100*rating

@class CouponForShopsCell, DDXCouponModel;
@protocol CouponForShopsCellDelegate <NSObject>

- (void)clickBtnActionWithCouponForShopsCell:(CouponForShopsCell *)cell;

@end

#define CouponForShopsCellIdentifier @"CouponForShopsCell"
@interface CouponForShopsCell : UITableViewCell

+(instancetype)returnReuseCellFormTableView:(UITableView *)tableView
                                  indexPath:(NSIndexPath *)indexPath
                                 identifier:(NSString *)identifierString;

@property (nonatomic, assign) GoodsOrderTypes orderTypes;
@property (nonatomic, weak) id <CouponForShopsCellDelegate> delegate;
@property (nonatomic, strong) DDXCouponModel *model;


@end



@interface DDXCouponModel : NSObject

@property (nonatomic, assign) NSInteger price;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, assign) BOOL isUsing;

@end
