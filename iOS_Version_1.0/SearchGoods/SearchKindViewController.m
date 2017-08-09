//
//  SearchKindViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/31.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "SearchKindViewController.h"
#import "SearchKindCollectionViewCell.h"


#define item_W 170 * kScreen_Width / 375
#define item_H 227 * kScreen_Width / 375
#define headheght 200 * kScreen_Width / 375
@interface SearchKindViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation SearchKindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    [self setsearchbarlistcollectview];
   
}

-(void)setsearchbarlistcollectview{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(item_W, item_H);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing =0;
    layout.sectionInset = UIEdgeInsetsMake(0,12*kScreen_Width/375,0, 12*kScreen_Width/375);//top, left, bottom, right
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,kScreen_Width,kScreen_Height-108) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[SearchKindCollectionViewCell class] forCellWithReuseIdentifier:SearchKindCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SearchKindCollectionViewCell *cell = [SearchKindCollectionViewCell returnResueCellFormTableView:collectionView indexPath:indexPath identifier:SearchKindCellIdentifier];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
}


@end
