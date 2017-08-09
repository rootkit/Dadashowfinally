//
//  CenterSurroundButtonView.h
//  iOS_Version_1.0
//
//  Created by 李萍 on 2017/4/16.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CenterSurroundButtonManager : NSObject

+ (instancetype)centerSurroundBtnManager;
- (void)showCenterSurroundButtonViewWithType;
- (void)hiddencenterSurroundBtnBoard;

@end

@interface CenterSurroundButtonView : UIView

@property (nonatomic, weak) UIView *bgView;

+ (instancetype)showCenterSurroundButtonViewWithTypeTag;

@end
