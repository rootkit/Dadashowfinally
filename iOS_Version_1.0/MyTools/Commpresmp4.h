//
//  Commpresmp4.h
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/3.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface Commpresmp4 : NSObject
typedef void (^CompressionSuccessBlock)(NSString *resultPath);

+ (void)compressedVideoOtherMethodWithURL:(AVAsset *)avasset compressionType:(NSString *)compressionType compressionResultPath:(CompressionSuccessBlock)resultPathBlock;

//清除沙盒里面的视频文件
+ (void)removeCompressedVideoFromDocuments;
@end
