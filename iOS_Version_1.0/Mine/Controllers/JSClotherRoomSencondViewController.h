//
//  JSClotherRoomSencondViewController.h
//  iOS_Version_1.0
//
//  Created by liping on 2017/7/1.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
@protocol TestJSExport <JSExport>
JSExportAs
(calculateForJS  /** handleFactorialCalculateWithNumber 作为js方法的别名 */,
 - (void)handleFactorialCalculateWithNumber:(NSNumber *)number
 );
- (void)pushtextroom:(NSString *)view;



@end

@interface JSClotherRoomSencondViewController : UIViewController<UIWebViewDelegate,TestJSExport>

@property (strong, nonatomic) JSContext *context;


@end
