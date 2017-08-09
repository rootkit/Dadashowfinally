//
//  AddNewFriendBox.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/18.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddNewFriendManagerDelegate <NSObject>

- (void)clickByInfo:(NSString *)infoString;

@end

@interface AddNewFriendManager : NSObject

+ (instancetype)popBoxManager;
- (void)showPoxBoxWithNewFriendName:(NSString *)name;
- (void)hiddenPoxBox;

@property (nonatomic, weak) id <AddNewFriendManagerDelegate> delegate;

@end

/*   AddNewFriendBox   */

@protocol AddNewFriendBoxDelegate <NSObject>

- (void)clickByInfo:(NSString *)infoString;

@end

@interface AddNewFriendBox : UIView

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITextField *infoTf;

+ (instancetype)showBoxView;
- (void)showNewFriendName:(NSString *)name;

@property (nonatomic, weak) id <AddNewFriendBoxDelegate> delegate;

@end
