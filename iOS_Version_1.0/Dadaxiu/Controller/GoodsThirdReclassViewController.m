//
//  GoodsThirdReclassViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/10.
//  Copyright © 2017年 李萍. All rights reserved.
//

/***** 商品三级页面列表 ******/
#import "GoodsThirdReclassViewController.h"
#import "GoodListCell.h"

#define scrollTitleHeight 30

#define item_W 170 * kScreen_Width / 375
#define item_H 227 * kScreen_Width / 375

#define item_padding kScreen_Width-24-item_W*2

@interface GoodsThirdReclassViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) GoodsThirdClassrifyType goodType;

@end

@implementation GoodsThirdReclassViewController

- (id)initWithGoodsClassrifyType:(GoodsThirdClassrifyType)type
{
    self = [super init];
    if (self) {
        self.goodType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(item_W, item_H);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = item_padding;
    layout.sectionInset = UIEdgeInsetsMake(6, 12, 6, 12);//top, left, bottom, right
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-scrollTitleHeight-64) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerClass:[GoodListCell class] forCellWithReuseIdentifier:GoodListCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodListCell *cell = [GoodListCell returnResueCellFormTableView:collectionView indexPath:indexPath identifier:GoodListCellIdentifier];
    
    cell.goodType = self.goodType;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    
}


@end
