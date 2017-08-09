//
//  FWVideoViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/4/28.
//  Copyright © 2017年 李萍. All rights reserved.
//

/****** 动态视频列表  *****/
#import "FWVideoViewController.h"

#import "FWContentVideoCell.h"
#import "FWContentItem.h"
#import "DaHttpTool.h"
#import "OSCModelHandler.h"

#import "GoodsCommentViewController.h"
#import "FWTDetailViewController.h"
#import "VideoAvplayerViewController.h"
#import "LoginViewController.h"

@interface FWVideoViewController () <FWContentCellDelegate>

@property (nonatomic, strong) NSMutableArray <FWContentItem *> *contents;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, copy) NSString *strUrl;
@property (nonatomic, strong) NSMutableDictionary *param;
@property (nonatomic, assign) BOOL isRefresh;
@property (nonatomic, assign) NSInteger pageIndex;

@end

@implementation FWVideoViewController

- (id)init
{
    self = [super init];
    if (self) {
        _pageIndex = 0;
        
        _contents = [NSMutableArray array];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    _userId = [DDXUserinfo getUserId];
    [self fetchDataVideoWithRefresh:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[FWContentVideoCell class] forCellReuseIdentifier:FWContentVideoCellIdentifier];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_header = [HZNormalHeader headerWithRefreshingBlock:^{
        [self fetchDataVideoWithRefresh:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing];//加载完成停止结束刷新
            
        });
    }];
    self.tableView.mj_footer = [XZZNormalFooter footerWithRefreshingBlock:^{
        [self fetchDataVideoWithRefresh:NO];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_footer endRefreshing];
            [AppDelegate new].isHiddenLoadView = YES;
        });
    }];
    
    __weak typeof(self) weakSelf = self;
    [weakSelf.tableView configReloadAction:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf.tableView hideAllGeneralPage];
        [strongSelf.tableView beginLoading];
        [strongSelf fetchDataVideoWithRefresh:YES];
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - fetch data

- (void)fetchDataVideoWithRefresh:(BOOL)isRefresh
{
    [self.tableView hideAllGeneralPage];
    
    if (isRefresh) {
        self.pageIndex = 0;
    }

    _strUrl = [NSString stringWithFormat:@"%@%@%@/%ld/3/%ld", DDXAPI_HTTP_PREFIX_Friend, DDXAPI_SHOPFRIEND_SR, DDXAPI_SHOPFRIEND_SR_CF_LIST, [DDXUserinfo getUserId], (long)_pageIndex];
    
    [DaHttpTool get:_strUrl
             params:nil
            success:^(id json) {
                NSLog(@"json == %@", json);
                
                BOOL isSuccess = [json[@"state"] isEqualToString:@"success"];
                NSDictionary *contentDic = json[@"content"];
                NSMutableArray *models = [NSMutableArray new];
                
                if (isSuccess) {
                    models = [NSArray osc_modelArrayWithClass:[FWContentItem class] json:contentDic[@"rows"]].mutableCopy;
                    
                    [models enumerateObjectsUsingBlock:^(FWContentItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        [obj calculateVideoLayoutIsHaveMoreBtn:NO];
                        [models replaceObjectAtIndex:idx withObject:obj];
                    }];
                    
                    if (models && models.count > 0) {//下拉得到的数据
                        if (isRefresh) {
                            [self.contents removeAllObjects];
                        }
                        self.pageIndex++;
                        [self.contents addObjectsFromArray:models];
                    }
                    
                    if (!([contentDic[@"currentPage"] longValue] < [contentDic[@"pageCount"] longValue])) {
                        [self.tableView.mj_footer endRefreshing];
                    }
                    
                    NSLog(@"重组视频数组个数%@", self.contents);
                    
                } else {
                    MBProgressHUD *HUD = [Util createHUD];
                    HUD.mode = MBProgressHUDModeCustomView;
                    HUD.labelText = json[@"content"][@"statusMsg"];
                    
                    [HUD hide:YES afterDelay:5];
                }
                
                if (self.contents.count == 0) {
                    [self.tableView showEmptyPageViewWithImage:[UIImage imageNamed:@"ico_empty_none"]
                                                           tip:@"小搭未发现任何数据"];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (isRefresh) {
                        [self.tableView.mj_header endRefreshing];
                    } else {
                        if ( (isSuccess && !models) || (isSuccess && models.count == 0)) {
                            [self.tableView.mj_footer endRefreshingWithNoMoreData];
                        }else{
                            [self.tableView.mj_footer endRefreshing];
                        }
                    }
                    
                    [self.tableView reloadData];
                });
            } failure:^(NSError *error) {
                //
                NSLog(@"error = %@", error);
                
                if (isRefresh) {
                    [self.tableView.mj_header endRefreshing];
                } else {
                    [self.tableView.mj_footer endRefreshing];
                }
                
                if (self.contents.count == 0) {
                    [self.tableView showEmptyPageViewWithImage:[UIImage imageNamed:@"ico_empty_fail"]
                                                           tip:@"与母星暂时失去联系啦"
                                                   buttonTitle:@"刷新"];
                }
                
                MBProgressHUD *HUD = [Util createHUD];
                HUD.mode = MBProgressHUDModeCustomView;
                HUD.labelText = [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]];
                
                [HUD hide:YES afterDelay:5];
            }];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    return self.contents.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    FWContentVideoCell *cell = [FWContentVideoCell returnResueCellFormTableView:tableView indexPath:indexPath identifier:FWContentVideoCellIdentifier];
    
    [self setBlockForCommentCell:cell];
    cell.myDelegate = self;
    if (self.contents.count) {
        FWContentItem *commentItem = self.contents[indexPath.row];
        cell.contentItem = commentItem;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.contents.count) {
        FWContentItem *commentItem = self.contents[indexPath.row];
        return commentItem.rowHeight + 6;
    }

    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FWContentItem *commentItem = self.contents[indexPath.row];

    /*
    NSString* videourlstr = commentItem.url;
    NSLog(@"视频的url%@",videourlstr);
    VideoAvplayerViewController* vvc=[[VideoAvplayerViewController alloc]init];
    vvc.videostr = videourlstr;
    [self.navigationController pushViewController:vvc animated:YES];
    
    */
    
    FWTDetailViewController *detailCtl = [[FWTDetailViewController alloc] initWithContentId:commentItem.id isResignFirstRe:NO contentItem:commentItem];
    detailCtl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailCtl animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    return action == @selector(copyText:);
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    // required
}

#pragma mark - UILongPressGestureRecognizer

- (void)setBlockForCommentCell:(FWContentCell *)cell
{
    cell.canPerformAction = ^ BOOL (UITableViewCell *cell, SEL action) {
        if (action == @selector(copyText:)) {
            return YES;
        } else if (action == @selector(deleteObject:)) {
            NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
            FWContentItem *contentItem = self.contents[indexPath.row];
            
            return (_userId == contentItem.publishId);
        }
        
        return NO;
    };
    
    cell.deleteObject = ^ (UITableViewCell *cell) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        FWContentItem *contentItem = self.contents[indexPath.row];
        
        MBProgressHUD *HUD = [Util createHUD];
        HUD.labelText = @"正在删除动态";
        
        NSString *strUrl = [NSString stringWithFormat:@"%@%@%@/%d", DDXAPI_HTTP_PREFIX_Friend, DDXAPI_SHOPFRIEND_SR, DDXAPI_SHOPFRIEND_SR_CF_DELETE, contentItem.id];
        
        [DaHttpTool get:strUrl
                 params:nil
                success:^(id json) {
                    //
                    NSLog(@"json==== %@", json);
                    BOOL isSuccess = [json[@"state"] isEqualToString:@"success"];
                    HUD.mode = MBProgressHUDModeCustomView;
                    
                    if (isSuccess) {
                        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-done"]];
                        HUD.labelText = @"动态删除成功";
                        
                        [self.contents removeObjectAtIndex:indexPath.row];
                        if (self.contents.count > 0) {
                            [self.tableView beginUpdates];
                            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
                            [self.tableView endUpdates];
                        }
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.tableView reloadData];
                        });
                    } else {
                        HUD.labelText = json[@"content"][@"statusMsg"];
                        
                        [HUD hide:YES afterDelay:5];
                    }
                    
                    [HUD hide:YES afterDelay:5];
                } failure:^(NSError *error) {
                    //
                    NSLog(@"error === %@", error);
                    HUD.mode = MBProgressHUDModeCustomView;
                    HUD.labelText = [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]];
                    
                    [HUD hide:YES afterDelay:5];
                }];
    };
}

#pragma mark - FWContentCellDelegate
- (void)touchLikeAction:(FWContentCell *)cell
{
    if (_userId > 0) {
        [self praiseAction:cell];
    } else {
        [self presentViewController:[LoginViewController new] animated:YES completion:nil];
    }
}

- (void)praiseAction:(FWContentCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    FWContentItem *contentItem = self.contents[indexPath.row];
    
    BOOL clickLike = [contentItem.isPraise isEqualToString:@"1"] ? NO : YES; //1为已点赞 0为未点赞
    NSString *praiseType = clickLike ? @"1" : @"2"; //1为去点赞 2为取消点赞
    
    [cell setLikeStatus:clickLike animation:YES];
    if (clickLike) {
        contentItem.praiseNum++;
    } else {
        contentItem.praiseNum--;
    }
    
    NSString *strUrl = [NSString stringWithFormat:@"%@%@%@/%ld/%ld/%@", DDXAPI_HTTP_PREFIX_Friend, DDXAPI_SHOPFRIEND_SR, DDXAPI_SHOPFRIEND_SR_CF_PRAISE, (long)contentItem.id, (long)[DDXUserinfo getUserId], praiseType];
    
    [DaHttpTool get:strUrl
             params:nil
            success:^(id json) {
                //
                NSLog(@"json==== %@", json);
                BOOL isSuccess = [json[@"state"] isEqualToString:@"success"];
                if (isSuccess) {
                    
                    contentItem.isPraise = clickLike ? @"1" : @"0";
                    
                    [self.contents replaceObjectAtIndex:indexPath.row withObject:contentItem];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView beginUpdates];
                        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                        [self.tableView endUpdates];
                    });
                    
                } else {
                    
                    [cell setLikeStatus:!clickLike animation:YES];
                    if (clickLike) {
                        contentItem.praiseNum--;
                    } else {
                        contentItem.praiseNum++;
                    }
                    
                    MBProgressHUD *HUD = [Util createHUD];
                    HUD.mode = MBProgressHUDModeCustomView;
                    HUD.labelText = json[@"content"][@"statusMsg"];
                    
                    [HUD hide:YES afterDelay:5];
                }
                
            } failure:^(NSError *error) {
                //
                NSLog(@"error === %@", error);
                [cell setLikeStatus:!clickLike animation:YES];
                if (clickLike) {
                    contentItem.praiseNum--;
                } else {
                    contentItem.praiseNum++;
                }
                
                MBProgressHUD *HUD = [Util createHUD];
                HUD.mode = MBProgressHUDModeCustomView;
                HUD.labelText = [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]];
                
                [HUD hide:YES afterDelay:5];
            }];
}

//跳转至动态详情评论
- (void)touchCommentAction:(FWContentCell *)cell
{
    if (_userId > 0) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        FWContentItem *contentItem = self.contents[indexPath.row];
        
        FWTDetailViewController *detailCtl = [[FWTDetailViewController alloc] initWithContentId:contentItem.id isResignFirstRe:YES contentItem:contentItem];
        detailCtl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailCtl animated:YES];
    } else {
        [self presentViewController:[LoginViewController new] animated:YES completion:nil];
    }
}

- (void)setVideoStartPlay:(FWContentCell *)cell
{
    NSLog(@"播放视频");
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    FWContentItem *contentItem = self.contents[indexPath.row];
    NSString* videourlstr = contentItem.url;
    NSLog(@"视频的url%@",videourlstr);
    VideoAvplayerViewController* vvc=[[VideoAvplayerViewController alloc]init];
    vvc.videostr = videourlstr;
    vvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vvc animated:YES];
    
}

@end
