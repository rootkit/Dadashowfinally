//
//  PopBox.h
//  iOS_Version_1.0
//
//  Created by 李萍 on 2017/4/21.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PopBoxDelegate <NSObject>

- (void)popBoxStartContactAccess:(BOOL)isStart;

@end

@interface PopBox : NSObject

+ (instancetype)popBoxManager;

- (void)showPoxBox;

- (void)hiddenPoxBox;

@property (nonatomic, weak) id <PopBoxDelegate> delegate;

@end


//////////////////

@protocol PopBoxViewDelegate <NSObject>

- (void)startContactAccess:(BOOL)isStart;

@end

@interface PopBoxView : UIView

+ (instancetype)showPopBoxView;

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic, weak) id <PopBoxViewDelegate> delegate;

@end
