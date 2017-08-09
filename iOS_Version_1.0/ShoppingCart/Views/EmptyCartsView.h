//
//  EmptyCartsView.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/18.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EmptyCartsViewDelegate <NSObject>

- (void)clickForJustLookAction;

@end

@interface EmptyCartsView : UIView

@property (nonatomic, weak) id <EmptyCartsViewDelegate> delegate;

@end
