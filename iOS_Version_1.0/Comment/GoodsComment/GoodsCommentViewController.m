//
//  GoodsCommentViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/4/29.
//  Copyright © 2017年 李萍. All rights reserved.
//

/****** 商品评论列表  *****/
#import "GoodsCommentViewController.h"
#import "GoodsCommentCell.h"
#import "GoodsCommentItem.h"
#import "TagsView.h"

#import "UIColorHF.h"

@interface GoodsCommentViewController () <FWContentCellDelegate, TagsViewDelegate>
{
    BOOL clickLike;
}

@property (nonatomic, strong) TagsView *tagsView;
@property (nonatomic, strong) NSMutableArray <GoodsCommentItem *> *goodsComment;

@end

@implementation GoodsCommentViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        //
        _goodsComment = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论";
    
    [self.tableView registerClass:[GoodsCommentCell class] forCellReuseIdentifier:GoodsCommentItemIdentifier];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = BackCellColor;
    [self layTagsView];

    [self testItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - tags view
- (void)layTagsView
{
    _tagsView = [[TagsView alloc] initWithMoreTags:@[@"全部(20000)", @"好评(241)", @"中评(2)", @"差评(0)", @"追加(22)", @"有图(12)"]];
    _tagsView.delegate = self;
    self.tableView.tableHeaderView = _tagsView;
}
#pragma mark - TagsViewDelegate
- (void)selectBtnClickAction:(NSInteger)index
{
    NSLog(@"index ==== %ld", (long)index);
}

//测试数据
- (void)testItem
{
    GoodsCommentItem *item = [GoodsCommentItem new];
    item.portraitUrl = @"http://scimg.jb51.net/allimg/150713/14-150G315153Q16.jpg";
    item.username = @"初秋记易";
    item.level = 5;
    item.time = @"2017-04-29";
    item.content = @"经过两个月的试运行后，“一带一路”沿线国家和地区漫游资费优惠自2017年5月1日起正式全面推广";//沿线全部64个国家和地区的国际漫游语音资费下调至0.99元/分钟；53个国家和地区的国际漫游流量资费调整为30元/60元/90元的包天不限流量资费®
    //    item.images = @[@"http://scimg.jb51.net/allimg/150713/14-150G315153Q16.jpg", @"http://scimg.jb51.net/allimg/150713/14-150G315153Q16.jpg", @"http://scimg.jb51.net/allimg/150713/14-150G315153Q16.jpg", @"http://scimg.jb51.net/allimg/150713/14-150G315153Q16.jpg"];
    item.watchCount = 12;
    item.isLike = YES;
    item.images = @[@"http://scimg.jb51.net/allimg/150713/14-150G315153Q16.jpg",
                    @"http://scimg.jb51.net/allimg/150713/14-150G315153Q16.jpg",
                    @"http://scimg.jb51.net/allimg/150713/14-150G315153Q16.jpg"];
    
    [item calculateLayoutWithImages:YES];
    
    int i = 4;
    while (i > 0) {
        i--;
        
        [_goodsComment addObject:item];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_goodsComment.count) {
        return _goodsComment.count;
    } else {}
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodsCommentCell *cell = [GoodsCommentCell returnResueCellFormTableView:tableView indexPath:indexPath identifier:GoodsCommentItemIdentifier];
    
    cell.delegate = self;
    
    if (_goodsComment.count) {
        GoodsCommentItem *item = _goodsComment[indexPath.row];
        cell.goodsCommentItem = item;
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_goodsComment.count) {
        GoodsCommentItem *item = _goodsComment[indexPath.row];
        return item.rowHeight+6;
    } else {}
    return 0;
}

#pragma mark - FWContentCellDelegate
- (void)touchLikeAction:(FWContentCell *)cell
{
    NSLog(@"点赞点赞点赞");
    clickLike = !clickLike;
    
    [cell setLikeStatus:clickLike animation:YES];
}



@end
