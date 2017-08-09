//
//  FamousbrandViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/17.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "FamousbrandViewController.h"
#import "FamousbrandCell.h"
@interface FamousbrandViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *Famousbrandtableview;
@property(nonatomic,strong) UIView* headview;
@end

@implementation FamousbrandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"甄大牌";
    [self tableheadview];
}


-(void)tableheadview{
    UIView* headview=[[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreen_Width, 125)];
    [self.view addSubview:headview];
    _headview=headview;
    UIImageView* preludeimage=[[UIImageView alloc]init];
    preludeimage.image=[UIImage imageNamed:@"bb_1"];
    [headview addSubview:preludeimage];
    [preludeimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
         make.left.equalTo(@0);
         make.right.equalTo(@-0);
         make.bottom.equalTo(@-0);
    }];
    [self Famousbrandtableview];
}

#pragma mark - init tableview
- (UITableView *)Famousbrandtableview
{
    if (!_Famousbrandtableview) {
        UITableView *tableView = [[UITableView alloc] init];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight=150.0;
        tableView.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(@0);
            make.width.equalTo(@(kScreen_Width));
            make.height.equalTo(@(kScreen_Height));
        }];
        tableView.tableHeaderView=_headview;
        _Famousbrandtableview = tableView;
       [_Famousbrandtableview  registerClass:[FamousbrandCell class] forCellReuseIdentifier:FamousbrandCellIdentifier];
    }
    return _Famousbrandtableview;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FamousbrandCell *cell = [FamousbrandCell returnResueCellFormTableView:self.Famousbrandtableview indexPath:indexPath identifier:FamousbrandCellIdentifier];
    return cell;
    return cell;
}

//表示图各个分区的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
