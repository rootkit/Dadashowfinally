//
//  GoodsListViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/10.
//  Copyright © 2017年 李萍. All rights reserved.
//
/***** 商品三级页面 ******/
#import "GoodsListViewController.h"
#import "TitleViewController.h"
#import "GoodsThirdReclassViewController.h"
#import "GoodsListChoosePriceBoard.h"
#import "MessageListViewController.h"

#define scrollButtonHeight 30
@interface GoodsListViewController () <UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate, GoodsListChoosePriceBoardDelegate>

@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic, assign) GoodsThirdClassrifyType goodType;

@end

@implementation GoodsListViewController
- (instancetype)initWithGoodsClassrifyType:(GoodsThirdClassrifyType)type
{
    self = [super init];
    if (self) {
        self.goodType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackCellColor;
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageRendingMode:@"bubble"] style:UIBarButtonItemStylePlain target:self action:@selector(messageAction)];
    
    if (self.goodType == 1) {
        [self layoutScrollTitleForCostume];
    } else if (self.goodType == 2) {
        [self layoutScrollTitleForAccessory];
    }
    
    [self customNavigationView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - search bar

- (void)customNavigationView
{
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.delegate = self;
    _searchController.searchResultsUpdater = self;
    _searchController.obscuresBackgroundDuringPresentation = NO;
    
    self.navigationItem.titleView = _searchController.searchBar;
    
    _searchController.searchBar.delegate = self;
    _searchController.searchBar.placeholder = @"时髦套装";
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
}

#pragma mark -

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    
}

#pragma mark - bar action

- (void)messageAction
{
    NSLog(@"message ... ");
    
    [self.navigationController pushViewController:[MessageListViewController new] animated:YES];
}

//饰品
- (void)layoutScrollTitleForAccessory
{
    TitleViewController *titleCtl = [[TitleViewController alloc] initWithFrame:self.view.frame
                                                                        titles:@[@"流行", @"销量"]
                                                               viewControllers:@[[[GoodsThirdReclassViewController alloc] initWithGoodsClassrifyType:1],
                                                                                 [[GoodsThirdReclassViewController alloc] initWithGoodsClassrifyType:1]]
                                                         andIsFixedTitleLength:YES
                                                                   andHasNavig:YES
                                                                  andHasTabbar:NO];
    titleCtl.titleScrollViewHeight = scrollButtonHeight;
    titleCtl.titleButtonWidth = kScreen_Width/3;
    titleCtl.buttonBackgroundColor = [UIColor whiteColor];
    titleCtl.buttonSelectedColor = ThemeColor;
    titleCtl.buttonUnSelectedColor = [UIColor blackColor];
    titleCtl.buttonTitleSelectedColor = ThemeColor;
    titleCtl.buttonTitleUnSelectedColor = FirstTextColor;
    titleCtl.footHeight = 1;
    titleCtl.selectedType = TitleSelectedTypeWithFoot;
    titleCtl.font = [UIFont systemFontOfSize:14];
    titleCtl.footerUnSelectedColor = BackCellColor;
    
    [self addChildViewController:titleCtl];
    [self.view addSubview:titleCtl.view];
    
    
    UIView *buttonView = [UIView new];
    buttonView.frame = CGRectMake(kScreen_Width/3*2, 64, kScreen_Width/3, scrollButtonHeight);
    [self.view addSubview:buttonView];
    
    UIButton *button = [UIButton new];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitle:@"筛选" forState:UIControlStateNormal];
    [button setTitleColor:FirstTextColor forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, kScreen_Width/3, scrollButtonHeight-1);
    [button addTarget:self action:@selector(chooseAction) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:button];
    
    
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = BackCellColor;
    bottomLine.frame = CGRectMake(0, scrollButtonHeight-1, kScreen_Width/3, 1);
    [buttonView addSubview:bottomLine];
}

//服饰
- (void)layoutScrollTitleForCostume
{
    TitleViewController *titleCtl = [[TitleViewController alloc] initWithFrame:self.view.frame
                                                                        titles:@[@"流行", @"试衣间", @"DIY"]
                                                               viewControllers:@[[[GoodsThirdReclassViewController alloc] initWithGoodsClassrifyType:1],
                                                                                 [[GoodsThirdReclassViewController alloc] initWithGoodsClassrifyType:2],
                                                                                 [[GoodsThirdReclassViewController alloc] initWithGoodsClassrifyType:3]]
                                                         andIsFixedTitleLength:NO
                                                                   andHasNavig:YES
                                                                  andHasTabbar:NO];
    titleCtl.titleScrollViewHeight = scrollButtonHeight;
    titleCtl.buttonBackgroundColor = [UIColor whiteColor];
    titleCtl.buttonSelectedColor = ThemeColor;
    titleCtl.buttonUnSelectedColor = [UIColor blackColor];
    titleCtl.buttonTitleSelectedColor = ThemeColor;
    titleCtl.buttonTitleUnSelectedColor = FirstTextColor;
    titleCtl.footHeight = 1;
    titleCtl.selectedType = TitleSelectedTypeWithFoot;
    titleCtl.font = [UIFont systemFontOfSize:14];
    titleCtl.footerUnSelectedColor = BackCellColor;
    
    [self addChildViewController:titleCtl];
    [self.view addSubview:titleCtl.view];
}

#pragma mark - 筛选
- (void)chooseAction
{
    NSLog(@"筛选、、、");
    GoodsListChoosePriceBoard *manager = [GoodsListChoosePriceBoard goodsListChoosePriceBoardManager];
    manager.delegate = self;
    [manager showBoard];
}

#pragma mark - GoodsListChoosePriceBoardDelegate
- (void)clickeWithPrice:(NSString *)minPrice max:(NSString *)maxPrice
{
    NSLog(@"minPrice = %@ maxPrice = %@", minPrice, maxPrice);
}

@end
