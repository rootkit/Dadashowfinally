//
//  OptimazBrandCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/11.
//  Copyright © 2017年 李萍. All rights reserved.
//

/**** 品牌.优选 图片：上一下四****/
#import <UIKit/UIKit.h>

#define OptimazBrandCellIdentifier @"OptimazBrandCell"
@class OptimazBrandCell;

@protocol OptimazBrandCellDelegate <NSObject>

- (void)clickOptimazBrandPickWith:(OptimazBrandCell *)cell forIndexTags:(NSInteger)indexTag;
- (void)clickOptimazBrandBannerPicWith:(OptimazBrandCell *)cell forIndexTags:(NSInteger)indexTag;

@end

@interface OptimazBrandCell : UITableViewCell

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@property (nonatomic, weak) id <OptimazBrandCellDelegate> delegate;




@end


