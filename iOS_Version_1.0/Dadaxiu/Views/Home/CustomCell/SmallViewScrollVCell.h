//
//  SmallViewScrollHCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/13.
//  Copyright © 2017年 李萍. All rights reserved.
//

/***** 搭搭吃货 美食滚动 *****/
#import <UIKit/UIKit.h>

#define SmallViewScrollVCellIdentifier @"SmallViewScrollVCell"
@class SmallViewScrollVCell;

@protocol SmallViewScrollVCellDelegate <NSObject>

- (void)clickActionWithSmallViewScrollVCellDelegate:(SmallViewScrollVCell *)cell forIndexTags:(NSInteger)indexTag;

@end

@interface SmallViewScrollVCell : UITableViewCell

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@property (nonatomic, weak) id <SmallViewScrollVCellDelegate> delegate;


@end


@interface SubImgView : UIView

@end
