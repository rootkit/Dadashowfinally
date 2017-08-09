//
//  LogistCell.m
//  iOS_Version_1.0
//
//  Created by 李萍 on 2017/4/21.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "LogistCell.h"
#import "UIColor+CustomColor.h"
#import "UIColorHF.h"
@interface LogistCell ()

@property (nonatomic, weak) IBOutlet UIView *backView;

@property (nonatomic, weak) IBOutlet UIImageView *picIMGView;
@property (nonatomic, weak) IBOutlet UILabel *orderTypeLabel;
@property (nonatomic, weak) IBOutlet UILabel *orderLabel;
@property (nonatomic, weak) IBOutlet UILabel *orderNumabel;

@end

@implementation LogistCell

+(instancetype)returnReuseCellFormTableView:(UITableView *)tableView
                                  indexPath:(NSIndexPath *)indexPath
                                 identifier:(NSString *)identifierString
{
    LogistCell* cell = [tableView dequeueReusableCellWithIdentifier:identifierString
                                                       forIndexPath:indexPath];
    
    
    return cell;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = BackCellColor;
    _backView.layer.cornerRadius = 5;
    _backView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    _backView.layer.shadowOffset = CGSizeMake(1, 1);
    _backView.layer.shadowOpacity = 0.7; //设置阴影的不透明度
    _backView.layer.shadowRadius = 4.0;  //设置阴影的半径
    
    _picIMGView.contentMode = UIViewContentModeCenter;
    _picIMGView.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
