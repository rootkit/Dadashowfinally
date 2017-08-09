//
//  ShoptableViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/8.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "ShoptableViewController.h"
#import "CommodityTableViewCell.h"
@interface ShoptableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,assign)NSInteger allheightrow;
@property(nonatomic,strong)UITableView* detailtableview;
@end

@implementation ShoptableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commoditytableview];
}

- (instancetype)init
{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reoadtableview:) name:@"changetable" object:nil];
  
    }
    return self;
}



- (UITableView *)commoditytableview
{
    if (!_detailtableview) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width,  self.allheightrow) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor=[UIColor redColor];
       tableView.scrollEnabled=NO;
        tableView.rowHeight=120;
        [self.view addSubview:tableView];
        _detailtableview = tableView;
    }
    return _detailtableview;
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 8;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Commodity";
    CommodityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CommodityTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    [cell.buyingbtn addTarget:self action:@selector(buyshops) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)reoadtableview:(NSNotification*)userinfo{
    NSLog(@"--%@",userinfo.userInfo[@"rowheight"]);
    self.allheightrow=[userinfo.userInfo[@"rowheight"] integerValue];
    
}

-(void)buyshops{
    NSLog(@"购买商品");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
