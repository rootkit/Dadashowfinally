//
//  SecondBaseController.h
//  testSecondsView
//
//  Created by ping_L on 2017/6/1.
//  Copyright © 2017年 ping_L. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondBaseController : UITableViewController

@property (nonatomic, strong) void (^offSet)(CGFloat, UITableViewController *);

- (void)setTableViewOffSetY:(CGFloat)offSetY;

@end
