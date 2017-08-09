//
//  BrandsViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/4/25.
//  Copyright © 2017年 李萍. All rights reserved.
//

/****** 品牌街 *****/
#import "BrandsViewController.h"
#import "XRCarouselView.h"
#import "UIColor+CustomColor.h"
#import "FashionCollectionViewCell.h"
#import "PopularitysTableViewCell.h"
#import "BrandsOrderListViewController.h"

#define banner_heigth 260*kScreen_Width/375
#define carouselView_height 180*kScreen_Width/375
#define leftspach 6*kScreen_Width/375
#define heightspach 30*kScreen_Width/375
#define bannarBtn_height (banner_heigth - carouselView_height)/2
#define bannarBtn_width 70*bannarBtn_height/40

@interface BrandsViewController ()<XRCarouselViewDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) XRCarouselView *carouselView;
@property(nonatomic,strong) UIView* brandview;
@property(nonatomic,weak)UITableView* brandtableview;
@property (nonatomic ,strong)UICollectionView *fashioncollectionView;
@end

@implementation BrandsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title = @"品牌街";
    [self setbanner];
    [self circulationbtn];
    [self brandtableview];
    self.brandtableview.mj_header=[HZNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                       [self.brandtableview.mj_header endRefreshing];//加载完成停止结束刷新
            
        });
    }];
    self.brandtableview.mj_footer = [XZZNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.brandtableview.mj_footer endRefreshing];
        });
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - init
- (UITableView *)brandtableview
{
    if (!_brandtableview) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        tableView.tableHeaderView =_brandview;
        tableView.separatorColor = [UIColor colorWithHex:0xEEEEEE];
        [self.view addSubview:tableView];
        _brandtableview = tableView;
    }
    return _brandtableview;
}

#pragma mark - set banner

-(void)setbanner{
    
    UIView* brandview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, banner_heigth)];
    brandview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:brandview];
    _brandview=brandview;
    NSArray* arr = @[
                     [UIImage imageNamed:@"品牌街"], [UIImage imageNamed:@"品牌街"], [UIImage imageNamed:@"品牌街"]
                     ];
    /**
     *  通过代码创建
     */
    self.carouselView = [[XRCarouselView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, carouselView_height)];
    
    
    //设置占位图片,须在设置图片数组之前设置,不设置则为默认占位图
    _carouselView.placeholderImage = [UIImage imageNamed:@"defualtUserDetailIcon"];
    
    //设置图片数组及图片描述文字
    _carouselView.imageArray = arr;
    //    _carouselView.describeArray = describeArray;
    
    //用代理处理图片点击
    _carouselView.delegate = self;
    
    //设置每张图片的停留时间，默认值为5s，最少为2s
    _carouselView.time = 3;
    
    //设置分页控件的图片,不设置则为系统默认
    [_carouselView setPageImage:[UIImage imageNamed:@"other"] andCurrentPageImage:[UIImage imageNamed:@"current"]];
    
    //设置分页控件的位置，默认为PositionBottomCenter
    _carouselView.pagePosition = PositionBottomCenter;
    
    /**
     *  修改图片描述控件的外观，不需要修改的传nil
     *
     *  参数一 字体颜色，默认为白色
     *  参数二 字体，默认为13号字体
     *  参数三 背景颜色，默认为黑色半透明
     */
    UIColor *bgColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
    UIFont *font = [UIFont systemFontOfSize:15*(kScreen_Width/375)];
    UIColor *textColor = [UIColor greenColor];
    [_carouselView setDescribeTextColor:textColor font:font bgColor:bgColor];
    [brandview addSubview:self.carouselView];
}


#pragma mark XRCarouselViewDelegate
- (void)carouselView:(XRCarouselView *)carouselView clickImageAtIndex:(NSInteger)index {
    NSLog(@"点击了第%ld张图片", index);
    [_carouselView stopTimer];
}

-(void)circulationbtn
{
    CGFloat leftPadding = (kScreen_Width-bannarBtn_width*5)/2;
    
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 5; j++) {
            UIButton *button = [UIButton new];
            button.frame = CGRectMake(leftPadding+bannarBtn_width*j, carouselView_height+bannarBtn_height*i, bannarBtn_width, bannarBtn_height);
            [button addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
            button.backgroundColor = [UIColor whiteColor];
            [_brandview addSubview:button];
            button.tag = 5*i+j+1;
            if (i == 1 && j == 4) {
                [button setImage:[UIImage imageNamed:@"brands_ico_more"] forState:UIControlStateNormal];
            } else {
                
                [button setImage:[UIImage imageNamed:@"adidas-neo"] forState:UIControlStateNormal];//动态数据图片
            }
        }
    }
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    } else if (section == 1){
        return 1;
    } else {
        return 3;
    }
    
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"NoRefuse";
    if (indexPath.section==0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [self fashionview:cell.contentView];
        return cell;
    }else if (indexPath.section==1){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [self recommendview:cell.contentView];
        return cell;
    }
    else {
        PopularitysTableViewCell *cell = [[PopularitysTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        return cell;
        
    }
}

-(void)fashionview:(UIView*)cellview{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    UICollectionView *collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0 , kScreen_Width , 180*(kScreen_Width/375)) collectionViewLayout:flowLayout];
    collectionView.showsHorizontalScrollIndicator=NO;//隐藏滚动条
    collectionView.dataSource=self;
    collectionView.delegate=self;
    [collectionView setBackgroundColor:[UIColor whiteColor]];
    [collectionView registerClass:[FashionCollectionViewCell class] forCellWithReuseIdentifier:@"DadaxiuCollectionViewCell"];
    _fashioncollectionView = collectionView;
    [cellview addSubview:_fashioncollectionView];
}

-(void)recommendview:(UIView*)cellview{
    
    for (int i=0; i<4; i++) {
        UIButton * recommendbtn=[[UIButton alloc]init];
        recommendbtn.titleLabel.font=[UIFont systemFontOfSize:12*(kScreen_Width/375)];
        [recommendbtn addTarget:self action:@selector(kind) forControlEvents:UIControlEventTouchUpInside];
        if (i<2) {
            recommendbtn.frame=CGRectMake(12*kScreen_Width/375+((kScreen_Width-heightspach)/2)*i+leftspach*i, 0,(kScreen_Width-heightspach)/2, 115*(kScreen_Width/375));
        }else{
            recommendbtn.frame=CGRectMake(12*kScreen_Width/375+((kScreen_Width-heightspach)/2)*(i-2)+leftspach*(i-2),137*(kScreen_Width/375), (kScreen_Width-heightspach)/2, 115*(kScreen_Width/375));
        }
        recommendbtn.layer.cornerRadius = 4;
        recommendbtn.layer.masksToBounds = YES;
        [recommendbtn setImage:[UIImage imageNamed:@"cm2_daily_banner2"] forState:UIControlStateNormal];
        [cellview addSubview:recommendbtn];
    }
}

-(void)kind{
        NSLog(@"品牌推荐");
}

//表示图各个分区的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50*(kScreen_Width/375);
}

//表示他各个分区的内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* sectionview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 50*(kScreen_Width/375))];
    sectionview.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    UILabel *label = [[UILabel alloc] init];
  
    switch (section) {
        case 0:
            label.text = @"当季流行";
        break;
        case 1:
            label.text = @"品牌推荐";
        break;
        case 2:
            label.text = @" 人气精选";
        break;
        default:
            break;
    }
    label.textColor =[UIColor blackColor];
    label.frame=CGRectMake(0, 5, kScreen_Width, 45*(kScreen_Width/375));
    label.font = [UIFont boldSystemFontOfSize:15*(kScreen_Width/375)];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor=[UIColor whiteColor];
    [sectionview addSubview:label];
    return  sectionview;
 
}

//表示各个分区的间隔高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

//各个分区的cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     CGFloat height = 0.0;
     switch (indexPath.section) {
        case 0:
           height= 180*(kScreen_Width/375);
            break;
        case 1:
           height= 280*(kScreen_Width/375);
            break;
        case 2:
            height= 322*(kScreen_Width/375);
            break;
        default:
            break;
    }
    return height;
}

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 200;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"DadaxiuCollectionViewCell";
    FashionCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    return cell;
}

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreen_Width/3,180*(kScreen_Width/375));
}
//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - banner button click
-(void)change:(UIButton*)btn{
    if (btn.tag == 10) {
        NSLog(@"更多");
        [self.navigationController pushViewController:[BrandsOrderListViewController new] animated:YES];
    } else {
        NSLog(@"品牌跳转%ld", (long)btn.tag);
    }
}

@end
