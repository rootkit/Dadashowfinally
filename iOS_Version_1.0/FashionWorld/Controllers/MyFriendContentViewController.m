//
//  MyFriendContentViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/4/28.
//  Copyright © 2017年 李萍. All rights reserved.
//

/****** 我的动态列表  *****/
#import "MyFriendContentViewController.h"
#import "FWTDetailViewController.h"
#import "FashWordDetailViewController.h"
#import "FashioncircleViewController.h"
#import "VideoAvplayerViewController.h"

#import "FWContentVideoCell.h"
#import "FWContentImageCell.h"
#import "FWContentTextCell.h"
#import "FWContentItem.h"

#import "UIColorHF.h"

@interface MyFriendContentViewController () <FWContentCellDelegate>

@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, copy) NSString *listType;//类型0为用户发布，1为商家发布
@property (nonatomic, copy) NSString *strUrl;
@property (nonatomic, strong) NSMutableArray <FWContentItem *> *contents;

@end

@implementation MyFriendContentViewController

- (id)initWithUserId:(long)userId
{
    self = [super init];
    if (self) {
        _contents = [NSMutableArray array];
        _userId = userId;
        _pageIndex = 0;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView beginLoading];
    [self fetchDataWithRefresh:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的动态";
    
    [self.tableView registerClass:[FWContentTextCell class] forCellReuseIdentifier:FWContentTextCellIdentifier];
    [self.tableView registerClass:[FWContentImageCell class] forCellReuseIdentifier:FWContentImageCellIdentifier];
    [self.tableView registerClass:[FWContentVideoCell class] forCellReuseIdentifier:FWContentVideoCellIdentifier];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    [self fetchDataWithRefresh:YES];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_header = [HZNormalHeader headerWithRefreshingBlock:^{
        [self fetchDataWithRefresh:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing];//加载完成停止结束刷新
            
        });
    }];
    self.tableView.mj_footer = [XZZNormalFooter footerWithRefreshingBlock:^{
        [self fetchDataWithRefresh:NO];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_footer endRefreshing];
        });
    }];
    
    __weak typeof(self) weakSelf = self;
    [weakSelf.tableView configReloadAction:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf.tableView hideAllGeneralPage];
        [strongSelf.tableView beginLoading];
        [strongSelf fetchDataWithRefresh:YES];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - fetch data
- (void)fetchDataWithRefresh:(BOOL)isRefresh
{
    [self.tableView hideAllGeneralPage];
    
    if (isRefresh) { self.pageIndex = 0; }
    
    _strUrl = [NSString stringWithFormat:@"%@%@%@/%ld/0/%ld", DDXAPI_HTTP_PREFIX_Friend, DDXAPI_SHOPFRIEND_SR, DDXAPI_SHOPFRIEND_SR_CF_PUBLISHLIST, _userId, _pageIndex];
    
    [DaHttpTool get:_strUrl
             params:nil
            success:^(id json) {
                
                NSLog(@"json = %@", json[@"content"]);
                BOOL isSuccess = [json[@"state"] isEqualToString:@"success"];
                NSMutableArray *models = [NSMutableArray new];
                
                if (isSuccess) {
                    models = [NSArray osc_modelArrayWithClass:[FWContentItem class] json:json[@"content"][@"rows"]].mutableCopy;
                    
                    if (models.count > 0) {
                        [models enumerateObjectsUsingBlock:^(FWContentItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            if (obj.publishType == CircleFriendsPublicTypeText) {
                                [obj calculateLayoutWithPortraitW:34 withImage:nil isHaveMoreBtn:NO];
                                [models replaceObjectAtIndex:idx withObject:obj];

                            } else if (obj.publishType == CircleFriendsPublicTypeImage) {
                                //图片处理
                                NSArray* iconarray=[obj.url componentsSeparatedByString:@","];
                                obj.images = iconarray;
                                
                                [obj calculateLayoutWithPortraitW:34 withImage:iconarray isHaveMoreBtn:NO];
                                [models replaceObjectAtIndex:idx withObject:obj];

                            } else if (obj.publishType == CircleFriendsPublicTypeVedio) {
                                
                                [obj calculateVideoLayoutIsHaveMoreBtn:NO];
                                [models replaceObjectAtIndex:idx withObject:obj];
                            }
                        }];
                    } else {
                        MBProgressHUD *HUD = [Util createHUD];
                        HUD.mode = MBProgressHUDModeCustomView;
                        HUD.labelText = @"已加载完毕";
                        
                        [HUD hide:YES afterDelay:5];
                    }
                    
                    if (models && models.count > 0) {//下拉得到的数据
                        if (isRefresh) {
                            [self.contents removeAllObjects];
                        }
                        self.pageIndex++;
                        [self.contents addObjectsFromArray:models];
                    }
                    
                    if (!([json[@"content"][@"currentPage"] longValue] < [json[@"content"][@"pageCount"] longValue])) {
                        [self.tableView.mj_footer endRefreshing];
                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    }
                    
                    NSLog(@"重组的可以数组个数%@", self.contents);
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

//                MBProgressHUD *HUD = [Util createHUD];
//                HUD.mode = MBProgressHUDModeCustomView;
//                HUD.labelText = [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]];
//                
//                [HUD hide:YES afterDelay:5];
            }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.contents.count > 0) {
        return 2;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        if (_contents.count) {
            return _contents.count;
        }
        return 0;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        cell.imageView.image = [UIImage imageNamed:@"ico_fbdt-1"];
        cell.textLabel.text = @"发布动态";
        cell.textLabel.textColor = FirstTextColor;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    } else {
        if (_contents.count) {
            
            FWContentItem *commentItem = _contents[indexPath.row];
            if (commentItem.publishType == CircleFriendsPublicTypeVedio) {
                FWContentVideoCell *cell = [FWContentVideoCell returnResueCellFormTableView:tableView indexPath:indexPath identifier:FWContentVideoCellIdentifier];
                
                [self setBlockForCommentCell:cell];
                cell.contentItem = commentItem;
                cell.myDelegate = self;
                
                return cell;
            } else if (commentItem.publishType == CircleFriendsPublicTypeText) {
                FWContentTextCell *cell = [FWContentTextCell returnResueCellFormTableView:tableView indexPath:indexPath identifier:FWContentTextCellIdentifier];
                
                [self setBlockForCommentCell:cell];
                cell.contentItem = commentItem;
                cell.myDelegate = self;
                
                return cell;
            } else {
                FWContentImageCell *cell = [FWContentImageCell returnResueCellFormTableView:tableView indexPath:indexPath identifier:FWContentImageCellIdentifier];
                [self setBlockForCommentCell:cell];
                cell.tag=100+indexPath.row;
                cell.contentItem = commentItem;
                
                cell.myDelegate = self;
                
                return cell;
            }
        }

    }
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 36;
    } else {
        if (_contents.count) {
            FWContentItem *commentItem = _contents[indexPath.row];
            return commentItem.rowHeight + 6;
        } else {}
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.contents.count) {
        if (section == 0) {
            return 6;
        } else {
            return 0;
        }
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.contents.count) {
        if (section == 0) {
            return 3;
        } else {
            return 0;
        }
    } else {
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        //
        NSLog(@"发布动态");
        [self.navigationController pushViewController:[FashioncircleViewController new] animated:YES];
    } else {
//        FashWordDetailViewController *detailCtl = [FashWordDetailViewController new];
//        detailCtl.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:detailCtl animated:YES];
        
        FWContentItem *commentItem = self.contents[indexPath.row];
        FWTDetailViewController *detailCtl = [[FWTDetailViewController alloc] initWithContentId:commentItem.id isResignFirstRe:NO contentItem:commentItem];
        detailCtl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailCtl animated:YES];
    }
    
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

- (void)setVideoStartPlay:(FWContentCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    FWContentItem *commentItem = self.contents[indexPath.row];
    
    NSLog(@"播放视频");
    VideoAvplayerViewController *ctl=[[VideoAvplayerViewController alloc]init];
    ctl.videostr = commentItem.url;
    [self.navigationController pushViewController:ctl animated:YES];
}

#pragma mark - FWContentCellDelegate
//点赞
- (void)touchLikeAction:(FWContentCell *)cell
{
    NSLog(@"点赞点赞点赞");
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    FWContentItem *contentItem = self.contents[indexPath.row];
    
    BOOL clickLike = [contentItem.isPraise isEqualToString:@"1"] ? NO : YES; //1为已点赞 0为未点赞
    NSString *praiseType = clickLike ? @"1" : @"2"; //1为去点赞 2为取消点赞
    
    [cell setLikeStatus:clickLike animation:YES];
    
    NSString *strUrl = [NSString stringWithFormat:@"%@%@%@/%ld/%ld/%@", DDXAPI_HTTP_PREFIX_Friend, DDXAPI_SHOPFRIEND_SR, DDXAPI_SHOPFRIEND_SR_CF_PRAISE, (long)contentItem.id, (long)[DDXUserinfo getUserId], praiseType];
    
    [DaHttpTool get:strUrl
             params:nil
            success:^(id json) {
                //
                NSLog(@"json==== %@", json);
                BOOL isSuccess = [json[@"state"] isEqualToString:@"success"];
                if (isSuccess) {
                    
                    contentItem.isPraise = clickLike ? @"1" : @"0";
                    if (clickLike) {
                        contentItem.praiseNum++;
                    } else {
                        contentItem.praiseNum--;
                    }
                    
                    if (contentItem.publishType == CircleFriendsPublicTypeText) {
                        
                        [contentItem calculateLayoutWithPortraitW:34 withImage:nil isHaveMoreBtn:NO];
                    } else if (contentItem.publishType == CircleFriendsPublicTypeImage) {
                        
                        [contentItem calculateLayoutWithPortraitW:34 withImage:contentItem.images isHaveMoreBtn:NO];
                    } else if (contentItem.publishType == CircleFriendsPublicTypeVedio) {
                        
                        [contentItem calculateVideoLayoutIsHaveMoreBtn:NO];
                    }
                    
                    [self.contents replaceObjectAtIndex:indexPath.row withObject:contentItem];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView beginUpdates];
                        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:1]] withRowAnimation:UITableViewRowAnimationAutomatic];
                        [self.tableView endUpdates];
                    });
                    
                } else {
                    
                    [cell setLikeStatus:!clickLike animation:YES];
                    
                    MBProgressHUD *HUD = [Util createHUD];
                    HUD.mode = MBProgressHUDModeCustomView;
                    HUD.labelText = json[@"content"][@"statusMsg"];
                    
                    [HUD hide:YES afterDelay:5];
                }
                
            } failure:^(NSError *error) {
                //
                NSLog(@"error === %@", error);
                [cell setLikeStatus:!clickLike animation:YES];
                
                MBProgressHUD *HUD = [Util createHUD];
                HUD.mode = MBProgressHUDModeCustomView;
                HUD.labelText = [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]];
                
                [HUD hide:YES afterDelay:5];
            }];
}

//跳转至动态详情评论
- (void)touchCommentAction:(FWContentCell *)cell
{
    NSLog(@"评论");
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    FWContentItem *contentItem = self.contents[indexPath.row];
    
    FWTDetailViewController *detailCtl = [[FWTDetailViewController alloc] initWithContentId:contentItem.id isResignFirstRe:YES contentItem:contentItem];
    detailCtl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailCtl animated:YES];
}

@end
