//
//  KindchooseTableViewCell.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/6/5.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "KindchooseTableViewCell.h"
#define offset  kScreen_Width-50*(kScreen_Width/375)
#define buttonBackgroundColor [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1]
@interface KindchooseTableViewCell ()
{
    NSMutableArray *buttonArr;
}

@end
@implementation KindchooseTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView dataArr:(NSMutableArray *)arr indexPath:(NSIndexPath *)indexPath
{
    NSString * baseCell =@"KindchooseTableViewCellidentifier";
    KindchooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:baseCell];
    if (!cell) {
        cell = [[KindchooseTableViewCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:baseCell dataArr:arr];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier dataArr:(NSMutableArray *)arr
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        buttonArr = [NSMutableArray array];
        for (int i=0; i< arr.count; i++) {
            UIButton *button = [[UIButton alloc]init];
            [button setBackgroundColor:buttonBackgroundColor];
            button.titleLabel.font = [UIFont systemFontOfSize:13.0*(kScreen_Width/375)];
            button.tag = i;
            button.clipsToBounds = YES;
            button.layer.cornerRadius = 6.0*(kScreen_Width/375);
            [button setTitleColor:[UIColor colorWithHex:0x6d6d6d] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithHex:0xfc5c98] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:button];
                        //是否展开选项
                        if ([self.isShrinkage isEqualToString:@"YES"]) {
                            button.hidden = NO;
                        }else {
                            if (i > 5) {
                                button.hidden = YES;
                            }
                        }
            [buttonArr addObject:button];
        }
    }
    return self;
}

- (void)buttonClick:(UIButton *)button
{
    if (!button.selected) {
        button.selected = YES;
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setBackgroundImage:[UIImage imageNamed:@"ico_bianh"] forState:UIControlStateSelected];
        [self.delegate selectedValueChangeBlock:self.tag key:button.tag value:@"YES"];
    }else {
        button.selected = NO;
        [button setBackgroundColor:[UIColor colorWithHex:0xededed]];

        [self.delegate selectedValueChangeBlock:self.tag key:button.tag value:@"NO"];
    }
}

- (void)setSelectedArr:(NSMutableArray *)selectedArr
{
    for (int i = 0; i < selectedArr.count; i++) {
        UIButton *button = buttonArr[i];
        //是否为选中状态
        NSString *selectedStr = selectedArr[i];
        if ([selectedStr isEqualToString:@"YES"]) {
            button.selected = YES;
            [button setBackgroundColor:[UIColor whiteColor]];
            [button setBackgroundImage:[UIImage imageNamed:@"ico_bianh"] forState:UIControlStateSelected];
        }else {
            button.selected = NO;
            [button setBackgroundColor:[UIColor colorWithHex:0xededed]];
        }
    }
}

- (void)setAttributeArr:(NSMutableArray *)attributeArr
{
    /** 九宫格布局算法 */
    CGFloat spacing = 6*(kScreen_Width/375);//行 间距
    CGFloat locspacing = 12*(kScreen_Width/375);//列 间距
    int totalloc = 3;//列数
    CGFloat appvieww = (kScreen_Width - 90*(kScreen_Width/375))/totalloc;
    CGFloat appviewh = 40*(kScreen_Width/375);
    int row = 0 ;
    for (int i=0; i< attributeArr.count; i++) {
        row = i/totalloc;//行号
        int loc = i%totalloc;//列号
        
        CGFloat appviewx = 14*(kScreen_Width/375) + (spacing + appvieww) * loc;
        CGFloat appviewy = spacing + (locspacing + appviewh) * row;
        
        UIButton *button = buttonArr[i];
        button.backgroundColor=[UIColor colorWithHex:0xededed];
        
        button.frame = CGRectMake(appviewx, appviewy, appvieww, appviewh);
        
        [button setTitle:attributeArr[i] forState:UIControlStateNormal];
        
        if ([self.isShrinkage isEqualToString:@"YES"]) {
            button.hidden = NO;
        }else {
            if (i > 5) {
                button.hidden = YES;
            }
        }
    }
    if ([self.isShrinkage isEqualToString:@"YES"]) {
        _height = (locspacing + appviewh) * (row + 1) + locspacing;
    }else {
        _height = 110*(kScreen_Width/375);
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
