//
//  Loadingview.m
//  Mjfreshgif
//
//  Created by liping on 2017/5/11.
//  Copyright © 2017年 梁亚海. All rights reserved.
//

#import "Loadingview.h"
#define lodingimagewight 88//图片宽度

@implementation Loadingview

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self loadHeadView];
        
    }
    return self;
}

- (void)loadHeadView{
    
    UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake((kScreen_Width-(2*lodingimagewight)*(kScreen_Height/667))/2, (kScreen_Height-125*(kScreen_Height/667))/2, lodingimagewight*(kScreen_Height/667), 125*(kScreen_Height/667))];
    
    iv.animationImages  = [NSArray arrayWithObjects:
                           [UIImage imageNamed:@"loading1"],
                           [UIImage imageNamed:@"loading2"],
                           [UIImage imageNamed:@"loading3"],
                           [UIImage imageNamed:@"loading4"],
                           [UIImage imageNamed:@"loading5"],
                           [UIImage imageNamed:@"loading6"],
                
                           nil];
    [iv setAnimationDuration:1.0f];
    [iv setAnimationRepeatCount:0];
    [iv startAnimating];
    [self addSubview:iv];

    
    
}
@end
