//
//  SQimageMenuShowView.h
//  iOS_Version_1.0
//
//  Created by liping on 2017/4/29.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQimageMenuShowView : UIView
- (id)initWithFrame:(CGRect)frame items:(NSArray <NSString *> *)items imagearry:(NSArray<NSString *> *)imagename showPoint:(CGPoint)showPoint;



@property (strong, nonatomic) UIColor *sq_selectColor; //选后的颜色
@property (strong, nonatomic) UIColor *sq_backGroundColor;
@property (copy, nonatomic) void(^selectBlock)(SQimageMenuShowView *view, NSInteger index);

@property (copy, nonatomic) UIColor *itemTextColor;


- (void)selectBlock:(void(^)(SQimageMenuShowView *view, NSInteger index))block;

- (void)showView;
- (void)dismissView;

@end
