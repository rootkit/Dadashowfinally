//
//  FWTDetailViewController.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/4/26.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FWContentItem;
@interface FWTDetailViewController : UIViewController

- (instancetype)initWithContentId:(NSInteger)contentId isResignFirstRe:(BOOL)isResig contentItem:(FWContentItem *)contentItem;

@end
