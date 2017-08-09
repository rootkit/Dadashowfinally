//
//  BrandsHeaderCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/27.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "BrandsHeaderCell.h"
#import "FifthHeaderView.h"

@interface BrandsHeaderCell () <FifthHeaderViewDelegate>

@end

@implementation BrandsHeaderCell

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
    BrandsHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)layoutSubviewCell
{
    FifthHeaderView *headerView = [FifthHeaderView new];
    headerView.delegate = self;
    [self.contentView addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(@(15*rating));
        make.bottom.equalTo(@(0));
        make.right.equalTo(@(0));
    }];
}

- (void)clickPerferGoodsWithTags:(NSInteger)indexRow
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickActionWithBrandsHeaderCellDelegate:forIndexTags:)]) {
        [_delegate clickActionWithBrandsHeaderCellDelegate:self forIndexTags:indexRow];
    }
}

@end
