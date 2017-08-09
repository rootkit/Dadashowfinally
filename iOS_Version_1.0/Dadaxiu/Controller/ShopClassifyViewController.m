//
//  ShopClassifyViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/19.
//  Copyright © 2017年 李萍. All rights reserved.
//

/***** 店铺分类 ******/
#import "ShopClassifyViewController.h"
#import "ShopClassifyCell.h"
#import "ShopClassifyView.h"

#define item_W (kScreen_Width-2) / 2
#define item_H 40

@interface ShopClassifyViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *titles;

@end

@implementation ShopClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店铺分类";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(item_W, item_H);
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    layout.sectionInset = UIEdgeInsetsMake(1, 0, 0, 1);//top, left, bottom, right
    layout.headerReferenceSize = CGSizeMake(kScreen_Width, 45);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, CGRectGetHeight(self.view.frame)) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = BackCellColor;
    
    [self.collectionView registerClass:[ShopClassifyCell class] forCellWithReuseIdentifier:ShopClassifyCellIdentifier];
    [self.collectionView registerClass:[ShopClassifyView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ShopClassifyViewIdentifier];
    
    _titles = @[@[],
                @[@"短袖T恤", @"长袖T恤", @"短袖衬衫", @"长袖衬衫", @"时尚雪纺衫", @"牛仔上衣", @"卫衣", @"长款T恤长款衬衫"],
                @[@"长裤休闲裤", @"短裤热裤", @"牛仔长裤", @"牛仔短裤", @"阔腿裤", @"背带裤"],
                @[@"卫衣运动套装", @"职业正装套装", @"短袖亚麻套装", @"连衣裙套装"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 4;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return ((NSArray *)_titles[section]).count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ShopClassifyCell *cell = [ShopClassifyCell returnResueCellFormTableView:self.collectionView indexPath:indexPath identifier:ShopClassifyCellIdentifier];
    
    cell.title = _titles[indexPath.section][indexPath.row];
    
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //定制头部视图的内容
    ShopClassifyView *headerV = [ShopClassifyView returnResueCellFormCollectionView:collectionView indexPath:indexPath identifier:ShopClassifyViewIdentifier];
    
    headerV.title = @[@"全部宝贝", @"上衣", @"裤装", @"套装系列"][indexPath.section];
    [headerV.pushBtn addTarget:self action:@selector(headerViewpushAction) forControlEvents:UIControlEventTouchUpInside];

    return headerV;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    NSLog(@"click %@", _titles[indexPath.section][indexPath.row]);
}

#pragma mark - headerView push Action
- (void)headerViewpushAction
{
    NSLog(@"跳转...");
}

@end
