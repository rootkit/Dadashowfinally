//
//  UIColorHF.h
//  iOS_Version_1.0
//
//  Created by 李萍 on 2017/4/15.
//  Copyright © 2017年 李萍. All rights reserved.
//

#ifndef UIColorHF_h
#define UIColorHF_h
#import "UIColor+CustomColor.h"

#define TabbarNormalColor           [UIColor colorWithHex:0XBBBABB]
#define TabbarPressedColor          [UIColor colorWithHex:0X660328]
#define ThemeColor                  [UIColor themeColor]
#define NavigationColor             [UIColor whiteColor]
#define TabbarColor                 [UIColor whiteColor]
#define BackCellColor               [UIColor colorWithHex:0XEEEEEE]//(238,238,238)
#define FirstTextColor              [UIColor colorWithHex:0X2E2E2E]//(46,46,46)
#define SecondTextColor             [UIColor colorWithHex:0X5A5A5A]//(90,90,90)
#define VideoUserNameTextColor      [UIColor colorWithHex:0X9D9D9D]//(157,157,157)
#define IconTextColor               [UIColor colorWithHex:0XA8A8A8]//(168,168,168)
#define DefaultImgBgColor           [UIColor colorWithHex:0XF3F8FE]//(243,248,254)
#define InfoTextColor               [UIColor colorWithHex:0x353535]//(53,53,53)

#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define RandomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#endif /* UIColorHF_h */
