//
//  KindchooseTableViewCell.h
//  iOS_Version_1.0
//
//  Created by liping on 2017/6/5.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol KindchooseTableViewCellDelegate <NSObject>

- (void)selectedValueChangeBlock:(NSInteger)section key:(NSInteger)index value:(NSString *)value;

@end

@interface KindchooseTableViewCell : UITableViewCell
@property (assign, nonatomic) id<KindchooseTableViewCellDelegate> delegate;

@property (strong, nonatomic) NSMutableArray *attributeArr;

@property (strong, nonatomic) NSMutableArray *selectedArr;

@property (assign, nonatomic) CGFloat height;

@property (copy, nonatomic) NSString *isShrinkage;

/** cell 的类方法   返回 cell 本身  */
+ (instancetype) cellWithTableView: (UITableView *)tableView dataArr:(NSMutableArray*)arr indexPath:(NSIndexPath *)indexPath;
@end
