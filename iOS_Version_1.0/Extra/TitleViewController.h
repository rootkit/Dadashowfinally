//
//  TitleViewController.h
//  OCScrollTitleAndView
//
//  Created by 李萍 on 16/2/25.
//  Copyright © 2016年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(int, TitleSelectedType)
{
    TitleSelectedTypeWithFoot, //   底部横栏
    TitleSelectedTypeWithBubble,    //字体背影椭圆阴影
};

@protocol TitleViewControllerDelegate <NSObject>

//滚动按钮点击代理方法
/*
 buttonTag 点击按钮的tag值
 */
- (void)delegateActionForScrollButton:(NSInteger)buttonTag;

@end

@interface TitleViewController : UIViewController


/*
 第一个参数：滚动标题数组
 第二个参数：滚动页面数组
 第三个参数：是否固定标题按钮的长度
 第四个参数：是否存在导航栏
 第五个参数：是否存在工具栏
 */
- (instancetype)initWithFrame:(CGRect)viewFrame
                      titles:(NSArray*)titles
                viewControllers:(NSArray*)viewControllers
          andIsFixedTitleLength:(BOOL)isFixed
                    andHasNavig:(BOOL)isHasNav
                   andHasTabbar:(BOOL)isHasTabbar;


@property (nonatomic, weak) id <TitleViewControllerDelegate> myDelegate;

//滚动标题的高度
@property (nonatomic, assign) CGFloat titleScrollViewHeight;

//标题按钮的长度
@property (nonatomic, assign) CGFloat titleButtonWidth;

//标题按钮的背景色
@property (nonatomic, strong) UIColor *buttonBackgroundColor;

//标题按钮未选中时的背景颜色
@property (nonatomic, strong) UIColor *buttonUnSelectedColor;

//标题按钮选中时的背景颜色
@property (nonatomic, strong) UIColor *buttonSelectedColor;

//标题按钮未选中时字体的背景颜色
@property (nonatomic, strong) UIColor *buttonTitleUnSelectedColor;

//标题按钮选中时字体的背景颜色
@property (nonatomic, strong) UIColor *buttonTitleSelectedColor;

//标题下标滚动条高度
@property (nonatomic, assign) CGFloat footHeight;

///标题下标滚动条未选中时的背景颜色
@property (nonatomic, strong) UIColor *footerUnSelectedColor;

//滚动标题选中的效果类型
@property (nonatomic) TitleSelectedType selectedType;

//滚动标题选中类型为泡泡时的圆角弧度
@property (nonatomic, assign) CGFloat bubbleCornerRadius;

//标题字体大小
@property (nonatomic, strong) UIFont *font;

//默认初始化时显示第几个视图
@property (nonatomic, assign) NSInteger selectedIndex;

@end
