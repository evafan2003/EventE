//
//  DataModel.h
//  modelTest
//
//  Created by mosh on 13-10-29.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerRequest.h"

/*
 文件缓存处理
 */
@interface CacheHanding : NSObject

/*
 json解析、缓存并返回key对应的内容
 data 需要json处理的数据
 key  字典中对应的关键字 如{“res”:[]，“feedback”:“0”}中res
 path 缓存地址
 
 *****如果返回值为nil代表处理失败并且没有缓存
 */
+  (NSArray *) parseListWithData:(NSData *)data path:(NSString *)path key:(NSString *)key;

+ (NSDictionary *) parseDetailWithData:(NSData *)data path:(NSString *)path key:(NSString *)key;


/*
 缓存处理并返回key对应的内容
 jsonDic 经json处理后的字典
 key  字典中对应的关键字 如{“res”:[]，“feedback”:“0”}中res
 path 缓存地址
 
 *****如果返回值为nil代表处理失败并且没有缓存
 */
+ (NSArray *) parseListWithDic:(NSDictionary *)jsonDic path:(NSString *)path key:(NSString *)key;

+ (NSDictionary *) parseDetailWithDic:(NSDictionary *)jsonDic path:(NSString *)path key:(NSString *)key;

@end
