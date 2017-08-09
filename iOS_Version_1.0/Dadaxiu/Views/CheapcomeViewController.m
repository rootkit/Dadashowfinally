//
//  CheapcomeViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/17.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "CheapcomeViewController.h"
#import "CheapcomeViewCell.h"
#define scrollTitleHeight 30

#define item_W 170 * kScreen_Width / 375
#define item_H 298 * kScreen_Width / 375
@interface CheapcomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation CheapcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor greenColor];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(item_W, item_H);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0,12*kScreen_Width/375,0, 12*kScreen_Width/375);//top, left, bottom, right
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-scrollTitleHeight-64) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor  whiteColor];
    
    [self.collectionView registerClass:[CheapcomeViewCell class] forCellWithReuseIdentifier:CheapcomeViewCellIdentifier];
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
   CheapcomeViewCell *cell = [CheapcomeViewCell returnResueCellFormTableView:collectionView indexPath:indexPath identifier:CheapcomeViewCellIdentifier];
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden=YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden=NO;
}



@end
