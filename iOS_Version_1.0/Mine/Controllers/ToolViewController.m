//
//  ToolViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/8.
//  Copyright © 2017年 李萍. All rights reserved.
//

/***** 必选工具 *****/
#import "ToolViewController.h"
#import "ToolCell.h"
#import "ToolHeaderView.h"
#import "ToolHelpCenterController.h"
#import "OpinionViewController.h"
#import "MyopenshopsViewController.h"
#import "MywalletViewController.h"
#import "MyFavotableViewController.h"
#import "MartViewController.h"
#import "JSCallOCViewController.h"
#import "DIYWebController.h"

#define item_W (kScreen_Width-2)/3
#define item_H 90
@interface ToolViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    NSArray *icons;
    NSArray *titles;
    
    NSArray *sectionTitles;
}
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ToolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"工具";
    
    self.view.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(item_W, item_H);
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//top, left, bottom, right
//    layout.headerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.frame), 40);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = BackCellColor;
    [self.collectionView registerClass:[ToolCell class] forCellWithReuseIdentifier:ToolCellIdentifier];
    [self.collectionView registerClass:[ToolHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ToolHeaderViewIdentifier];
    
    /* //正式版
    icons = @[@[@"my_wallet", @"my_discountCoupon", @"2D"],
              @[@"fitting", @"my_DIY", @"my_pet", @"my_virtual", @"body", @"my_manazine"],
              @[@"my_feedback", @"service", @"openShop"]];
    titles = @[@[@"我的钱包", @"优惠券", @"二维码"],
               @[@"我的试衣间", @"我的DIY", @"我的宠物", @"虚拟屋", @"我的身材", @"我的杂志"],
               @[@"意见反馈", @"客服与帮助", @"我要开店"]];
    sectionTitles = @[@"推荐工具", @"特色工具", @"需求工具"];
    */
    
    icons = @[@"my_discountCoupon", @"2D", @"fitting", @"my_DIY", @"my_feedback", @"service"];
    
    titles = @[@"优惠券", @"二维码", @"我的试衣间", @"我的DIY", @"意见反馈", @"客服与帮助"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return titles.count;
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    if (section == 0) {
//        return 3;
//    } else if (section == 1) {
//        return 6;
//    } else {
//        return 3;
//    }
    
    return titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ToolCell *cell = [ToolCell returnResueCellFormTableView:collectionView indexPath:indexPath identifier:ToolCellIdentifier];
    
    ToolModel *model = [ToolModel new];
    model.iconName = icons[indexPath.row];
    model.title = titles[indexPath.row];
    
    cell.toolModel = model;
    
    return cell;
}

//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionReusableView *reusableView =nil;
//
//    if (kind ==UICollectionElementKindSectionHeader) {
//        //定制头部视图的内容
//        ToolHeaderView *headerV = [ToolHeaderView returnResueCellFormTableView:self.collectionView indexPath:indexPath identifier:ToolHeaderViewIdentifier];
//        
//        headerV.titleLb.text = sectionTitles[indexPath.section];
//        reusableView = headerV;
//    }
//    
//    return reusableView;
//    
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            [self.navigationController pushViewController:[MyFavotableViewController new] animated:YES];
            break;
        }
        case 1:
        {
            [self.navigationController pushViewController:[MartViewController new] animated:YES];
            break;
        }
        case 2:
        {
            NSLog(@"我的试衣间");
            JSCallOCViewController* jsvc=[[JSCallOCViewController alloc]init];
            jsvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:jsvc animated:YES];
            break;
        }
        case 3:
        {
            NSLog(@"我的DIY");
            [self presentViewController:[[DIYWebController alloc] initWithUrl:DDXAPI_DIY] animated:YES completion:nil];
            break;
        }
        case 4:
        {
            OpinionViewController* openvc=[OpinionViewController  new];
            openvc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:openvc animated:YES];
            break;
        }
        case 5:
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
            ToolHelpCenterController *ctl = [storyboard instantiateViewControllerWithIdentifier:@"ToolHelpCenterController"];
            [self.navigationController pushViewController:ctl animated:YES];
            break;
        }
            
        default:
            break;
    }
    
    /*
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    NSLog(@"我的钱包");
                    MywalletViewController* rvc=[MywalletViewController new];
                    [self.navigationController pushViewController:rvc animated:YES];
                    break;
                }
                case 1:
                {
                    NSLog(@"优惠券");
                    
                    [self.navigationController pushViewController:[MyFavotableViewController new] animated:YES];
                    break;
                }
                case 2:
                {
                    NSLog(@"二维码");
                    [self.navigationController pushViewController:[MartViewController new] animated:YES];
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    NSLog(@"我的试衣间");
                    break;
                }
                case 1:
                {
                    NSLog(@"我的DIY");
                    break;
                }
                case 2:
                {
                    NSLog(@"我的宠物");
                    break;
                }
                case 3:
                {
                    NSLog(@"虚拟屋");
                    break;
                }
                case 4:
                {
                    NSLog(@"我的身材");
                    break;
                }
                case 5:
                {
                    NSLog(@"我的杂志");
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    NSLog(@"意见反馈");
                    OpinionViewController* openvc=[OpinionViewController  new];
                    openvc.hidesBottomBarWhenPushed=YES;
                    [self.navigationController pushViewController:openvc animated:YES];
                    break;
                }
                case 1:
                {
                    NSLog(@"客服与帮助");
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
                    ToolHelpCenterController *ctl = [storyboard instantiateViewControllerWithIdentifier:@"ToolHelpCenterController"];
                    [self.navigationController pushViewController:ctl animated:YES];
                    break;
                }
                case 2:
                {
                    NSLog(@"我要开店");
                    MyopenshopsViewController* myvc=[MyopenshopsViewController new];
                    myvc.hidesBottomBarWhenPushed=YES;
                    [self.navigationController pushViewController:myvc animated:YES];
                   
                    break;
                }
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
     */
}

#pragma mark <UICollectionViewDelegate>


@end
