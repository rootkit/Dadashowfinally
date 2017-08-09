//
//  LocationCell.h
//  iOS_Version_1.0
//
//  Created by 李萍 on 2017/4/24.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

#define left_padding 12
#define right_padding left_padding
#define btn_padding_V 11//(左右间距)
#define btn_padding_H 9//(上下间距)
#define btn_width (([UIScreen mainScreen].bounds.size.width)-left_padding-right_padding - 2*btn_padding_V)/3
#define btn_height 37

@protocol LocationCellDelegate <NSObject>

- (void)tableviewSelectedIndex:(NSString *)city;

@end

@interface LocationCell : UITableViewCell

-(id)initWithStyle:(UITableViewCellStyle)Style
         indexPath:(NSIndexPath *)indexPath
        identifier:(NSString *)identifierString
          subCitys:(NSArray *)citys;

@property (nonatomic, assign) id <LocationCellDelegate> delegate;

@end
