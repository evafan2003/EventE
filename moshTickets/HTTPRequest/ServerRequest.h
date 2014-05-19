//
//  ServerRequest.h
//  modelTest
//
//  Created by mosh on 13-10-22.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"
#import "GTMDefines.h"  

/*
 服务器请求 异步加载
 */
@interface ServerRequest : NSObject

@property (nonatomic, strong) id jsonData;//json数据（已经过json处理）
@property (nonatomic, assign) BOOL  requestSuccess;//请求结果是否成功

/*
 创建一个serverRequest实例
 */
+ (ServerRequest *) serverRequest;


/*
 发送请求
 urlStr 网址
 isAppendHost 是否在网址前加上moshhost
 encrypt 是否加密
 action 完成调用的方法
 object 调用方法的target
 */
-(void)beginRequestWithUrl:(NSString *)urlStr
              isAppendHost:(BOOL)isAppendHost
                 isEncrypt:(BOOL)encrypt
                    action:(SEL)action
                    target:(id)object;

/*
 发送请求
 urlStr 网址
 isAppendHost 是否在网址前加上moshhost
 encrypt 是否加密
 dic  json解析后的数据
 */
-(void)beginRequestWithUrl:(NSString *)urlStr
              isAppendHost:(BOOL)isAppendHost
                 isEncrypt:(BOOL)encrypt
                   success:(void (^)(id jsonData))success
                      fail:(void (^)(void))fail;


-(void)postRequestWithUrl:(NSString *)urlStr
                      dic:(NSDictionary *)dic
             isAppendHost:(BOOL)isAppendHost
                isEncrypt:(BOOL)encrypt
                  success:(void (^)(id jsonData))success
                     fail:(void (^)(void))fail;
@end
