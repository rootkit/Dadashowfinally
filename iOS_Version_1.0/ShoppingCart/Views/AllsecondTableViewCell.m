//
//  AllsecondTableViewCell.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/25.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "AllsecondTableViewCell.h"
#define imagewidth  (kScreen_Width-40*(kScreen_Height/667))/3
#define imageleft  12*(kScreen_Height/667)

@interface AllsecondTableViewCell()
//@property(nonatomic,strong)UIImageView* iconimageview;
@end
@implementation AllsecondTableViewCell

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
    AllsecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)layoutSubviewCell
{
   for (int i=0; i<3; i++) {
        UIImageView* iconimageview=[[UIImageView alloc]init];
        [self addSubview: iconimageview];
        iconimageview.image=[UIImage imageNamed:@"goodsecond"];
        [iconimageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(5*(kScreen_Height/667)));
            make.left.equalTo(@(imageleft+(8*(kScreen_Height/667)+imagewidth)*i));
            make.width.height.equalTo(@(imagewidth));
        }];
    }
}
@end
