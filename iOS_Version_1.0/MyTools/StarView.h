//
//  StarView.h
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/5.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^returnBlock) (CGFloat score);
@interface StarView : UIControl

// 当前评分制
@property (nonatomic, assign) float currentValue;
@property (nonatomic, copy) returnBlock returnB;
@end
