//
//  WalletTableViewCell.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/15.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "WalletTableViewCell.h"
@interface WalletTableViewCell()
@property(nonatomic,strong)NSArray* imagenamearray;
@property(nonatomic,strong)NSArray* titlearray;
@property(nonatomic,strong)UIImageView* iconimageview;
@property(nonatomic,strong)UILabel* titlelabel;
@property(nonatomic,strong)UILabel* rightlabel;

@end

@implementation WalletTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (NSArray *)imagenamearray
{
    if (!_imagenamearray) {
        _imagenamearray = [NSArray array];
        _imagenamearray=@[@"wallet_certification",@"wallet_payment",@"wallet_security",@"wallet_help"];
    }
    return _imagenamearray;
}
- (NSArray *)titlearray
{
    if (!_titlearray) {
        _titlearray = [NSArray array];
        _titlearray=@[@"实名认证",@"支付设置",@"安全中心",@"帮助中心"];
    }
    return _titlearray;
}


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self imagenamearray];
        [self titlearray];
        [self layoutSubviewCell];
        
        
    }
    return  self;
}

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier
{
    WalletTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString* imgname=[NSString stringWithFormat:@"%@",cell.imagenamearray[indexPath.row]];
    cell.iconimageview.image=[UIImage imageNamed:imgname];
    cell.titlelabel.text=cell.titlearray[indexPath.row];
    if (indexPath.row==0) {
    cell.rightlabel.text=@"未实名认证";
    }

    
    
    return cell;
}

-(void)layoutSubviewCell
{
       UIImageView* iconimageview=[[UIImageView alloc]init];
    [self addSubview: iconimageview];
    [iconimageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@18);
        make.left.equalTo(@12);
        make.width.height.equalTo(@16);
    }];
    _iconimageview=iconimageview;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textColor=[UIColor colorWithHex:0x353535];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@18);
        make.left.equalTo(iconimageview.mas_right).equalTo(@8);
    }];
    _titlelabel=titleLabel;
    
    UIImageView* backimageview=[[UIImageView alloc]init];
    backimageview.image=[UIImage imageNamed:@"wallet_right"];
    [self addSubview: backimageview];
    [backimageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@18);
        make.right.equalTo(@-12);
        make.width.equalTo(@8);
        make.height.equalTo(@14);
    }];
    
    UILabel *rightLabel = [[UILabel alloc] init];
    rightLabel.font = [UIFont systemFontOfSize:11];
    rightLabel.textColor=[UIColor colorWithHex:0xaeaeae];
    [self addSubview:rightLabel];
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backimageview.mas_top);
        make.right.equalTo(backimageview.mas_left).equalTo(@-11);
    }];
    _rightlabel=rightLabel;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
