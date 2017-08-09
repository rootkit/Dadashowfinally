//
//  PopularitysTableViewCell.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/4/26.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "PopularitysTableViewCell.h"
#import "PopularCollectionViewCell.h"
#import "UIColor+CustomColor.h"
@interface PopularitysTableViewCell()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong)UICollectionView* popcollectionview;

@end
@implementation PopularitysTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupavatarView];
   
        
    }
    return self;
}

-(void)setupavatarView{
    _bgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _bgImageView.image=[UIImage imageNamed:@"cm2_daily_banner1"];
    [self.contentView addSubview:_bgImageView];
    
    UIImageView * iconviewimage= [[UIImageView alloc] initWithFrame:CGRectMake(10*(kScreen_Width/375), 38*(kScreen_Width/375), 59*(kScreen_Width/375),59*(kScreen_Width/375))];
    iconviewimage.image=[UIImage imageNamed:@"品牌街"];
    iconviewimage.layer.cornerRadius = 5*(kScreen_Width/375);
    iconviewimage.layer.masksToBounds = YES;
    [self.contentView addSubview:iconviewimage];
    
    UILabel* titlelabel=[UILabel new];
    titlelabel.textColor=[UIColor colorWithHex:0xffffff];
    titlelabel.backgroundColor=[UIColor clearColor];
    titlelabel.text=@"春季时尚发布会";
    titlelabel.textAlignment=NSTextAlignmentLeft;
    titlelabel.numberOfLines=2;
    titlelabel.font=[UIFont systemFontOfSize:18*(kScreen_Width/375)];
    [self addSubview:titlelabel];
    [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconviewimage.mas_right).equalTo(@(10*(kScreen_Width/375)));
        make.top.equalTo(iconviewimage.mas_top).equalTo(@(20*(kScreen_Width/375)));
    }];

    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    UICollectionView *collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 130*(kScreen_Width/375) , kScreen_Width , 230*(kScreen_Width/375)) collectionViewLayout:flowLayout];
    collectionView.showsHorizontalScrollIndicator=NO;//隐藏滚动条
    collectionView.dataSource=self;
    collectionView.delegate=self;
    [collectionView setBackgroundColor:[UIColor clearColor]];
    //注册Cell，必须要有
    [collectionView registerClass:[PopularCollectionViewCell class] forCellWithReuseIdentifier:@"PopCollectionViewCell"];
    _popcollectionview = collectionView;
    [self addSubview:_popcollectionview];
    
    
    
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
    static NSString * CellIdentifier = @"PopCollectionViewCell";
   PopularCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    //    cell.backgroundColor=[UIColor yellowColor];
    
    return cell;
}

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(135*(kScreen_Width/375),230*(kScreen_Width/375));
}
//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}


//定义每个UICollectionView 的 margin缝隙
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}



-(void)layoutSubviews{
  _bgImageView.frame=CGRectMake(0, 0, kScreen_Width, self.frame.size.height);
    
}
@end
