//
//  SearchView.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/31.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "SearchView.h"
#import "UISearchBar+JCSearchBarPlaceholder.h"
@interface SearchView ()<UISearchBarDelegate>
@property(nonatomic , strong)UISearchBar * searchBar;



@end

@implementation SearchView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreen_Width,44);
     
        [self searchBar];
    }
    return self;
}

- (UISearchBar *)searchBar
{
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc]init];
        [_searchBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0xeaeaea]]];//背景图片
        [_searchBar sizeToFit];
        [_searchBar changeLeftPlaceholder:@"女装"];
        [_searchBar setDelegate:self];
        [_searchBar setKeyboardType:UIKeyboardTypeDefault];
        [_searchBar setTranslucent:YES];//设置是否透明
        [_searchBar setSearchBarStyle:UISearchBarStyleProminent];
        [_searchBar setShowsCancelButton:NO];
        _searchBar.tintColor = [UIColor colorWithHex:0x575857];
        UITextField *txfSearchField = [_searchBar valueForKey:@"_searchField"];
        if (txfSearchField) {
            UIImageView *searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
            searchImageView.image = [UIImage imageNamed:@"icon_search"];
            txfSearchField.backgroundColor=[UIColor colorWithHex:0xeaeaea];
            searchImageView.contentMode = UIViewContentModeCenter;
            txfSearchField.leftView = searchImageView;
            txfSearchField.leftViewMode = UITextFieldViewModeAlways;
            }
        }
        [self addSubview:_searchBar];
      [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@7);
        make.left.equalTo(@2);
        make.height.equalTo(@30);
        make.right.equalTo(@-2);
     }];
    return _searchBar;
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;       //显示“取消”按钮
    for(id cc in [searchBar subviews])
    {
        for (UIView *view in [cc subviews]) {
            if ([NSStringFromClass(view.class)isEqualToString:@"UINavigationButton"])
            {
                UIButton *btn = (UIButton *)view;
                [btn setTitle:@"取消" forState:UIControlStateNormal];
            }
        }
    }
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = NO;
    searchBar.text = nil;
    [searchBar resignFirstResponder];
    NSLog(@"取消");
    if (self.cancelblock) {
        self.cancelblock();
    }
    
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length) {
        if (self.searchblock) {
            self.searchblock(searchText);
        }
    }
}

@end
