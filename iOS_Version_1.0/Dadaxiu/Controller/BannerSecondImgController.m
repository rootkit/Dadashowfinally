//
//  BannerSecondImgController.m
//  iOS_Version_1.0
//
//  Created by 李萍 on 2017/6/30.
//  Copyright © 2017年 李萍. All rights reserved.
//

/*** 首页banner二级界面image ***/
#import "BannerSecondImgController.h"

#define rating kScreen_Width/375

@interface BannerSecondImgController ()
{
    CGFloat scrollV_Height;
}

@property (nonatomic, assign) NSInteger index;

@end

@implementation BannerSecondImgController

- (instancetype)initWithBannerIndex:(NSInteger)index
{
    self = [super init];
    if (self) {
        self.index = index;
        scrollV_Height = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BackCellColor;
    [self setSubViewForScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - subView
- (void)setSubViewForScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    
    if (self.index == 0) {
        UIImageView *firstImgOne = [[UIImageView alloc] initWithFrame:CGRectMake(0, scrollV_Height, kScreen_Width, 675*rating)];
        firstImgOne.image = [UIImage imageNamed:@"敢秀_01"];
        [scrollView addSubview:firstImgOne];
        scrollV_Height = 675 * rating;
        
        UIImageView *firstImgTwo = [[UIImageView alloc] initWithFrame:CGRectMake(0, scrollV_Height, kScreen_Width, 411*rating)];
        firstImgTwo.image = [UIImage imageNamed:@"敢秀_02"];
        [scrollView addSubview:firstImgTwo];
        scrollV_Height = (675 + 411) * rating;
        
        UIImageView *firstImgThree = [[UIImageView alloc] initWithFrame:CGRectMake(0, scrollV_Height, kScreen_Width, 292*rating)];
        firstImgThree.image = [UIImage imageNamed:@"敢秀_03"];
        [scrollView addSubview:firstImgThree];
        
        scrollV_Height = (675 + 411 + 292) * rating;
        
    } else if (self.index == 1) {
        
        UIImageView *firstImgOne = [[UIImageView alloc] initWithFrame:CGRectMake(0, scrollV_Height, kScreen_Width, 503*rating)];
        firstImgOne.image = [UIImage imageNamed:@"女神注册_01"];
        [scrollView addSubview:firstImgOne];
        scrollV_Height = 503 * rating;
        
        UIImageView *firstImgTwo = [[UIImageView alloc] initWithFrame:CGRectMake(0, scrollV_Height, kScreen_Width, 314*rating)];
        firstImgTwo.image = [UIImage imageNamed:@"女神注册_02"];
        [scrollView addSubview:firstImgTwo];
        scrollV_Height = (503 + 314) * rating;
        
        UIImageView *firstImgThree = [[UIImageView alloc] initWithFrame:CGRectMake(0, scrollV_Height, kScreen_Width, 257*rating)];
        firstImgThree.image = [UIImage imageNamed:@"女神注册_03"];
        [scrollView addSubview:firstImgThree];
        
        scrollV_Height = (503 + 314 + 257) * rating;
        
        UIImageView *firstImgFour = [[UIImageView alloc] initWithFrame:CGRectMake(0, scrollV_Height, kScreen_Width, 250*rating)];
        firstImgFour.image = [UIImage imageNamed:@"女神注册_04"];
        [scrollView addSubview:firstImgFour];
        
        scrollV_Height = (503 + 314 + 257 + 250) * rating;
        
        UIImageView *firstImgFive = [[UIImageView alloc] initWithFrame:CGRectMake(0, scrollV_Height, kScreen_Width, 250*rating)];
        firstImgFive.image = [UIImage imageNamed:@"女神注册_05"];
        [scrollView addSubview:firstImgFive];
        
        scrollV_Height = (503 + 314 + 257 + 250 + 250) * rating;
        
        UIImageView *firstImgSix = [[UIImageView alloc] initWithFrame:CGRectMake(0, scrollV_Height, kScreen_Width, 239*rating)];
        firstImgSix.image = [UIImage imageNamed:@"女神注册_06"];
        [scrollView addSubview:firstImgSix];
        
        scrollV_Height = (503 + 314 + 257 + 250 + 250 + 239) * rating;
        
    } else if (self.index == 2) {
        UIImageView *firstImgOne = [[UIImageView alloc] initWithFrame:CGRectMake(0, scrollV_Height, kScreen_Width, 464*rating)];
        firstImgOne.image = [UIImage imageNamed:@"千万流量_01"];
        [scrollView addSubview:firstImgOne];
        scrollV_Height = 464 * rating;
        
        UIImageView *firstImgTwo = [[UIImageView alloc] initWithFrame:CGRectMake(0, scrollV_Height, kScreen_Width, 279*rating)];
        firstImgTwo.image = [UIImage imageNamed:@"千万流量_02"];
        [scrollView addSubview:firstImgTwo];
        scrollV_Height = (464 + 379) * rating;
        
        UIImageView *firstImgThree = [[UIImageView alloc] initWithFrame:CGRectMake(0, scrollV_Height, kScreen_Width, 242*rating)];
        firstImgThree.image = [UIImage imageNamed:@"千万流量_03"];
        [scrollView addSubview:firstImgThree];
        
        scrollV_Height = (464 + 379 + 242) * rating;
        
        UIImageView *firstImgFour = [[UIImageView alloc] initWithFrame:CGRectMake(0, scrollV_Height, kScreen_Width, 325*rating)];
        firstImgFour.image = [UIImage imageNamed:@"千万流量_04"];
        [scrollView addSubview:firstImgFour];
        
        scrollV_Height = (464 + 379 + 242 + 325) * rating;
        
        UIImageView *firstImgFive = [[UIImageView alloc] initWithFrame:CGRectMake(0, scrollV_Height, kScreen_Width, 207*rating)];
        firstImgFive.image = [UIImage imageNamed:@"千万流量_05"];
        [scrollView addSubview:firstImgFive];
        
        scrollV_Height = (464 + 379 + 242 + 325 + 207) * rating;
    }
    
    
    scrollView.contentSize = CGSizeMake(kScreen_Width, scrollV_Height);
}




@end
