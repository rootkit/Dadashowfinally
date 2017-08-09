//
//  SalesReturnReasonPopView.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/12.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

/**** 商品申请退款原因选择弹出框 ****/
#import <Foundation/Foundation.h>

/****  manafer   ****/

@protocol SalesReturnReasonManagerDelegate <NSObject>

- (void)delegateForSalesReturnReasonManager:(NSInteger)selectedIndex;

@end

@interface SalesReturnReasonManager : NSObject

+ (instancetype)salesReturnReasonManager;
- (void)showSalesReturnReasonWithStateType:(NSArray *)states;
- (void)hiddenStateBoard;

@property (nonatomic, weak) id <SalesReturnReasonManagerDelegate> delegate;

@end


/****  board   ****/

@protocol PostageStateBoardDelegate <NSObject>

- (void)chooseSalesReturnReasonByBoard:(NSInteger)selectedIndex;

@end

@interface SalesReturnReasonPopView : UIView

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (nonatomic, weak) id <PostageStateBoardDelegate> delegate;

+ (instancetype)showStateBoardWithStateType:(NSArray *)states;

@end
