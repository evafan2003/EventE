//
//  ServerRequest.m
//  modelTest
//
//  Created by mosh on 13-10-22.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import "ServerRequest.h"
#import "GlobalConfig.h"
//#import "AFURLRequestSerialization.h"

@implementation ServerRequest

/*
 单例 暂不使用
 */
//+ (ServerRequest *) shareServerRequest
//{
//    static ServerRequest *_instance = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _instance = [[ServerRequest alloc] init];
//    });
//    
//    return _instance;
//}


+ (ServerRequest *) serverRequest
{
    return [[ServerRequest alloc] init];
}

//发送请求
/*
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
                    target:(id)object{
    
    //初始化
    self.jsonData = nil;
    self.requestSuccess = NO;
    
    //中文转码
    NSString *requestUrl = [GlobalConfig convertToString:urlStr];
    
    //加上权限认证
    requestUrl = [self appendingUsernameAndPassword:requestUrl];
    requestUrl = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //加密
    if (encrypt) {
        requestUrl = [self urlEncrypt:requestUrl];
//        requestUrl = [self appendingLoginHost:requestUrl];
    }
    
    //加服务器
    if (isAppendHost) {
      requestUrl =  [self appendingMoshHost:requestUrl];
    }
    
    
    //加载
    [self serverRequestWithUrl:requestUrl success:^(id jsonData) {
        if ([object respondsToSelector:action]) {
        self.jsonData = jsonData;
        self.requestSuccess = YES;
            SuppressPerformSelectorLeakWarning([object performSelector:action withObject:nil]);
        }
    } fail:^{
        self.requestSuccess = NO;
        self.jsonData = nil;
        if ([object respondsToSelector:action]) {
            SuppressPerformSelectorLeakWarning([object performSelector:action withObject:nil]);
        }
    }];
}

-(void)beginRequestWithUrl:(NSString *)urlStr
              isAppendHost:(BOOL)isAppendHost
                 isEncrypt:(BOOL)encrypt
                   success:(void (^)(id jsonData))success
                    fail:(void (^)(void))fail{
    
    //初始化
    self.jsonData = nil;
    self.requestSuccess = NO;
    
    //中文转码
    NSString *requestUrl = [GlobalConfig convertToString:urlStr];
    
    //加上权限认证
    requestUrl = [self appendingUsernameAndPassword:requestUrl];
    
    requestUrl = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //加密
    if (encrypt) {
        requestUrl = [self urlEncrypt:requestUrl];
//        requestUrl = [self appendingLoginHost:requestUrl];
    }
    
    //加服务器
    if (isAppendHost) {
       requestUrl = [self appendingMoshHost:requestUrl];
    }
    
    
    MOSHLog(@"%@",requestUrl);
    //加载
    [self serverRequestWithUrl:requestUrl success:success fail:fail];
}


//发送
-(void)postRequestWithUrl:(NSString *)urlStr
                      dic:(NSDictionary *)dic
              isAppendHost:(BOOL)isAppendHost
                 isEncrypt:(BOOL)encrypt
                   success:(void (^)(id jsonData))success
                      fail:(void (^)(void))fail{
    
    //初始化
    self.jsonData = nil;
    self.requestSuccess = NO;
    
    //中文转码
    NSString *requestUrl = [GlobalConfig convertToString:urlStr];
    //加上权限认证
    requestUrl = [self appendingUsernameAndPassword:requestUrl];
    
    requestUrl = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //加密
    if (encrypt) {
        requestUrl = [self urlEncrypt:requestUrl];
//        requestUrl = [self appendingLoginHost:requestUrl];
    }
    
    //加服务器
    if (isAppendHost) {
        requestUrl = [self appendingMoshHost:requestUrl];
    }
    
    
    MOSHLog(@"post: %@",requestUrl);
    //加载
    [self serverRequestWithUrl:requestUrl dic:dic success:success fail:fail];
    
}


//afnetworking加载

- (void) serverRequestWithUrl:(NSString *)str
                      success:(void (^)(id jsonData))success
                        fail:(void (^)(void))fail
{
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        //成功
        self.jsonData = JSON;
        self.requestSuccess = YES;
        success(JSON);

    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response,NSError *error, id JSON){
        //失败
        self.requestSuccess = NO;
        self.jsonData = nil;
        fail();
    }];
    [operation start];

}


//通过post方式提交数据
- (void) serverRequestWithUrl:(NSString *)str
                          dic:(NSDictionary *)dic
                      success:(void (^)(id jsonData))success
                         fail:(void (^)(void))fail
{
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];//这里要将url设置为空
    
//    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
//    httpClient.parameterEncoding = AFJSONParameterEncoding;
//    [httpClient setDefaultHeader:@"Accept" value:@"application/json"];
//    httpClient.stringEncoding = NSASCIIStringEncoding;
    
    [httpClient postPath:str parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        self.requestSuccess = YES;
        success(responseStr);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.requestSuccess = NO;
        fail();
    }];
    
//    NSError *error = nil;

//    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/json"]];
//    NSMutableURLRequest* request = [httpClient requestWithMethod:@"PUT" path:str parameters:dic];
//    
////    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
////    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:dic options:0 error:&error]];
////    [request setHTTPMethod:@"PUT"];
//    AFJSONRequestOperation* operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
//        success(response);
//
//    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
//        fail();
//    }];
//    
//    [operation start];

}


- (NSString *) appendingMoshHost:(NSString *)url
{
    return [MOSHHOST stringByAppendingString:url];
}

- (NSString *) appendingLoginHost:(NSString *)url
{
    return [LOGINHOST stringByAppendingString:url];
}
- (NSString *) urlEncrypt:(NSString *)url
{
    NSArray *resArray = [url componentsSeparatedByString:@"?"];
    NSMutableArray *array = [NSMutableArray arrayWithArray:resArray];
    if (array.count == 2) {
        NSString *str = array[1];
        if (str.length > 0) {
            str = [self encryptUseDES:str key:DESKEY];
            [array replaceObjectAtIndex:1 withObject:str];
        }
        NSString *encryStr = [array componentsJoinedByString:@"?key="];
        return encryStr;
    }
    //加密
    return url;
}

//加上账号和密码进行权限认证
- (NSString *) appendingUsernameAndPassword:(NSString *)url
{
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:USER_USERNAME];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:USER_PASSWORD];
    return [url stringByAppendingString:[NSString stringWithFormat:@"&uuname=%@&uupwd=%@&isnew=Y",username,password]];
}


//加密用(DES方式)
- (NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key
{
    NSData *data = [clearText dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    size_t numBytesEncrypted = 0;
     size_t dataOutAvailable = 0; //size_t  是操作符sizeof返回的结果类型
    uint8_t *dataOut = NULL; //可以理解位type/typedef 的缩写
    dataOutAvailable = ([data length] + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    dataOut = malloc( dataOutAvailable * sizeof(uint8_t));
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,//  加密/解密
                                          kCCAlgorithmDES,//  加密根据哪个标准（des，3des，aes。。。。）
                                        kCCOptionECBMode | kCCOptionPKCS7Padding,//  选项分组密码算法(des:对每块分组加一次密  3DES：对每块分组加三个不同的密)
                                          [key UTF8String],//密钥    加密和解密的密钥必须一致
                                          kCCKeySizeDES,//   DES 密钥的大小（kCCKeySizeDES=8）
                                          nil, //  可选的初始矢量
                                          [data bytes],// 数据的存储单元
                                          [data length],// 数据的大小
                                          (void *)dataOut,// 用于返回数据
                                          dataOutAvailable,
                                          &numBytesEncrypted);


    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData *dataTemp = [NSData dataWithBytes:dataOut length:(NSUInteger)numBytesEncrypted];
        plainText = [GTMBase64 stringByEncodingData:dataTemp];

        plainText = [GTMBase64 encodeURL:plainText];
    }else{
        NSLog(@"DES加密失败");
    }
    return [GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:plainText]?plainText:@"";
}




@end
