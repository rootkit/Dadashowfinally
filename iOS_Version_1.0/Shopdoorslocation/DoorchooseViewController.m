//
//  DoorchooseViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/8.
//  Copyright © 2017年 李萍. All rights reserved.
//
#import "DoorchooseViewController.h"
#import "ZspMenu.h"
#import "UIColor+CustomColor.h"
#import "DetaildoorTableViewCell.h"
@interface DoorchooseViewController ()<ZspMenuDataSource, ZspMenuDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) ZspMenu *menu;
@property (nonatomic, strong) NSArray *location;
@property (nonatomic, strong) NSArray *choose;
@property (nonatomic, strong) NSArray *yuexiu;
@property (nonatomic, strong) NSArray *tianhe;
@property (nonatomic, strong) NSArray *panyu;
@property (nonatomic, strong) NSArray *hanzhu;
@property (nonatomic, strong) NSArray *baiyun;
@property (nonatomic, strong) NSArray *liwan;
@property (nonatomic, strong) NSArray *huangpu;
@property(nonatomic,strong)UITableView* doorchoosetableview;
@end

@implementation DoorchooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"门店选择";
    self.view.backgroundColor=[UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    // 数据
    self.location = @[@"附近", @"南山区", @"福田区", @"宝安区", @"龙岗区", @"罗湖区"];
    self.choose = @[@"排序", @"离我最近", @"好评优先", @"人气最高"];
    
    self.yuexiu = @[@"附近", @"1km", @"3km", @"5km",@"10km",@"全城"];
    self.tianhe = @[@"附近", @"1km", @"3km", @"5km",@"10km",@"全城"];
    self.panyu = @[@"附近", @"1km", @"3km", @"5km",@"10km",@"全城"];
    self.hanzhu = @[@"附近", @"1km", @"3km", @"5km",@"10km",@"全城"];
    self.baiyun = @[@"附近", @"1km", @"3km", @"5km",@"10km",@"全城"];
    self.liwan = @[@"附近", @"1km", @"3km", @"5km",@"10km",@"全城"];
    self.huangpu = @[@"附近", @"1km", @"3km", @"5km",@"10km",@"全城"];
    _menu = [[ZspMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:44];
    _menu.delegate = self;
    _menu.dataSource = self;
    [self.view addSubview:_menu];
    
    [_menu selectDeafultIndexPath];
    [self doorchoosetableview];
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]){
        self.automaticallyAdjustsScrollViewInsets = NO;
    }//防止下降导航栏64
}
- (UITableView *)doorchoosetableview
{
    if (!_doorchoosetableview) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,108, kScreen_Width, kScreen_Height-108) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight=141*(kScreen_Width/375);
        [self.view addSubview:tableView];
        _doorchoosetableview = tableView;
    }
    return _doorchoosetableview;
}
//（附件和排序两个按钮）
- (NSInteger)numberOfColumnsInMenu:(ZspMenu *)menu {
    return 2;
}
//附件和排序按钮各有多少行
- (NSInteger)menu:(ZspMenu *)menu numberOfRowsInColumn:(NSInteger)column {
    if (column == 0) {
        return self.location.count;
    }else{
        return self.choose.count;
    }
}
//详细列表的title
- (NSString *)menu:(ZspMenu *)menu titleForRowAtIndexPath:(ZspIndexPath *)indexPath {
    if (indexPath.column == 0) {
        return self.location[indexPath.row];
    }else {
        return self.choose[indexPath.row];
    }
}

- (NSString *)menu:(ZspMenu *)menu imageNameForRowAtIndexPath:(ZspIndexPath *)indexPath {
    if (indexPath.column == 1) {
        return @"gouxuan";
    }
    return nil;
}

- (NSString *)menu:(ZspMenu *)menu imageForItemsInRowAtIndexPath:(ZspIndexPath *)indexPath {
//    if (indexPath.column == 0 && indexPath.item >= 0) {
//         return @"gouxuan";
//    }
    return nil;
}

- (NSString *)menu:(ZspMenu *)menu detailTextForRowAtIndexPath:(ZspIndexPath *)indexPath {
//    if(indexPath.column < 2) {
//        return @"大大秀";
//    }
    return nil;
}

- (NSString *)menu:(ZspMenu *)menu detailTextForItemsInRowAtIndexPath:(ZspIndexPath *)indexPath {
     return nil;
    
}

- (NSInteger)menu:(ZspMenu *)menu numberOfItemsInRow:(NSInteger)row inColumn:(NSInteger)column {
    if (column == 0) {
        if (row == 2) {
            return self.yuexiu.count;
        }else if (row == 3) {
            return self.tianhe.count;
        }else if (row == 4) {
            return self.panyu.count;
        }else if (row == 5) {
            return self.hanzhu.count;
        }else if (row == 6) {
            return self.baiyun.count;
        }else if (row == 7) {
            return self.liwan.count;
        }else if (row == 8) {
            return self.huangpu.count;
        }
    }
    return 0;
}

- (NSString *)menu:(ZspMenu *)menu titleForItemsInRowAtIndexPath:(ZspIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (indexPath.column == 0) {
        if (row == 2) {
            return self.yuexiu[indexPath.item];
        }else if (row == 3) {
            return self.tianhe[indexPath.item];
        }else if (row == 4) {
            return self.panyu[indexPath.item];
        }else if (row == 5) {
            return self.hanzhu[indexPath.item];
        }else if (row == 6) {
            return self.baiyun[indexPath.item];
        }else if (row == 7) {
            return self.liwan[indexPath.item];
        }else if (row == 8) {
            return self.huangpu[indexPath.item];
        }
    }
    return nil;
}

- (void)menu:(ZspMenu *)menu didSelectRowAtIndexPath:(ZspIndexPath *)indexPath {
    if (indexPath.item >= 0) {
        NSLog(@"点击了 %ld - %ld - %ld",indexPath.column,indexPath.row,indexPath.item);
    }else {
        NSLog(@"点击了 %ld - %ld",indexPath.column,indexPath.row);
    }
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Commodity";
    DetaildoorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[DetaildoorTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (UIImage *)imageRendingMode:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return image;
}

@end
