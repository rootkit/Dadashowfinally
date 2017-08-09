//
//  MineHeaderView.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/5.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

/******  个人中心headView *******/
@protocol MineHeaderViewDelegate <NSObject>

- (void)chooseAction:(NSInteger)tag;
- (void)chooseUserPortrait;
- (void)chooseVMember;

@end

@interface MineHeaderView : UIView

@property (nonatomic, strong) UIImageView *headIMG;
@property (nonatomic, weak) id <MineHeaderViewDelegate> delegate;

@property (nonatomic, strong) DDXUserinfo *userInfo;

@end

/***** ImageButtonW ******/
@interface ImageButtonV : UIButton

- (id)initWithFrame:(CGRect)frame andImageName:(NSString *)imageName andText:(NSString *)string;

@end

/***** ImageButtonH ******/
@interface ImageButtonH : UIButton

- (id)initWithFrame:(CGRect)frame andImageName:(NSString *)imageName andText:(NSString *)string;

@end
