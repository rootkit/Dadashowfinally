//
//  DaHttpTool.h
//  iOS_Version_1.0
//
//  Created by liping on 2017/4/20.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DaHttpTool : NSObject

/** post请求 */
+ (void)post:(NSString *)url params:(NSMutableDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
/** post请求(Nsdata格式请求体) */
+ (void)postAfhttp:(NSString *)url params:(NSMutableDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

/** get请求 */

+ (void)get:(NSString *)url params:(NSMutableDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;



/** 上传多张图片数组 */
+ (void)postImageArray:(NSArray *)imageArray andUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;



/** 上传小视频 */
//+ (void)postvideo:(NSData *)videodata andUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

+ (void)postvideo:(NSData *)videodata andUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

@end
