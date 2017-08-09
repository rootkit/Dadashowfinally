//
//  FamousbrandCell.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/17.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "FamousbrandCell.h"

@implementation FamousbrandCell

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
    FamousbrandCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)layoutSubviewCell
{
    UIImageView* backimageview=[[UIImageView alloc]init];
    backimageview.image=[UIImage imageNamed:@"bb_2"];
    [self addSubview:backimageview];
    [backimageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@-0);
        make.bottom.equalTo(@-0);
    }];
    
    UIView* titleview=[[UIView alloc]init];
    titleview.backgroundColor=[UIColor colorWithHex:0xffffff];
    [backimageview addSubview:titleview];
    [titleview.layer setMasksToBounds:YES];
    [titleview.layer setCornerRadius:5.0];
    [titleview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(29*(kScreen_Height/667)));
        make.left.equalTo(@(29*(kScreen_Height/667)));
        make.width.equalTo(@(150*(kScreen_Height/667)));
        make.height.equalTo(@(91*(kScreen_Height/667)));
    }];
    
    
    UIImageView* lineview=[[UIImageView alloc]init];
    lineview.frame=CGRectMake(0, 60*(kScreen_Height/667), kScreen_Width, 2*(kScreen_Height/667));
    lineview.image = [self drawLineOfDashByImageView:lineview];
    [titleview addSubview: lineview];
    
    UILabel *bottomLabel = [[UILabel alloc] init];
    bottomLabel.font = [UIFont systemFontOfSize:12*(kScreen_Height/667)];
    bottomLabel.textColor=[UIColor colorWithHex:0x3f3f3f];
    bottomLabel.text=@"全场满299减50";
    bottomLabel.textAlignment=NSTextAlignmentCenter;
    [titleview addSubview:bottomLabel];
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineview.mas_bottom).equalTo(@(3*(kScreen_Height/667)));
        make.left.equalTo(@0);
        make.right.equalTo(@-0);
    }];
    
    UILabel *favorable = [[UILabel alloc] init];
    favorable.font = [UIFont systemFontOfSize:15*(kScreen_Height/667)];
    favorable.textColor=[UIColor colorWithHex:0x3f3f3f];
    favorable.text=@"买一送一";
    favorable.textAlignment=NSTextAlignmentCenter;
    [titleview addSubview:favorable];
    [favorable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineview.mas_top).equalTo(@(-3*(kScreen_Height/667)));
        make.left.equalTo(@0);
        make.right.equalTo(@-0);
    }];
    
}
- (UIImage *)drawLineOfDashByImageView:(UIImageView *)imageView {
    // 开始划线 划线的frame
    UIGraphicsBeginImageContext(imageView.frame.size);
    
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    
    // 获取上下文
    CGContextRef line = UIGraphicsGetCurrentContext();
    
    // 设置线条终点的形状
    CGContextSetLineCap(line, kCGLineCapRound);
    // 设置虚线的长度 和 间距
    CGFloat lengths[] = {2,2};
    
    CGContextSetStrokeColorWithColor(line, [UIColor colorWithHex:0xaeaeae].CGColor);
    // 开始绘制虚线
    CGContextSetLineDash(line, 0, lengths, 2);
    
    CGContextMoveToPoint(line, 0.0, 2.0);
    
    CGContextAddLineToPoint(line, 300, 2.0);
    
    CGContextStrokePath(line);
    
    // UIGraphicsGetImageFromCurrentImageContext()返回的就是image
    return UIGraphicsGetImageFromCurrentImageContext();
}


@end
