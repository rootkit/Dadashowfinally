//
//  FashWordDetailcell.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/6/14.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "FashWordDetailcell.h"
#import "UIImageView+Comment.h"
#import "MYCoreTextLabel.h"
#define PORTRAIT_WIDTH_HEIGHT 42
@interface FashWordDetailcell()<MYCoreTextLabelDelegate>
@property (nonatomic, strong) UIImageView *portraitIMG;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) MYCoreTextLabel *subcontentLabel;
@end


@implementation FashWordDetailcell

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
    FashWordDetailcell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
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
    _nameLabel.font = [UIFont systemFontOfSize:13];
    _nameLabel.textColor = SecondTextColor;
    [self.contentView addSubview:_nameLabel];
    
    _timeLabel = [UILabel new];
    _timeLabel.font = [UIFont systemFontOfSize:10];
    _timeLabel.textColor = [UIColor colorWithHex:0xa5a7a9];
    [self.contentView addSubview:_timeLabel];
    
    _contentLabel = [UILabel new];
    _contentLabel.font = [UIFont systemFontOfSize:13];
    _contentLabel.numberOfLines = 0;
    _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _contentLabel.textColor = SecondTextColor;
    [self.contentView addSubview:_contentLabel];
    
    _subcontentLabel = [MYCoreTextLabel new];
    _subcontentLabel.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    _subcontentLabel.textColor = SecondTextColor;
    _subcontentLabel.delegate = self;
    _subcontentLabel.norLinkFont = [UIFont systemFontOfSize:13]; //设置常规链接的字体大小
    _subcontentLabel.norLinkBackColor = [UIColor yellowColor];
    _subcontentLabel.textFont=[UIFont systemFontOfSize:13];
    //_subcontentLabel.lineSpacing = 2;    //设置行间距
    //_subcontentLabel.wordSpacing = 1.5;  //设置字间距
    [self.contentView addSubview:_subcontentLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _portraitIMG.frame = _commentItem.commentLayoutInfo.userPortraitIMGFrame;
    _nameLabel.frame = _commentItem.commentLayoutInfo.userNameLbFrame;
    _timeLabel.frame = _commentItem.commentLayoutInfo.timeLbFrame;
    _contentLabel.frame = _commentItem.commentLayoutInfo.contentLbFrame;
    _subcontentLabel.frame=_commentItem.commentLayoutInfo.subcontentLbFrame;

}

-(void)setCommentItem:(DetailComment *)commentItem{
    _commentItem = commentItem;
    [_portraitIMG loadPortrait:[NSURL URLWithString:commentItem.portraitUrl]];
    _nameLabel.text = commentItem.username;
    _timeLabel.text = commentItem.time;
    _contentLabel.text = commentItem.content;
    NSString*  subbeginstr=nil;
    if (commentItem.friendnamearray.count==0||commentItem.stringarray==0) {
        subbeginstr=@"";
    }else{
    subbeginstr=[NSString stringWithFormat:@"%@:%@",commentItem.friendnamearray[0],commentItem.stringarray[0]];
    for (int i=0; i<commentItem.stringarray.count-1; i++) {
        subbeginstr=[NSString stringWithFormat:@"%@\n%@:%@",subbeginstr,commentItem.friendnamearray[i+1],commentItem.stringarray[i+1]];
    }
    }
   
    _subcontentLabel.keyWordColor = [UIColor redColor]; //设置关键字颜色
    [_subcontentLabel setText:subbeginstr customLinks:commentItem.friendnamearray keywords:nil];
    [self layoutSubviews];
}

- (void)linkText:(NSString *)clickString type:(MYLinkType)linkType
{
    NSLog(@"----------%@--------%li",clickString,linkType);
//    if (_delegate && [_delegate respondsToSelector:@selector(clickfirendusername:)]) {
//        [_delegate clickfirendusername:self];
//        }
    if (_delegate&&[_delegate respondsToSelector:@selector(clickfirendusername:firendid:)]) {
        [_delegate clickfirendusername:self firendid:clickString];
    }

}
@end
