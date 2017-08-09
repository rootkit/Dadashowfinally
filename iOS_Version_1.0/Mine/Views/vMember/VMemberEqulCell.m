//
//  VMemberEqulCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/9.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "VMemberEqulCell.h"

@interface VMemberEqulCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconIMG;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *descLb;


@end

@implementation VMemberEqulCell

+(instancetype)returnReuseCellFormTableView:(UITableView *)tableView
                                  indexPath:(NSIndexPath *)indexPath
                                 identifier:(NSString *)identifierString
{
    VMemberEqulCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierString forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)setModel:(EqulModel *)model
{
    _model = model;
    _iconIMG.image = [UIImage imageNamed:_model.iconName];
    _titleLb.text = _model.titleStr;
    _descLb.text = _model.descStr;
}

@end

@implementation EqulModel

@end
