//
//  TagsView.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/2.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TagsViewDelegate <NSObject>

- (void)selectBtnClickAction:(NSInteger)index;

@end

@interface TagsView : UIView

- (instancetype)initWithMoreTags:(NSArray *)tags;

@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, weak) id <TagsViewDelegate> delegate;



@end
