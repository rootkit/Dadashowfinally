
//
//  Util.m
//  iOS_Version_1.0
//
//  Created by 李萍 on 2017/4/18.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "Util.h"
#import "NewContactCell.h"
#import "GTMBase64.h"

@implementation Util

+ (NSString *)sha1:(NSString *)input
{
//    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding];
//    
//    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
//    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
//    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
//    
//    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
//        [output appendFormat:@"%02x", digest[i]];
//    }
//    return output;
    
    return @"sha1";
}

#pragma mark - 渐变色（横向）
+ (CAGradientLayer *)layerForCycleScrollViewTitle:(UIView *)bottomView withLeftColor:(UIColor *)leftColor rightColor:(UIColor *)rightColor
{
    CAGradientLayer *layer = [CAGradientLayer new];
    layer.colors = @[
                     (__bridge id)leftColor.CGColor,
                     (__bridge id)rightColor.CGColor,
                     ];
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 0);
    layer.frame = bottomView.bounds;
    
    return layer;
}

#pragma makr - 检测是否为手机号
+ (BOOL)validateMobile:(NSString *)mobileNum
{
    NSString *regex = @"^1[3|5|7|8][0-9]\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if(![pred evaluateWithObject:mobileNum])
    {
        return NO;
    }
    
    else
    {
        return YES;
    }
}

#pragma mark - 字符串处理 文字大小不同
+ (NSMutableAttributedString *)changeStringType:(NSString *)typeString
                                      withPrice:(NSString *)priceStr
                                   withTypeFont:(UIFont *)typeFont
                                  withPriceFont:(UIFont *)priceFont
                                     withReturn:(BOOL)isEnter
{
    NSString *centerString = isEnter ? @"\n" : @"";
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@", typeString, centerString, priceStr]];
    
    [attrString addAttribute:NSFontAttributeName value:typeFont range:NSMakeRange(0, typeString.length)];
    [attrString addAttribute:NSFontAttributeName value:priceFont range:NSMakeRange((isEnter ? (typeString.length+1) : (typeString.length)), priceStr.length)];
    
    return attrString;
}

#pragma mark - 字符串处理 文字前后颜色不同
+ (NSMutableAttributedString *)changeAttributedStrWithfrontStr:(NSString *)frontStr
                                                 withBehindStr:(NSString *)behindStr
                                                withFrontColor:(UIColor *)frontColor
                                               withBehindColor:(UIColor *)behindColor
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@", frontStr, behindStr]];
    
    [attrString addAttribute:NSForegroundColorAttributeName value:frontColor range:NSMakeRange(0, frontStr.length)];
    [attrString addAttribute:NSForegroundColorAttributeName value:behindColor range:NSMakeRange(frontStr.length, behindStr.length)];
    
    return attrString;
}

#pragma mark - pinyin

+ (NSString *)pinyin:(NSString *)str
{
    if (str == nil || str.length == 0) { return @""; }
    
    NSMutableString *result = [NSMutableString stringWithString:str];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)result,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)result,NULL, kCFStringTransformStripDiacritics,NO);
    
    return [result uppercaseString];
}

- (void)stringSort:(NSArray *)array
{
    UILocalizedIndexedCollation * indexCollation = [UILocalizedIndexedCollation currentCollation];
    
    NSMutableArray *attentionTitles = indexCollation.sectionTitles.mutableCopy;
    NSMutableArray *attentions = @[].mutableCopy;
    [indexCollation.sectionTitles enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        [attentions addObject:@[].mutableCopy];
        
    }];
    [array enumerateObjectsUsingBlock:^(NSString *object, NSUInteger idx, BOOL *stop) {
        NSString *pinyin = [Util pinyin:object];
        NSArray *pinyinArray = [pinyin componentsSeparatedByString:@" "]; //取首字母
        NSMutableString *pinyinStr = @"".mutableCopy;
        for (NSString *obj in pinyinArray) {
            [pinyinStr appendString:[obj substringToIndex:1]];
        }
        NSInteger section = [indexCollation sectionForObject:[pinyin stringByReplacingOccurrencesOfString:@" " withString:@""]
                                     collationStringSelector:@selector(uppercaseString)];
        NSMutableArray *sectionArray = [attentions objectAtIndex:section];
        [sectionArray addObject:object];
    }];
    
    for (NSInteger i = 0; i < [attentions count]; i++) {
        if ([attentions[i] count] == 0) {
            [attentions removeObjectAtIndex:i];
            [attentionTitles removeObjectAtIndex:i];
            i--;
        }
    }
    
}


/* 数组进行排序区标题（按字母A~Z） */
+ (NSMutableArray *)indexTitleWithArray:(NSArray *)array
{
    UILocalizedIndexedCollation * indexCollation = [UILocalizedIndexedCollation currentCollation];
    
    NSMutableArray *attentionTitles = indexCollation.sectionTitles.mutableCopy;
    NSMutableArray *attentions = @[].mutableCopy;
    [indexCollation.sectionTitles enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        [attentions addObject:@[].mutableCopy];
        
    }];
    [array enumerateObjectsUsingBlock:^(NSString *object, NSUInteger idx, BOOL *stop) {
        NSString *pinyin = [self pinyin:object];
        NSArray *pinyinArray = [pinyin componentsSeparatedByString:@" "]; //取首字母
        NSMutableString *pinyinStr = @"".mutableCopy;
        for (NSString *obj in pinyinArray) {
            [pinyinStr appendString:[obj substringToIndex:1]];
        }
        NSInteger section = [indexCollation sectionForObject:[pinyin stringByReplacingOccurrencesOfString:@" " withString:@""]
                                     collationStringSelector:@selector(uppercaseString)];
        NSMutableArray *sectionArray = [attentions objectAtIndex:section];
        [sectionArray addObject:object];
    }];
    
    for (NSInteger i = 0; i < [attentions count]; i++) {
        if ([attentions[i] count] == 0) {
            [attentions removeObjectAtIndex:i];
            [attentionTitles removeObjectAtIndex:i];
            i--;
        }
    }
    
    return attentionTitles;
}

/* 数组进行排序数组嵌数组（按字母A~Z分区数组） */
+ (NSMutableArray *)arrayWithArray:(NSArray *)array
{
    UILocalizedIndexedCollation * indexCollation = [UILocalizedIndexedCollation currentCollation];
    
    NSMutableArray *attentionTitles = indexCollation.sectionTitles.mutableCopy;
    NSMutableArray *attentions = @[].mutableCopy;
    [indexCollation.sectionTitles enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        [attentions addObject:@[].mutableCopy];
        
    }];
    [array enumerateObjectsUsingBlock:^(NSString *object, NSUInteger idx, BOOL *stop) {
        NSString *pinyin = [self pinyin:object];
        NSArray *pinyinArray = [pinyin componentsSeparatedByString:@" "]; //取首字母
        NSMutableString *pinyinStr = @"".mutableCopy;
        for (NSString *obj in pinyinArray) {
            [pinyinStr appendString:[obj substringToIndex:1]];
        }
        NSInteger section = [indexCollation sectionForObject:[pinyin stringByReplacingOccurrencesOfString:@" " withString:@""]
                                     collationStringSelector:@selector(uppercaseString)];
        NSMutableArray *sectionArray = [attentions objectAtIndex:section];
        [sectionArray addObject:object];
    }];
    
    for (NSInteger i = 0; i < [attentions count]; i++) {
        if ([attentions[i] count] == 0) {
            [attentions removeObjectAtIndex:i];
            [attentionTitles removeObjectAtIndex:i];
            i--;
        }
    }
    
    return attentions;
}

/* 数组进行排序区标题（按字母A~Z） 联系人列表*/
+ (NSMutableArray *)indexPhoneNumerAndNameWithDic:(NSArray *)array
{
    UILocalizedIndexedCollation * indexCollation = [UILocalizedIndexedCollation currentCollation];
    
    NSMutableArray *attentionTitles = indexCollation.sectionTitles.mutableCopy;
    NSMutableArray *attentions = @[].mutableCopy;
    [indexCollation.sectionTitles enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        [attentions addObject:@[].mutableCopy];
        
    }];
    [array enumerateObjectsUsingBlock:^(ContactModel *object, NSUInteger idx, BOOL *stop) {
        NSString *pinyin = [self pinyin:object.name];
        NSArray *pinyinArray = [pinyin componentsSeparatedByString:@" "]; //取首字母
        NSMutableString *pinyinStr = @"".mutableCopy;
        for (NSString *obj in pinyinArray) {
            [pinyinStr appendString:[obj substringToIndex:1]];
        }
        NSInteger section = [indexCollation sectionForObject:[pinyin stringByReplacingOccurrencesOfString:@" " withString:@""]
                                     collationStringSelector:@selector(uppercaseString)];
        NSMutableArray *sectionArray = [attentions objectAtIndex:section];
        [sectionArray addObject:object];
    }];
    
    for (NSInteger i = 0; i < [attentions count]; i++) {
        if ([attentions[i] count] == 0) {
            [attentions removeObjectAtIndex:i];
            [attentionTitles removeObjectAtIndex:i];
            i--;
        }
    }
    
    return attentionTitles;
}

/* 数组进行排序数组嵌数组（按字母A~Z分区数组） 联系人列表 */
+ (NSMutableArray *)dicPhoneNumerAndNameWithWithArray:(NSArray *)array
{
    UILocalizedIndexedCollation * indexCollation = [UILocalizedIndexedCollation currentCollation];
    
    NSMutableArray *attentionTitles = indexCollation.sectionTitles.mutableCopy;
    NSMutableArray *attentions = @[].mutableCopy;
    [indexCollation.sectionTitles enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        [attentions addObject:@[].mutableCopy];
        
    }];
    [array enumerateObjectsUsingBlock:^(ContactModel *object, NSUInteger idx, BOOL *stop) {
        NSString *pinyin = [self pinyin:object.name];
        NSArray *pinyinArray = [pinyin componentsSeparatedByString:@" "]; //取首字母
        NSMutableString *pinyinStr = @"".mutableCopy;
        for (NSString *obj in pinyinArray) {
            [pinyinStr appendString:[obj substringToIndex:1]];
        }
        NSInteger section = [indexCollation sectionForObject:[pinyin stringByReplacingOccurrencesOfString:@" " withString:@""]
                                     collationStringSelector:@selector(uppercaseString)];
        NSMutableArray *sectionArray = [attentions objectAtIndex:section];
        [sectionArray addObject:object];
    }];
    
    for (NSInteger i = 0; i < [attentions count]; i++) {
        if ([attentions[i] count] == 0) {
            [attentions removeObjectAtIndex:i];
            [attentionTitles removeObjectAtIndex:i];
            i--;
        }
    }
    
    return attentions;
}

#pragma mark - 文字加图片

+ (NSMutableAttributedString *)jointStringWithIcon:(NSString *)string iconName:(NSString *)iconName
{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSTextAttachment* textAttachment = [NSTextAttachment new];
    textAttachment.image = [UIImage imageNamed:iconName];
    [textAttachment adjustY:-1];
    [attributedStr appendAttributedString:[[NSAttributedString alloc] initWithString:@"  "]];
    [attributedStr appendAttributedString:[NSAttributedString attributedStringWithAttachment:textAttachment]];
    
    return attributedStr;
}

#pragma mark - UI处理
+ (MBProgressHUD *)createHUD
{
    UIWindow *window;
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for(UIWindow *eachWindow in windows){
        if ([eachWindow isKeyWindow]) {
            window = eachWindow;
        }
    }
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:window];
    HUD.detailsLabelFont = [UIFont boldSystemFontOfSize:16];
    [window addSubview:HUD];
    [HUD show:YES];
    HUD.removeFromSuperViewOnHide = YES;
    
    return HUD;
}

//数据json组装，先BASE64Encoder，然后倒序，再URLEncoder
+ (NSString *)jsonBase64AndUrlEncoder:(NSString *)string
{
//    NSData *originData = [dic dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64EncoderStr = [Util encodeBase64String:string];
    NSString *reverStr = [Util reversalStringForencodeBase64:base64EncoderStr];
    NSString *encoderStr = [Util encodeToPercentEscapeString:reverStr];
    
    return encoderStr;
}

//数据解码
+ (NSString *)jsonDecodeBase64AndUrlEncoder:(NSString *)decodeStr
{
    NSString *decoderStr = [Util decodeFromPercentEscapeString:decodeStr];
    NSString *reverStr = [Util reversalStringForencodeBase64:decoderStr];
    NSString *base64DecoderStr = [Util decodeBase64String:reverStr];
    
    return base64DecoderStr;
}


//编码 BASE64Encoder
+ (NSString *)encodeBase64String:(NSString * )input
{
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return base64String;
}

//解码 BASE64Encoder
+ (NSString*)decodeBase64String:(NSString * )input
{
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 decodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return base64String;
    
}

//倒序
+ (NSString *)reversalStringForencodeBase64:(NSString *)inputStr
{
    NSMutableString *newString = [[NSMutableString alloc] initWithCapacity:inputStr.length];
    [inputStr enumerateSubstringsInRange:NSMakeRange(0, inputStr.length)
                                 options:NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences
                              usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
                                  [newString appendString:substring];
    }];
    
    return newString;
}

//编码 URLEncoder
+ (NSString *)encodeToPercentEscapeString:(NSString *)input

{
    
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                                    (CFStringRef)input,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                    kCFStringEncodingUTF8));
    
    return encodedString;
    
}

//解码 URLEncoder
+ (NSString *)decodeFromPercentEscapeString:(NSString *)input

{
    
    //NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,(__bridge CFStringRef)input,CFSTR(""),CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
    
}

//字典转json格式字符串
+ (NSString *)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:nil error:&parseError];//NSJSONWritingPrettyPrinted 去掉换行符
    NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *strUrl = [str stringByReplacingOccurrencesOfString:@"\\" withString:@""];  //去掉\
    
    return strUrl;
}       

//把json字符串转换为Json对象的方法

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if(jsonString == nil) { return nil; }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError*err;
    NSDictionary*dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                      options:NSJSONReadingMutableContainers
                                                         error:&err];
    
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    
    NSMutableDictionary *newdict = [[NSMutableDictionary alloc]  init];
    
    for(NSString *keys in dic)
    {
        if(dic[keys] == [NSNull null])
        {
            [newdict setObject:@" "forKey:keys];
            continue;
        }
        [newdict setObject:[NSString stringWithFormat:@"%@", dic[keys]]forKey:keys];
    }
    return newdict;
    
}

+ (NSArray *)arrayWithJsonString:(NSString *)jsonString
{
    if(jsonString == nil) { return nil; }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData
                                                       options:NSJSONReadingMutableContainers
                                                         error:&err];
    
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    
    NSMutableArray *newArray = [[NSMutableArray alloc]  init];
    
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [newArray addObject:obj];
    }];
    
    return newArray;
    
}

+ (NSArray *)arrayWitharrayDicJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData
                                                     options:NSJSONReadingMutableContainers
                                                       error:&err];
    
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    
    NSMutableArray *newArray = [[NSMutableArray alloc]  init];
    
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [newArray addObject:obj];
    }];
    
    return newArray;
}

/**
 @brief 弹窗
 @param title 弹窗标题
 message 弹窗信息
 */
+ (void) showAlertView: (NSString*) title andMessage: (NSString *) message
{
    dispatch_async(dispatch_get_main_queue() , ^{
        UIAlertView *alert = [[UIAlertView alloc] init];
        alert.title = title;
        alert.message = message;
        [alert addButtonWithTitle:@"确定"];
        [alert show];
        alert = nil;
    });
}


/**
 *  弹窗
 *
 *  @param title    弹窗标题
 *  @param message  弹窗信息
 *  @param delegate 弹窗代理
 */
+ (void) showAlertView: (NSString*) title
            andMessage: (NSString *) message
          withDelegate: (UIViewController<UIAlertViewDelegate> *) delegate
{
    dispatch_async(dispatch_get_main_queue() , ^{
        UIAlertView *alert = [[UIAlertView alloc] init];
        alert.title = title;
        alert.message = message;
        alert.delegate = delegate;
        [alert addButtonWithTitle:@"确定"];
        [alert show];
        alert = nil;
    });
}

@end
