//
//  DataModel.m
//  modelTest
//
//  Created by mosh on 13-10-29.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import "CacheHanding.h"
#import "GlobalConfig.h"

@implementation CacheHanding


//读缓存
/*
 keyword 存储路径关键字
 */
+ (NSData *) readCache:(NSString *)keyword {
    //从本地读
    return [NSData dataWithContentsOfFile:[CacheHanding filepath:keyword]];
}

//写缓存
/*
 keyword 存储路径关键字
 data 存储内容
 */

+ (void) writeCache:(NSString *)keyword data:(id)data {
    //更新的数据
    if ([data isKindOfClass:[NSData class]]) {
        [data writeToFile:[CacheHanding filepath:keyword] options:NSDataWritingAtomic error:nil];
    }
    else if ([data isKindOfClass:[NSDictionary class]] || [data isKindOfClass:[NSArray class]]) {
//        NSDictionary *dic = data;
        [data writeToFile:[CacheHanding filepath:keyword] atomically:YES];
    }
//    if([data writeToFile:[DataHanding filepath:keyword] atomically:NO encoding:NSUTF8StringEncoding error:nil]){
//        MOSHLog(@"%@写成功了",path);
//    }else{
//        MOSHLog(@"%@写失败了",path);
//    }
}


/*
 keyword 存储路径关键字
 */
//存储路径
+ (NSString *) filepath:(NSString *)keyword {
    //从本地读
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dataPath = [paths objectAtIndex:0];
    return [dataPath stringByAppendingPathComponent:keyword];
}



//===================================================================================================================
//MOSHAPP通用解析方法
//=========================================================================================================
/*
 *  通用列表解析
 *  返回NSArray
 *
 */
//key:关键字 path:缓存地址 解析json数据并进行处理
+ (NSArray *) parseListWithData:(NSData *)data path:(NSString *)path key:(NSString *)key
{
    //json解析
   NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    if ([GlobalConfig isKindOfNSDictionaryClassAndCountGreaterThanZero:jsonDic]) {
        NSArray *responseArray = [jsonDic objectForKey:key];
        if ([GlobalConfig isKindOfNSArrayClassAndCountGreaterThanZero:responseArray]) {
            //有数据 存缓存 返回array
            [CacheHanding writeCache:path data:data];
            return responseArray;
        }
    }
    //无数据 读取缓存 重新解析
    data = [CacheHanding readCache:path];
    [GlobalConfig showAlertViewWithMessage:ERROR_READCACHE superView:nil];
    jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    if ([GlobalConfig isKindOfNSDictionaryClassAndCountGreaterThanZero:jsonDic]) {
        NSArray *responseArray = [jsonDic objectForKey:key];
        if ([GlobalConfig isKindOfNSArrayClassAndCountGreaterThanZero:responseArray]) {
            //缓存有数据 返回array
            return responseArray;
        }
    }
    
    //失败
    return nil;
}

/*
 *  通用详情解析
 *  返回NSDictionary
 *
 */

//key:关键字 path:缓存地址   解析json数据并进行处理
+ (NSDictionary *) parseDetailWithData:(NSData *)data path:(NSString *)path key:(NSString *)key
{
    //json解析
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    if ([GlobalConfig isKindOfNSDictionaryClassAndCountGreaterThanZero:jsonDic]) {
         NSDictionary *responseDic = [jsonDic objectForKey:key];
        if ([GlobalConfig isKindOfNSDictionaryClassAndCountGreaterThanZero:responseDic]) {
            //有数据 存缓存 返回array
            [CacheHanding writeCache:path data:data];
            return responseDic;
        }
    }
    //无数据 读取缓存 重新解析
    data = [CacheHanding readCache:path];
    [GlobalConfig showAlertViewWithMessage:ERROR_READCACHE superView:nil];
    jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    if ([GlobalConfig isKindOfNSDictionaryClassAndCountGreaterThanZero:jsonDic]) {
         NSDictionary *responseDic = [jsonDic objectForKey:key];
        if ([GlobalConfig isKindOfNSDictionaryClassAndCountGreaterThanZero:responseDic]) {
            //缓存有数据 返回array
            return responseDic;
        }
    }
    
    //失败
    return nil;
}

//key:关键字 path:缓存地址
+ (NSArray *) parseListWithDic:(NSDictionary *)jsonDic path:(NSString *)path key:(NSString *)key
{
    //json解析
    if ([GlobalConfig isKindOfNSDictionaryClassAndCountGreaterThanZero:jsonDic]) {
        NSArray *responseArray = [jsonDic objectForKey:key];
        if ([GlobalConfig isKindOfNSArrayClassAndCountGreaterThanZero:responseArray]) {
            //有数据 存缓存 返回array
            [CacheHanding writeCache:path data:jsonDic];
            return responseArray;
        }
    }
    //无数据 读取缓存 重新解析
    NSDictionary *cacheDic = [NSDictionary dictionaryWithContentsOfFile:[CacheHanding filepath:path]];
    [GlobalConfig showAlertViewWithMessage:ERROR_READCACHE superView:nil];
    if ([GlobalConfig isKindOfNSDictionaryClassAndCountGreaterThanZero:cacheDic]) {
        NSArray *responseArray = [cacheDic objectForKey:key];
        if ([GlobalConfig isKindOfNSArrayClassAndCountGreaterThanZero:responseArray]) {
            //缓存有数据 返回array
            return responseArray;
        }
    }
    
    //失败
    return nil;
}

/*
 *  通用详情解析
 *  返回NSDictionary
 *
 */

//key:关键字 path:缓存地址
+ (NSDictionary *) parseDetailWithDic:(NSDictionary *)jsonDic path:(NSString *)path key:(NSString *)key
{
    if ([GlobalConfig isKindOfNSDictionaryClassAndCountGreaterThanZero:jsonDic]) {
        NSDictionary *responseDic = [jsonDic objectForKey:key];
        if ([GlobalConfig isKindOfNSDictionaryClassAndCountGreaterThanZero:responseDic]) {
            //有数据 存缓存 返回array
            [CacheHanding writeCache:path data:jsonDic];
            return responseDic;
        }
    }
    //无数据 读取缓存 重新解析
    NSDictionary *cacheDic = [NSDictionary dictionaryWithContentsOfFile:[CacheHanding filepath:path]];
    [GlobalConfig showAlertViewWithMessage:ERROR_READCACHE superView:nil];
    if ([GlobalConfig isKindOfNSDictionaryClassAndCountGreaterThanZero:cacheDic]) {
        NSDictionary *responseDic = [cacheDic objectForKey:key];
        if ([GlobalConfig isKindOfNSDictionaryClassAndCountGreaterThanZero:responseDic]) {
            //缓存有数据 返回array
            return responseDic;
        }
    }
    
    //失败
    return nil;
}


@end
