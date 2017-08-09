//
//  CenterBtnBoard.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/16.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CenterBtnManager : NSObject

+ (instancetype)centerBtnManager;
- (void)showCenterBtn;
- (void)hiddenCenterBtnBoard;

@end

/////

@interface CenterBtnBoard : UIView

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *btnView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewBottomPadding;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnViewBottomPadding;

+ (instancetype)showCenterBoard;

@end
