//
//  SecondBaseController.m
//  testSecondsView
//
//  Created by ping_L on 2017/6/1.
//  Copyright © 2017年 ping_L. All rights reserved.
//

#import "SecondBaseController.h"

#define headAndTitle (150+50)*kScreen_Width/375
#define headView 150*kScreen_Width/375

@interface SecondBaseController ()

@property (nonatomic, assign) NSInteger index;

@end

@implementation SecondBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, headAndTitle)];;
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(headAndTitle, 0, 0, 0);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [UIView new];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTableViewOffSetY:) name:@"kChangeTableViewOffSetYNotification" object:nil];
}

- (void)changeTableViewOffSetY:(NSNotification *)noti {
    NSInteger index = [noti.object integerValue];
    self.index = index;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.tableView.frame.origin.x / self.view.frame.size.width != self.index) {
        return;
    }
    !self.offSet ? : self.offSet(scrollView.contentOffset.y, self);
}

- (void)setTableViewOffSetY:(CGFloat)offSetY {
    if (self.tableView.contentOffset.y > headView && offSetY > self.tableView.contentOffset.y) {
        return;
    }
    
    NSLog(@"%@", self);
    NSLog(@"%f", self.tableView.contentOffset.y);
    [self.tableView setContentOffset:CGPointMake(0, offSetY)];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
