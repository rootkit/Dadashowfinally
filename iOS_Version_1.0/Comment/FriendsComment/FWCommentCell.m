//
//  FWCommentCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/4/26.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "FWCommentCell.h"

#import <Masonry/Masonry.h>

#import "UIColorHF.h"
#import "UIImageView+Comment.h"

#define PORTRAIT_WIDTH_HEIGHT 42


@interface FWCommentCell ()

@property (nonatomic, strong) UIImageView *portraitIMG;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation FWCommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubViews];
    }
    
    return self;
}

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier
{
    FWCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)initSubViews
{
    _portraitIMG = [UIImageView new];
    _portraitIMG.backgroundColor = [UIColor themeColor];
    [_portraitIMG handleCornerRadiusWithRadius:PORTRAIT_WIDTH_HEIGHT/2];
    
    [self.contentView addSubview:_portraitIMG];
    
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:cell_nameLB_fontsize];
    _nameLabel.textColor = SecondTextColor;
    [self.contentView addSubview:_nameLabel];
    
    _timeLabel = [UILabel new];
    _timeLabel.font = [UIFont systemFontOfSize:10];
    _timeLabel.textColor = [UIColor colorWithHex:0xa5a7a9];
    [self.contentView addSubview:_timeLabel];
    
    _contentLabel = [UILabel new];
    _contentLabel.font = [UIFont systemFontOfSize:cell_contentLB_fontsize];
    _contentLabel.numberOfLines = 0;
    _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _contentLabel.textColor = SecondTextColor;
    [self.contentView addSubview:_contentLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _portraitIMG.frame = _commentItem.commentLayoutInfo.userPortraitIMGFrame;
    _nameLabel.frame = _commentItem.commentLayoutInfo.userNameLbFrame;
    _timeLabel.frame = _commentItem.commentLayoutInfo.timeLbFrame;
    _contentLabel.frame = _commentItem.commentLayoutInfo.contentLbFrame;
}

- (void)setCommentItem:(CommentItem *)commentItem
{
    _commentItem = commentItem;
    
    [_portraitIMG loadPortrait:[NSURL URLWithString:commentItem.headerUrl]];
    _nameLabel.text = commentItem.alias.length ? commentItem.alias : @"火星人";
    _timeLabel.text = commentItem.commentDate.length ? commentItem.commentDate : @"时间";
    _contentLabel.text = commentItem.content;
    
    [self layoutSubviews];
}

#pragma mark - 处理长按操作

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return _canPerformAction(self, action);
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)copyText:(id)sender
{
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    [pasteBoard setString:_contentLabel.text];
}

- (void)deleteObject:(id)sender
{
    _deleteObject(self);
}

@end
