//
//  GetCouponPopView.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/26.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

/***** GetCouponPopManager *****/

@interface GetCouponPopManager : NSObject

+ (instancetype)popViewManager;
- (void)showPopViewWithCouponData:(NSArray *)data withShopName:(NSString *)name;
- (void)hiddenPopView;

@end


/***** GetCouponPopView *****/

@protocol GetCouponPopViewDelegate <NSObject>

@end

@interface GetCouponPopView : UIView

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *popContentView;

+ (instancetype)showCouponPopViewWithData:(NSArray *)data withShopName:(NSString *)name;

@end
