//
//  AllgoodsTableViewCell.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/25.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "AllgoodsTableViewCell.h"
#define imagewidth ((kScreen_Width-36*(kScreen_Height/667)))/2
@interface AllgoodsTableViewCell()
//@property(nonatomic,strong)UIImageView* iconimageview;
@end
@implementation AllgoodsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self layoutSubviewCell];
        
    }
    return  self;
}

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier
{
    AllgoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIImage* image=[UIImage imageNamed:@"bg_1"];
    cell.contentView.layer.contents =(UIImage*)image.CGImage;
    return cell;
}
-(void)layoutSubviewCell
{
    UIImageView* lefticonimageview=[[UIImageView alloc]init];
    [self addSubview: lefticonimageview];
    lefticonimageview.image=[UIImage imageNamed:@"allgoods"];
    [lefticonimageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(5*(kScreen_Height/667)));
        make.left.equalTo(@(12*(kScreen_Height/667)));
        make.width.height.equalTo(@(imagewidth));
    }];
    
    UIImageView* righticonimageview=[[UIImageView alloc]init];
    [self addSubview: righticonimageview];
    righticonimageview.image=[UIImage imageNamed:@"allgoods"];
    [righticonimageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(5*(kScreen_Height/667)));
        make.right.equalTo(@(-12*(kScreen_Height/667)));
        make.width.height.equalTo(@(imagewidth));
    }];
}


@end
