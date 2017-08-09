//
//  FWTDetailViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/4/26.
//  Copyright © 2017年 李萍. All rights reserved.
//

/****** 动态详情列表  *****/
#import "FWTDetailViewController.h"
#import "GoodsCommentViewController.h"
#import "VideoAvplayerViewController.h"
#import "LoginViewController.h"

#import "FWCommentCell.h"
#import "FWContentImageCell.h"
#import "FWContentVideoCell.h"

#import "CommentItem.h"
#import "FWContentItem.h"

#import "DDXAPI.h"
#import "DaHttpTool.h"
#import "UIColorHF.h"

@interface FWTDetailViewController () <UITableViewDelegate, UITableViewDataSource, FWContentCellDelegate, UITextFieldDelegate>
{
    BOOL isShowKeyboard;
    BOOL isReply;
}

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *editView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UITextField *commentTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewConstraint;

@property (nonatomic, assign) long contentId;
@property (nonatomic, copy) NSString *strUrl;
@property (nonatomic, assign) NSInteger pagaIndex;
@property (nonatomic, assign) long parentId;

@property (nonatomic, strong) FWContentItem *contentItem;
@property (nonatomic, strong) NSMutableArray <CommentItem *> *comments;
@property (nonatomic, assign) NSInteger selectedIndexRow;
@property (nonatomic, assign) BOOL isResig; //第一响应者

@property (nonatomic, strong) UITapGestureRecognizer *tap;

@end

@implementation FWTDetailViewController

- (instancetype)initWithContentId:(NSInteger)contentId isResignFirstRe:(BOOL)isResig contentItem:(FWContentItem *)contentItem;
{
    self = [super init];
    if (self) {
        self.contentId = contentId;
//        self.contentItem = contentItem;
        _pagaIndex = 0;
        _parentId = 0;
        _comments = [NSMutableArray array];
        _isResig = isResig;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.editView.layer.cornerRadius = 5;
    [self.editView handleBoardWidth:1 andBorderColor:BackCellColor];
    self.commentTextField.delegate = self;
    if (self.isResig) {
        [self.commentTextField becomeFirstResponder];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"动态详情";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.tableView registerClass:[FWCommentCell class] forCellReuseIdentifier:commentCellIdentifier];
    [self.tableView registerClass:[FWContentImageCell class] forCellReuseIdentifier:FWContentImageCellIdentifier];
    [self.tableView registerClass:[FWContentVideoCell class] forCellReuseIdentifier:FWContentVideoCellIdentifier];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = BackCellColor;
    self.tableView.tableFooterView = [UIView new];
    
    [self fetchDetailInfoData];
    [self fetchCommentData:YES];
    [self.tableView.mj_footer beginRefreshing];
    
    self.tableView.mj_footer = [XZZNormalFooter footerWithRefreshingBlock:^{
        [self fetchCommentData:NO];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_footer endRefreshing];
        });
    }];
    
    //软键盘
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardAction:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardAction:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 获取数据
//动态详情
- (void)fetchDetailInfoData
{
    _strUrl = [NSString stringWithFormat:@"%@%@%@/%ld", DDXAPI_HTTP_PREFIX_Friend, DDXAPI_SHOPFRIEND_SR, DDXAPI_SHOPFRIEND_SR_CF_DETAILINFO, _contentId];
    [DaHttpTool get:_strUrl
             params:nil
            success:^(id json) {
                //

                NSLog(@"suc = %@", json);
                BOOL isSuccess = [json[@"state"] isEqualToString:@"success"];
                if (isSuccess) {
                    _contentItem = [FWContentItem osc_modelWithDictionary:json[@"content"]];
                    if (_contentItem.publishType == CircleFriendsPublicTypeText) {
                        [_contentItem calculateLayoutWithPortraitW:34 withImage:nil isHaveMoreBtn:NO];
                        
                    } else if (_contentItem.publishType == CircleFriendsPublicTypeImage) {
                        //图片处理
                        NSArray* iconarray=[_contentItem.url componentsSeparatedByString:@","];
                        _contentItem.images = iconarray;
                        
                        [_contentItem calculateLayoutWithPortraitW:34 withImage:iconarray isHaveMoreBtn:NO];
                        
                    } else if (_contentItem.publishType == CircleFriendsPublicTypeVedio) {
                        
                        [_contentItem calculateVideoLayoutIsHaveMoreBtn:NO];
                    }
                    
                } else {
                    
                    
                    MBProgressHUD *HUD = [Util createHUD];
                    HUD.mode = MBProgressHUDModeCustomView;
                    HUD.labelText = json[@"content"][@"statusMsg"];
                    
                    [HUD hide:YES afterDelay:5];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{

                    [self.tableView reloadData];
                });
                
            } failure:^(NSError *error) {
                //
                NSLog(@"fai = %@", [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]]);
                MBProgressHUD *HUD = [Util createHUD];
                HUD.mode = MBProgressHUDModeCustomView;
                HUD.labelText = [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]];
                
                [HUD hide:YES afterDelay:5];
            }];
}

//某一动态评论列表

- (void)fetchCommentData:(BOOL)isRefresh
{
    _strUrl = [NSString stringWithFormat:@"%@%@%@/%ld/%ld", DDXAPI_HTTP_PREFIX_Friend, DDXAPI_SHOPFRIEND_SR, DDXAPI_SHOPFRIEND_SR_FC_LIST, (long)_contentId, (long)_pagaIndex];
    
    [DaHttpTool get:_strUrl
             params:nil
            success:^(id json) {
                //
                
                NSLog(@"json = %@", json[@"content"]);
                BOOL isSuccess = [json[@"state"] isEqualToString:@"success"];
                NSMutableArray *models = [NSMutableArray new];
                if (isSuccess) {
                    models = [NSArray osc_modelArrayWithClass:[CommentItem class] json:json[@"content"][@"rows"]].mutableCopy;
                    [models enumerateObjectsUsingBlock:^(CommentItem *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        [obj calculateLayout];
                        [models replaceObjectAtIndex:idx withObject:obj];
                    }];
                    
                    [self.comments addObjectsFromArray:models];
                    self.pagaIndex++;
                    
                    if (!([json[@"content"][@"currentPage"] longValue] < [json[@"content"][@"pageCount"] longValue])) {
                        [self.tableView.mj_footer endRefreshing];
                    }
                } else {
                    
                    MBProgressHUD *HUD = [Util createHUD];
                    HUD.mode = MBProgressHUDModeCustomView;
                    HUD.labelText = json[@"content"][@"statusMsg"];
                    
                    [HUD hide:YES afterDelay:5];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if ( (isSuccess && !models) || (isSuccess && models.count == 0)) {
                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    } else {
                        [self.tableView.mj_footer endRefreshing];
                    }
                    [self.tableView reloadData];
                });
                
            } failure:^(NSError *error) {
                //
                
                NSLog(@"fai = %@", [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]]);
                MBProgressHUD *HUD = [Util createHUD];
                HUD.mode = MBProgressHUDModeCustomView;
                HUD.labelText = [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]];
                
                [HUD hide:YES afterDelay:5];
            }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_comments.count) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        if (_comments.count) {
            return _comments.count;
        } else {
            return 0;
        }
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (_contentItem.publishType == CircleFriendsPublicTypeVedio) {
            FWContentVideoCell *cell = [FWContentVideoCell returnResueCellFormTableView:tableView indexPath:indexPath identifier:FWContentVideoCellIdentifier];
            
            cell.myDelegate = self;

            cell.contentItem = _contentItem;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        } else {
            FWContentImageCell *cell = [FWContentImageCell returnResueCellFormTableView:tableView indexPath:indexPath identifier:FWContentImageCellIdentifier];

            cell.myDelegate = self;
        
            cell.contentItem = _contentItem;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        
    } else {
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        FWCommentCell *cell = [FWCommentCell returnResueCellFormTableView:tableView indexPath:indexPath identifier:commentCellIdentifier];
        
        if (_comments.count) {
            cell.commentItem = _comments[indexPath.row];
            [self setBlockForCommentCell:cell];
        } else {
            return [UITableViewCell new];
        }
        
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return _contentItem.rowHeight;
    } else {
        if (_comments.count) {
            CommentItem *commentItem = _comments[indexPath.row];
            return commentItem.rowHeight;
        } else {
            return 0;
        }
    }
    
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0 && self.comments.count > 0) {
        return 6;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section != 0) {
        CommentItem *item = self.comments[indexPath.row];
        
        if (_selectedIndexRow == indexPath.row) {
            
            isReply = !isReply;
        } else {
            isReply = YES;
            _selectedIndexRow = indexPath.row;
        }
        
//        isReply = !isReply;
        NSString *string = @"";
        if (isReply) {
            string = [NSString stringWithFormat:@"回复%@ ", item.alias];
            [self.commentTextField becomeFirstResponder];
            self.parentId = item.id;
        } else {
            string = @"";
            self.parentId = 0;
        }
        
        self.commentTextField.text = string;
        [self.commentTextField becomeFirstResponder];
    }
    
}

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return YES;
    }
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    return action == @selector(copyText:);
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    // required
}

#pragma mark - UILongPressGestureRecognizer //删除评论
- (void)setBlockForCommentCell:(FWCommentCell *)cell
{
    cell.canPerformAction = ^ BOOL (UITableViewCell *cell, SEL action) {
        if (action == @selector(copyText:)) {
            return YES;
        } else if (action == @selector(deleteObject:)) {
            NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
            CommentItem *item = self.comments[indexPath.row];
            
            return ([DDXUserinfo getUserId] == item.userId);
        }
        
        return NO;
    };
    
    cell.deleteObject = ^ (UITableViewCell *cell) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        CommentItem *item = self.comments[indexPath.row];
        
        MBProgressHUD *HUD = [Util createHUD];
        HUD.labelText = @"正在删除评论";
        
        NSString *strUrl = [NSString stringWithFormat:@"%@%@%@/%ld", DDXAPI_HTTP_PREFIX_Friend, DDXAPI_SHOPFRIEND_SR, DDXAPI_SHOPFRIEND_SR_FC_DELETE, item.id];
        
        [DaHttpTool get:strUrl
                 params:nil
                success:^(id json) {
                    //
                    NSLog(@"json==== %@", json);
                    BOOL isSuccess = [json[@"state"] isEqualToString:@"success"];
                    HUD.mode = MBProgressHUDModeCustomView;
                    
                    if (isSuccess) {
                        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-done"]];
                        HUD.labelText = @"评论删除成功";
                        
                        _contentItem.commentNum--;
                        [self.comments removeObjectAtIndex:indexPath.row];
                        if (self.comments.count > 0) {
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

- (void)praiseAction:(FWContentCell *)cell
{
}

#pragma mark - FWContentCellDelegate //点赞
- (void)touchLikeAction:(FWContentCell *)cell
{
    if ([DDXUserinfo getUserId]) {
        BOOL clickLike = [self.contentItem.isPraise isEqualToString:@"1"] ? NO : YES; //1为已点赞 0为未点赞
        NSString *praiseType = clickLike ? @"1" : @"2"; //1为去点赞 2为取消点赞
        
        [cell setLikeStatus:clickLike animation:YES];
        
        NSString *strUrl = [NSString stringWithFormat:@"%@%@%@/%ld/%ld/%@", DDXAPI_HTTP_PREFIX_Friend, DDXAPI_SHOPFRIEND_SR, DDXAPI_SHOPFRIEND_SR_CF_PRAISE, (long)self.contentItem.id, (long)[DDXUserinfo getUserId], praiseType];
        
        [DaHttpTool get:strUrl
                 params:@{
                          @"circleFriendsId" : @(self.contentId),
                          @"pageNo" : @(0),
                          }.mutableCopy
                success:^(id json) {
                    //
                    NSLog(@"json==== %@", json);
                    BOOL isSuccess = [json[@"state"] isEqualToString:@"success"];
                    if (isSuccess) {
                        
                        self.contentItem.isPraise = clickLike ? @"1" : @"0";
                        if (clickLike) {
                            self.contentItem.praiseNum++;
                        } else {
                            self.contentItem.praiseNum--;
                        }
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.tableView beginUpdates];
                            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
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
        
    } else {
        [self presentViewController:[LoginViewController new] animated:YES completion:nil];
    }
}

- (void)touchCommentAction:(FWContentCell *)cell
{
    
}

- (void)setVideoStartPlay:(FWContentCell *)cell
{
    NSLog(@"播放视频");
    NSString* videourlstr = _contentItem.url;
    NSLog(@"视频的url%@",videourlstr);
    VideoAvplayerViewController* vvc=[[VideoAvplayerViewController alloc]init];
    vvc.videostr = videourlstr;
    [self.navigationController pushViewController:vvc animated:YES];
    
}

#pragma mark - //发评论

- (void)postComment
{
    MBProgressHUD *HUD = [Util createHUD];
    HUD.labelText = @"正在发布评论...";
    
    NSString *strUrl = [NSString stringWithFormat:@"%@%@%@", DDXAPI_HTTP_PREFIX_Friend, DDXAPI_SHOPFRIEND_SR, DDXAPI_SHOPFRIEND_SR_FC_ADD];
    
    [DaHttpTool post:strUrl
              params:@{
                       @"circleFriendsId" : @(self.contentId),
                       @"userId"          : @([DDXUserinfo getUserId]),
                       @"parentId"        : @(self.parentId),
                       @"content"         : self.commentTextField.text
                       }.mutableCopy
             success:^(id json) {
                 NSLog(@"json==== %@", json);
                 BOOL isSuccess = [json[@"state"] isEqualToString:@"success"];
                 HUD.mode = MBProgressHUDModeCustomView;
                 
                 if (isSuccess) {
                     HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-done"]];
                     HUD.labelText = @"评论发布成功";
                     
                     NSString *date = json[@"content"][@"commentDate"];
                     long commentId = [json[@"content"][@"id"] longValue];
                     
                     [self setNewComment:date commentId:commentId];
                 } else {
                     
                     HUD.labelText = json[@"content"][@"statusMsg"];
                     
                     [HUD hide:YES afterDelay:5];
                 }
                 [HUD hide:YES afterDelay:5];
             } failure:^(NSError *error) {
                 NSLog(@"error === %@", error);
                 
                 HUD.mode = MBProgressHUDModeCustomView;
                 HUD.labelText = [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]];
                 
                 [HUD hide:YES afterDelay:5];
             }];
}

- (void)setNewComment:(NSString *)date commentId:(long)commentId
{
    DDXUserinfo *userInfo = [DDXUserinfo loadUserInfoFromSanbox];
    CommentItem *item = [CommentItem new];
    item.headerUrl = userInfo.headerUrl;
    item.alias = userInfo.alias;
    item.content = self.commentTextField.text;
    item.commentDate = date;
    item.id = commentId;
    item.circleFriendsId = self.contentId;
    item.userId = userInfo.id;
    item.parentId = self.parentId;
    
    [item calculateLayout];
    
    [self.comments addObject:item];
    self.commentTextField.text = @"";
    [self.commentTextField resignFirstResponder];
    _contentItem.commentNum++;
    [self.tableView reloadData];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (_commentTextField.text.length > 0) {
        NSLog(@"发评论");
        if ([DDXUserinfo getUserId]) {
            [self postComment];
        } else {
            [self presentViewController:[LoginViewController new] animated:YES completion:nil];
        }
        
    } else {
        MBProgressHUD *HUD = [Util createHUD];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.labelText = @"评论内容不能为空";
        
        [HUD hide:YES afterDelay:1.0];
    }
    return YES;
}

#pragma mark - 软键盘隐藏
- (void)keyBoardHiden:(UITapGestureRecognizer *)tap
{
    [_commentTextField resignFirstResponder];
    
    [self.view removeGestureRecognizer:_tap];
}

- (void)keyboardAction:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *animationDuration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval timeInt;
    [animationDuration getValue:&timeInt];
    
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    CGFloat keyBoradHeight = keyboardRect.size.height;
    if (keyBoradHeight <= 0) {
        return;
    }
    
    if (notification.name == UIKeyboardWillShowNotification) {
        if (isShowKeyboard == NO) {
            [UIView animateWithDuration:timeInt
                                  delay:0.f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.bottomViewConstraint.constant = keyBoradHeight;
                                 isShowKeyboard = YES;
                                 
                             } completion:^(BOOL finished) {
                                 isShowKeyboard = YES;
                             }];
            
            _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardHiden:)];
            [self.view addGestureRecognizer:_tap];
        } else {
            [UIView animateWithDuration:timeInt
                                  delay:0.f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.bottomViewConstraint.constant = keyBoradHeight;
                                 isShowKeyboard = YES;
                                 
                             } completion:^(BOOL finished) {
                                 isShowKeyboard = YES;
                             }];
        }
        
        
    } else if (notification.name == UIKeyboardWillHideNotification) {
        [UIView animateWithDuration:-timeInt
                              delay:0.f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             
                             self.bottomViewConstraint.constant = 0;
                             isShowKeyboard = NO;
                             
                         } completion:^(BOOL finished) {
                             isShowKeyboard = NO;
                         }];
    }
}

#pragma mark - dealloc

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
