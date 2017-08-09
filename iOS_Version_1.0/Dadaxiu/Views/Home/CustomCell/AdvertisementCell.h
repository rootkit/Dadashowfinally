//
//  AdvertisementCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/13.
//  Copyright © 2017年 李萍. All rights reserved.
//

/**** 广告位移动 ****/
#import <UIKit/UIKit.h>

#define AdvertisementCellIdentifier @"AdvertisementCell"
@class AdvertisementCell;

@protocol AdvertisementCellDelegate <NSObject>

- (void)clickActionWithAdvertisementCellDelegate:(AdvertisementCell *)cell forIndexTags:(NSInteger)indexTag;

@end

@interface AdvertisementCell : UITableViewCell

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@property (nonatomic, weak) id <AdvertisementCellDelegate> delegate;
@property (nonatomic, strong) UIImage *advertisementImage;


@end
