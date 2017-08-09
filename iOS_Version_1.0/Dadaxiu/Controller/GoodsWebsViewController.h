//
//  GoodsWebsViewController.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/1.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsWebsViewController : UIViewController

- (instancetype)initWithGoodsType:(NSString *)typeStr goodsId:(NSInteger)goodsId;
@property(nonatomic,strong)NSString* titlestring;

@end
