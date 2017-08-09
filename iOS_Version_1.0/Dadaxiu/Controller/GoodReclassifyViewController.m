//
//  GoodReclassifyViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/9.
//  Copyright © 2017年 李萍. All rights reserved.
//

/***** 商品二级分类 *****/
#import "GoodReclassifyViewController.h"
#import "GoodsListViewController.h"
#import "MessageListViewController.h"

#import "GoodsReclassifyCell.h"
#import "ToolHeaderView.h"
#import "GoodsReclassFootView.h"

#define searchBar_W 210* kScreen_Width / 375
#define searchBar_H 25

#define item_W 64 * kScreen_Width / 375
#define item_H 90 * kScreen_Width / 375

#define item_padding ((kScreen_Width-24-item_W*5)/3) * kScreen_Width / 375

@interface GoodReclassifyViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) UISearchBar *customSearchBar;

@property (nonatomic, strong) NSMutableArray *reclassifies;//

@end

@implementation GoodReclassifyViewController

- (instancetype)initWithDictionaryArrays:(NSArray *)dictionaryArray
{
    self = [super init];
    if (self) {
        _reclassifies  = [NSMutableArray new];
        [self fetchReclassifyDataWithDicArray:dictionaryArray];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BackCellColor;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(item_W, item_H);
    layout.minimumLineSpacing = 15;
    layout.minimumInteritemSpacing = item_padding;
    layout.sectionInset = UIEdgeInsetsMake(15, 12, 15, 12);//top, left, bottom, right
    layout.headerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.frame), 40);
    layout.footerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.frame), 10);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerClass:[GoodsReclassifyCell class] forCellWithReuseIdentifier:GoodsReclassifyCellIdentifier];
    [self.collectionView registerClass:[ToolHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ToolHeaderViewIdentifier];
    [self.collectionView registerClass:[GoodsReclassFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GoodsReclassFootViewIdentifier];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageRendingMode:@"bubble"] style:UIBarButtonItemStylePlain target:self action:@selector(messageAction)];
    
    [self customNavigationView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - fetch data
- (void)fetchReclassifyDataWithDicArray:(NSArray *)dicArray
{
    [dicArray enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
        //
        GoodsSecondClassifyModel * obj = [GoodsSecondClassifyModel new];
        obj.secondTitle = [dic valueForKey:@"secondTitle"];
        NSArray *array = [dic valueForKey:@"thirdClassify"];

        NSMutableArray *mutableArray = [NSMutableArray new];
        [array enumerateObjectsUsingBlock:^(NSDictionary *dicModel, NSUInteger idx, BOOL * _Nonnull stop) {
            
            GoodsFirstClassifyModel *firstModel = [GoodsFirstClassifyModel new];
            firstModel.title = [dicModel valueForKey:@"title"];
            firstModel.icon = [dicModel valueForKey:@"icon"];
            firstModel.dicArray = [dicModel valueForKey:@"secondClassify"];
            
            [mutableArray addObject:firstModel];
        }];
        obj.thirdClassify = mutableArray.mutableCopy;
        [_reclassifies addObject:obj];
    }];
}

#pragma mark - search bar

- (void)customNavigationView
{
    /*
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.delegate = self;
    _searchController.searchResultsUpdater = self;
    _searchController.obscuresBackgroundDuringPresentation = NO;
    
    self.navigationItem.titleView = _searchController.searchBar;
    
    _searchController.searchBar.delegate = self;
    _searchController.searchBar.placeholder = @"连衣裙";
    [_searchController.searchBar sizeToFit];
    _searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    
    UITextField *searchField = [_searchController.searchBar valueForKey:@"searchField"];
    if (searchField) {
        searchField.backgroundColor = [UIColor grayColor];
        searchField.layer.cornerRadius = 12;
        searchField.layer.borderWidth = 0;
        searchField.clipsToBounds = YES;
        searchField.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    */
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, searchBar_W, searchBar_H)];//allocate titleView
    
    [titleView setBackgroundColor:[UIColor clearColor]];
    
    _customSearchBar = [[UISearchBar alloc] init];
    
    _customSearchBar.delegate = self;
    _customSearchBar.frame = CGRectMake(0, 0, searchBar_W, searchBar_H);
    _customSearchBar.backgroundColor = [UIColor clearColor];
    _customSearchBar.layer.masksToBounds = YES;
    [_customSearchBar handleCornerRadiusWithRadius:5];
    [_customSearchBar handleBoardWidth:0 andBorderColor:[UIColor whiteColor]];
    
    UITextField *searchField = [_customSearchBar valueForKey:@"searchField"];
    if (searchField) {
        searchField.backgroundColor = BackCellColor;
        searchField.clipsToBounds = YES;
        [searchField handleCornerRadiusWithRadius:5];
        [searchField handleBoardWidth:0 andBorderColor:[UIColor whiteColor]];
    }
    
    _customSearchBar.placeholder = @"连衣裙";
    [titleView addSubview:_customSearchBar];
    
    //Set to titleView
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = titleView;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_customSearchBar resignFirstResponder];
}

#pragma mark -

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    
}

- (void)messageAction
{
    NSLog(@"message ... ");
    
    [self.navigationController pushViewController:[MessageListViewController new] animated:YES];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (_reclassifies.count) {
        return _reclassifies.count;
    }
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_reclassifies.count) {
        GoodsSecondClassifyModel *model = _reclassifies[section];
        if (model.thirdClassify.count) {
            return model.thirdClassify.count;
        }
    }
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodsReclassifyCell *cell = [GoodsReclassifyCell returnResueCellFormTableView:collectionView indexPath:indexPath identifier:GoodsReclassifyCellIdentifier];
    
     GoodsSecondClassifyModel *model = _reclassifies[indexPath.section];
    
    if (model.thirdClassify.count) {
        cell.model = model.thirdClassify[indexPath.row];
    }
    
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
//    UICollectionReusableView *reusableView =nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        //定制头部视图的内容
        ToolHeaderView *headerV = [ToolHeaderView returnResueCellFormTableView:self.collectionView indexPath:indexPath identifier:ToolHeaderViewIdentifier];
        headerV.titleFont = [UIFont systemFontOfSize:14];
        headerV.titleTextColor = [UIColor redColor];
        headerV.headerViewBgColor = [UIColor whiteColor];
        
        GoodsSecondClassifyModel *secondModel = _reclassifies[indexPath.section];
        headerV.titleLb.text = secondModel.secondTitle;
        
//        reusableView = headerV;
        return headerV;
    } else if (kind == UICollectionElementKindSectionFooter) {
        GoodsReclassFootView *footView = [GoodsReclassFootView returnResueCellFormTableView:self.collectionView indexPath:indexPath identifier:GoodsReclassFootViewIdentifier];
        footView.backgroundColor = BackCellColor;
//        reusableView = footView;
        
        return footView;
    } else {
        return [UICollectionReusableView new];
    }
    
//    return reusableView;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
    GoodsListViewController *listCtl = [[GoodsListViewController alloc] initWithGoodsClassrifyType:(indexPath.section == 0 ? 1 : 2)];
    [self.navigationController pushViewController:listCtl animated:YES];
    
}

@end
