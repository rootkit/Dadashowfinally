//
//  YWRoundAnnotationView.h
//  iOS_Version_1.0
//
//  Created by liping on 2017/6/23.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

@interface YWRoundAnnotationView : BMKAnnotationView
@property(nonatomic,copy)NSString *titleText;//品牌标签
@property(nonatomic,copy)NSString *addressText;//地名标签
@property(nonatomic,strong) UIImageView* shopimageview;
@end
