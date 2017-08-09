//
//  PostageStateManager.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/5.
//  Copyright © 2017年 李萍. All rights reserved.
//

/**** 商品订单快递选择弹出框 ****/
#import <Foundation/Foundation.h>

/****  manafer   ****/

@protocol PostageStateManagerDelegate <NSObject>

- (void)delegateForPostageManeger:(NSInteger)selectedIndex;

@end

@interface PostageStateManager : NSObject

+ (instancetype)postagestateManager;
- (void)showPostageStateWithStateType:(NSArray *)states;
- (void)hiddenStateBoard;

@property (nonatomic, weak) id <PostageStateManagerDelegate> delegate;

@end


/****  board   ****/

@protocol PostageStateBoardDelegate <NSObject>

- (void)choosePostageByBoard:(NSInteger)selectedIndex;

@end

@interface PostageStateBoard : UIView

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (nonatomic, weak) id <PostageStateBoardDelegate> delegate;

+ (instancetype)showStateBoardWithStateType:(NSArray *)states;

@end
