//
//  AllGoodsViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/24.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "AllGoodsViewController.h"
#import "AllgoodsTableViewCell.h"
#import "AllsecondTableViewCell.h"
#define  Celltowimageheight 200*(kScreen_Height/667)
#define  Cellthreeimageheight 130*(kScreen_Height/667)
@interface AllGoodsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView* allgoodstableview;
@property(nonatomic,strong)NSNotificationCenter *diynotificationCenter;
@property(nonatomic,strong)NSNotificationCenter* subnotificationCenter;
@end

@implementation AllGoodsViewController

- (instancetype)init
{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeablescorll) name:@"changescorllable" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(allscorllable) name:@"allscorllable" object:nil];
    }
    return self;
}


-(NSNotificationCenter*)diynotificationCenter{
    if (!_diynotificationCenter) {
        _diynotificationCenter= [NSNotificationCenter defaultCenter];
    }
    return _diynotificationCenter;
}

-(NSNotificationCenter*)subnotificationCenter{
    if (!_subnotificationCenter) {
        _subnotificationCenter= [NSNotificationCenter defaultCenter];
    }
    return _subnotificationCenter;
}

- (UITableView *)allgoodstableview
{
    if (!_allgoodstableview) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-108) style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.scrollEnabled=NO;
        tableView.separatorColor = [UIColor whiteColor];
        [tableView  registerClass:[AllgoodsTableViewCell class] forCellReuseIdentifier:AllgoodsTableViewCellIdentifier];
         [tableView  registerClass:[AllsecondTableViewCell class] forCellReuseIdentifier:AllsecondTableViewCellIdentifier];
        [self.view addSubview:tableView];
        
        _allgoodstableview = tableView;
    }
    return _allgoodstableview;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self allgoodstableview];
    [self diynotificationCenter];
    [self subnotificationCenter];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 20;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index=indexPath.section%2;
    if (index==1) {
        NSLog(@"奇数");
        AllsecondTableViewCell *cell = [AllsecondTableViewCell returnResueCellFormTableView:self.allgoodstableview indexPath:indexPath identifier:AllsecondTableViewCellIdentifier];
        return cell;
      
    }
    else{
        NSLog(@"偶数");
        AllgoodsTableViewCell *cell = [AllgoodsTableViewCell returnResueCellFormTableView:self.allgoodstableview indexPath:indexPath identifier:AllgoodsTableViewCellIdentifier];
        return cell;
     
    }
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

//表示他各个分区的内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* sectionview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 50*(kScreen_Width/375))];
    sectionview.backgroundColor=[UIColor whiteColor];
    UILabel *titlelabel = [[UILabel alloc] init];
    titlelabel.textColor =[UIColor blackColor];
    titlelabel.text=@"搭搭秀·优雅淑女";
    titlelabel.frame=CGRectMake(0, 0, kScreen_Width, 35*(kScreen_Width/375));
    titlelabel.font = [UIFont boldSystemFontOfSize:14.0*(kScreen_Width/375)];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.backgroundColor=[UIColor whiteColor];
    [sectionview addSubview:titlelabel];
    
    UILabel *personlabel = [[UILabel alloc] init];
    personlabel.textColor =[UIColor colorWithHex:0xa8a8a8];
    personlabel.text=@"999人已看";
    personlabel.frame=CGRectMake(0, 30*(kScreen_Width/375), kScreen_Width, 20*(kScreen_Width/375));
    personlabel.font = [UIFont boldSystemFontOfSize:12*(kScreen_Width/375)];
    personlabel.textAlignment = NSTextAlignmentCenter;
    personlabel.backgroundColor=[UIColor whiteColor];
    [sectionview addSubview:personlabel];
    
    return  sectionview;
    
}
//表示图各个分区的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
  
    return 0.01;//把高度设置很小，效果可以看成footer的高度等于0
}
-(void)dealloc{
    NSLog(@"子视图已经销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section%2==1) {
        return Cellthreeimageheight;
    }else{
        return  Celltowimageheight;
    }
}

-(void)changeablescorll{
    _allgoodstableview.scrollEnabled=YES;
}
-(void)allscorllable{
    _allgoodstableview.scrollEnabled=NO;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y<0) {
        NSLog(@" --== %f",scrollView.contentOffset.y);
        _allgoodstableview.scrollEnabled=NO;
        [_subnotificationCenter postNotificationName:@"subscorllable"object:nil userInfo:nil];
        [_diynotificationCenter postNotificationName:@"detailtablescorllable"object:nil userInfo:nil];
    }
}


@end
