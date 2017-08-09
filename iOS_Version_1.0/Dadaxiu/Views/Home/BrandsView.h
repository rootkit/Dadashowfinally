//
//  BrandsView.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/10.
//  Copyright © 2017年 李萍. All rights reserved.
//

/******  品牌街、爆款女装...  3_View ******/
#import <UIKit/UIKit.h>

#define rating kScreen_Width/375

#define top_padding 10*rating
#define left_padding 12*rating
#define bottom_padding 0
#define right_padding left_padding

#define rate (kScreen_Width-24)/351

#define img_padding 5*rating

#define brandImg_W 173*rating //173//
#define brandImg_H 189*rating//189//
#define branchTitle_top_padding 24*rating
#define branchTitle_left_padding 13*rating


#define kBrands_H (brandImg_H+top_padding+bottom_padding);//209//
//#define kBrands_H 165* kScreen_Width / 375

#define hot_W brandImg_W
#define hot_H 92*rating //*
#define hotTitle_top_padding branchTitle_top_padding
#define hotTittle_left_padding 10*rating

#define private_W hot_H
#define private_H 100*rating
#define privateTitle_top_padding 10*rating
#define privateTitle_left_padding 8*rating

#define shops_W private_W
#define shops_H private_H

#define brands_title_font 16*rating
#define brands_info_font 11*rating

#define hot_title_font brands_title_font
#define hot_info_font 9*rating

#define private_title_font 12*rating
#define shops_title_font 16*rating
#define icon_font 9*rating

@protocol BrandsViewDelegate <NSObject>

- (void)clickIMGWithTags:(HomeBrandsType)brandType;

@end

@interface BrandsView : UIView

@property (nonatomic, weak) id <BrandsViewDelegate> delegate;
@property (nonatomic, strong) UIImageView *brandsIMG;
@property (nonatomic, strong) UIImageView *hotIMG;
@property (nonatomic, strong) UIImageView *privateIMG;
@property (nonatomic, strong) UIImageView *shopsIMG;

@end
