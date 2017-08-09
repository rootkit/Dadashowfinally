//
//  HomeVedioCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/12.
//  Copyright © 2017年 李萍. All rights reserved.
//

/**** 搭搭影视  ****/
#import <UIKit/UIKit.h>

#define HomeVedioCellIdentifier @"HomeVedioCell"
@class HomeVedioCell;

@protocol HomeVedioCellDelegate <NSObject>

- (void)clickActionWithHomeVedioCell:(HomeVedioCell *)cell forIndexTags:(NSInteger)indexTag;

@end

@interface HomeVedioCell : UITableViewCell

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@property (nonatomic, weak) id <HomeVedioCellDelegate> delegate;

@end


@interface ImgTitleView : UIView

@end
