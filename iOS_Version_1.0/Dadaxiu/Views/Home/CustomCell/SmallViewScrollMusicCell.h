//
//  SmallViewScrollMusicCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/13.
//  Copyright © 2017年 李萍. All rights reserved.
//

/***** 搭搭吃货 美食滚动 *****/
#import <UIKit/UIKit.h>

#define SmallViewScrollMusicCellIdentifier @"SmallViewScrollMusicCell"
@class SmallViewScrollMusicCell;

@protocol SmallViewScrollMusicCellDelegate <NSObject>

- (void)clickActionWithSmallViewScrollMusicCellDelegate:(SmallViewScrollMusicCell *)cell forIndexTags:(NSInteger)indexTag;

@end

@interface SmallViewScrollMusicCell : UITableViewCell

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@property (nonatomic, weak) id <SmallViewScrollMusicCellDelegate> delegate;

@end


@interface SubMusicImgView : UIView

@end
