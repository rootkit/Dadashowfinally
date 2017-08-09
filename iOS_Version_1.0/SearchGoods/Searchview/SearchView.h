//
//  SearchView.h
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/31.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchView : UIView
@property(nonatomic,strong)void(^searchblock)(NSString* seachstr);
@property(nonatomic,strong)void(^cancelblock)();

@end
