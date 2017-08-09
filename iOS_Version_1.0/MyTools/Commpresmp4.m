//
//  Commpresmp4.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/3.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "Commpresmp4.h"
#define CompressionVideoPaht [NSHomeDirectory() stringByAppendingFormat:@"/Documents/CompressionVideoField"]

@implementation Commpresmp4
+ (void)compressedVideoOtherMethodWithURL:(AVAsset *)avasset compressionType:(NSString *)compressionType compressionResultPath:(CompressionSuccessBlock)resultPathBlock{
    
     NSString *resultPath;
    
    AVAsset *avAsset =avasset;
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    // 所支持的压缩格式中是否有 所选的压缩格式
    if ([compatiblePresets containsObject:compressionType]) {
        
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:compressionType];
        
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复，在测试的时候其实可以判断文件是否存在若存在，则删除，重新生成文件即可
        
        [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
        
        NSFileManager *manager = [NSFileManager defaultManager];
        
        BOOL isExists = [manager fileExistsAtPath:CompressionVideoPaht];
        
        if (!isExists) {
            
            [manager createDirectoryAtPath:CompressionVideoPaht withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        resultPath = [CompressionVideoPaht stringByAppendingPathComponent:[NSString stringWithFormat:@"小视频-%@.mov", [formater stringFromDate:[NSDate date]]]];
        
        NSLog(@"压缩文件路径 resultPath = %@",resultPath);
        
        exportSession.outputURL = [NSURL fileURLWithPath:resultPath];
        
        exportSession.outputFileType = AVFileTypeMPEG4;
        
        exportSession.shouldOptimizeForNetworkUse = YES;
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
         
         {
             if (exportSession.status == AVAssetExportSessionStatusCompleted) {
                 
                 NSData *data = [NSData dataWithContentsOfFile:resultPath];
                 
                 float memorySize = (float)data.length / 1024 / 1024;
                 NSLog(@"视频压缩后大小 %f", memorySize);
                 
                 resultPathBlock (resultPath);
                 
             } else {
                 
                 NSLog(@"压缩失败");
             }
             
         }];
        
    } else {
        //        JFLog(@"不支持 %@ 格式的压缩", compressionType);
    }

}


+ (void)removeCompressedVideoFromDocuments {
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:CompressionVideoPaht]) {
        [[NSFileManager defaultManager] removeItemAtPath:CompressionVideoPaht error:nil];
    }
}

@end
