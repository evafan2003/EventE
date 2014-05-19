//
//  HTTPClient.m
//  moshTickets
//
//  Created by 魔时网 on 13-11-14.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import "HTTPClient.h"
#import "GlobalConfig.h"


@implementation HTTPClient

+ (HTTPClient *) shareHTTPClient
{
    static HTTPClient *instace;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instace = [[HTTPClient alloc] init];
    });
    return instace;
}

- (id) init
{
    if (self = [super init]) {
        self.member_Page = 1;
        self.member_hasMore = YES;
        self.ticket_Page = 1;
        self.ticket_hasMore = YES;
        self.request = [ServerRequest serverRequest];
    }
    return self;
}

- (void) loginWithUserName:(NSString *)userName
                  password:(NSString *)password
                   success:(void (^)(id jsonData))success
                      fail:(void (^)(void))fail
{
    [_request beginRequestWithUrl:[NSString stringWithFormat:URL_LOGIN,userName,password]
                     isAppendHost:YES
                        isEncrypt:Encrypt
                          success:success
                             fail:fail];
}

- (void) findPasswordWithUsername:(NSString *)username
                         userType:(NSString *)type
                          success:(void(^)(id jsondata))success
                             fail:(void(^)(void))fail
{
    [_request beginRequestWithUrl:[NSString stringWithFormat:URL_GETCHECKNUMBER,username,type]
                     isAppendHost:YES
                        isEncrypt:Encrypt
                          success:success
                             fail:fail];
}

- (void) updatePasswordWithUsername:(NSString *)username
                           userType:(NSString *)type
                           password:(NSString *)password
                          success:(void(^)(id jsondata))success
                             fail:(void(^)(void))fail
{
    [_request beginRequestWithUrl:[NSString stringWithFormat:URL_CHANGEPASSWORD,username,type,password]
                     isAppendHost:YES
                        isEncrypt:Encrypt
                          success:success
                             fail:fail];
}

//- (void) userInfoWithUid:(NSString *)uid
//                 success:(void (^)(UserInfo *info))success
//                    fail:(void (^)(void))fail
//{
//    [_request beginRequestWithUrl:[NSString stringWithFormat:URL_USERINFO,uid]
//                     isAppendHost:YES
//                        isEncrypt:NO
//                          success:^(id json) {
//                              if ([GlobalConfig isKindOfNSDictionaryClassAndCountGreaterThanZero:json]) {
//                                  NSDictionary *dic  = json[JSONKEY];
//                                  if ([GlobalConfig isKindOfNSDictionaryClassAndCountGreaterThanZero:dic]) {
//                                      success([UserInfo userInfo:dic]);
//                                  }
//                                  else {
//                                      fail();
//                                  }
//                              }
//                              else {
//                                  fail();
//                              }
//                              
//                          }
//                             fail:fail];
//}

- (void) userInfoWithUid:(NSString *)uid
                 success:(void (^)(UserInfo *info))success
                    fail:(void (^)(void))fail
{
    [_request beginRequestWithUrl:[NSString stringWithFormat:URL_USERINFO,uid]
                     isAppendHost:YES
                        isEncrypt:Encrypt
                          success:^(id json) {
                              if ([GlobalConfig isKindOfNSDictionaryClassAndCountGreaterThanZero:json]) {
                                 NSDictionary *dic = [CacheHanding parseDetailWithDic:json path:[NSString stringWithFormat:CACHE_USERINFO,uid] key:JSONKEY];
                                  if ([GlobalConfig isKindOfNSDictionaryClassAndCountGreaterThanZero:dic]) {
                                      success([UserInfo userInfo:dic]);
                                  }
                                  else {
                                      NSDictionary *dic = [CacheHanding parseDetailWithDic:nil path:[NSString stringWithFormat:CACHE_USERINFO,uid] key:JSONKEY];
                                          success([UserInfo userInfo:dic]);
                                      
                                  }

                              }
                              else {
                                  NSDictionary *dic = [CacheHanding parseDetailWithDic:nil path:[NSString stringWithFormat:CACHE_USERINFO,uid] key:JSONKEY];
                                  success([UserInfo userInfo:dic]);
                              }
                              
                          }
                             fail:^{
                                 NSDictionary *dic = [CacheHanding parseDetailWithDic:nil path:[NSString stringWithFormat:CACHE_USERINFO,uid] key:JSONKEY];
                                 success([UserInfo userInfo:dic]);
                             }];
}


- (void) activityListWithPage:(int)page
                      success:(void (^)(NSMutableArray *array))success
{
    NSString *uid = [GlobalConfig convertToString:[[NSUserDefaults standardUserDefaults] objectForKey:USER_USERID]];
    
    [_request beginRequestWithUrl:[NSString stringWithFormat:URL_ACTIVITYLIST,uid,page]
                     isAppendHost:YES
                        isEncrypt:Encrypt
                          success:^(id json) {
                              //转换成activityModel存入数组
                              success([self converToActivity:json page:page]);
    
    } fail:^{
        success([self converToActivity:nil page:page]);
    }];
}

//转换成activityModel存入数组
- (NSMutableArray *) converToActivity:(NSDictionary *)dic page:(int)page
{
    NSMutableArray *dataArray = [NSMutableArray array];
    NSString *uid = [GlobalConfig convertToString:[[NSUserDefaults standardUserDefaults] objectForKey:USER_USERID]];
    NSArray *jsonArray = [CacheHanding parseListWithDic:dic path:[NSString stringWithFormat:CACHE_ACTIVYTYLIST,page,uid] key:JSONKEY];
    if (jsonArray) {
        for (NSDictionary *dic in jsonArray) {
            Activity *act = [Activity activity:dic];
            //赋值
            [dataArray addObject:act];
        }
    }
    else {
        [GlobalConfig showAlertViewWithMessage:ERROR_LOADINGFAIL superView:nil];
    }
    return dataArray;
}

/*
 活动统计结果
 */
- (void) statisticalResultWithEid:(NSString *)eid
                          success:(void (^)(ActivityStatistical *sta))success
{
    [_request beginRequestWithUrl:[NSString stringWithFormat:URL_STATISTICALRESULT,eid,[[NSUserDefaults standardUserDefaults] objectForKey:USER_USERID]]
                     isAppendHost:YES
                        isEncrypt:Encrypt
                          success:^(id json){
                                success ([self converToActivityStatistical:json eid:eid]);
    }
                             fail:^{
                                 success ([self converToActivityStatistical:nil eid:eid]);
    }];
}


//转换成activityStaModel
- (ActivityStatistical *) converToActivityStatistical:(id)json eid:(NSString *)eid
{
    NSDictionary *dic = [CacheHanding parseDetailWithDic:json path:[NSString stringWithFormat:CACHE_STATISTICAL,eid] key:JSONKEY];
    ActivityStatistical *sta = nil;
    if (dic) {
        sta = [ActivityStatistical activityStatistical:dic];
    }
    else {
        [GlobalConfig showAlertViewWithMessage:ERROR_LOADINGFAIL superView:nil];
    }
    return sta;
}

//添加收藏
- (void) addCollectWithEventID:(NSString *)eid
{
//    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@""];
    [_request beginRequestWithUrl:@"" isAppendHost:YES isEncrypt:NO success:^(id jsonData) {
        [GlobalConfig showAlertViewWithMessage:COLLECT_ADDSUCCESS superView:nil];
    } fail:^{
        [GlobalConfig showAlertViewWithMessage:COLLECT_ADDFAILED superView:nil];
    }];
}

//移除收藏
- (void) removeCollectWithEventID:(NSString *)eid
{
//    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@""];
    [_request beginRequestWithUrl:@"" isAppendHost:YES isEncrypt:NO success:^(id jsonData) {
        [GlobalConfig showAlertViewWithMessage:COLLECT_DELSUCCESS superView:nil];
    } fail:^{
        [GlobalConfig showAlertViewWithMessage:COLLECT_DELFAILED superView:nil];
    }];
}

////下载票数据
//- (void) getAllTicketWitheid:(NSString *)eid
//                     success:(void (^)(NSMutableArray *tickets))success
//                        fail:(void(^)(void))fail
//{
//    NSString *dateKey = [NSString stringWithFormat:@"ListDate%@",eid];
//
//    NSDate *date = [[NSUserDefaults standardUserDefaults] objectForKey:dateKey];
//    
//    [_request beginRequestWithUrl:[NSString stringWithFormat:GET_ALL_LIST,eid,[GlobalConfig getObjectWithKey:USER_USERID],(int)([date timeIntervalSince1970] - 300)]
//                     isAppendHost:YES
//                        isEncrypt:Encrypt
//                          success:^(id jsonData){
//                              
//        //下载成功组装数据
//        if ([GlobalConfig isKindOfNSDictionaryClassAndCountGreaterThanZero:jsonData]) {
//            NSString *eid = jsonData[@"eid"];
//            NSArray *array = jsonData[@"list"];
//            if ([eid isKindOfClass:NSStringClass] && [array isKindOfClass:NSArrayClass]) {
//                NSMutableArray *ticketsArray = [NSMutableArray array];
//                for (NSDictionary *dic in array) {
//                    Ticket *ticket = [Ticket ticket:dic eid:eid];
//                    [ticketsArray addObject:ticket];
//                }
//                success(ticketsArray);
//                
//                //记住时间
//                [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:dateKey];
//                [[NSUserDefaults standardUserDefaults] synchronize];
//            }
//            else {
//                fail();
//            }
//        } else {
//            fail();
//        }
//        
//    } fail:^{
//        fail();
//    }];
//}
//

////验票
//- (void) checkTicketWithtid:(NSString *)tid eid:(NSString *)eid password:(NSString *)password
//                    success:(void (^)(Ticket *ticket))success
//{
//    NSLog(@"-=-=-%@",[NSString stringWithFormat:VALIDATE,tid,password,eid,[GlobalConfig getObjectWithKey:USER_USERID]]);
//    [_request beginRequestWithUrl:[NSString stringWithFormat:VALIDATE,tid,password,eid,[GlobalConfig getObjectWithKey:USER_USERID]] isAppendHost:YES isEncrypt:NO success:^(id jsonData){
//        //返回一个萌爆表的Ticket类型的model
//        if ([GlobalConfig isKindOfNSDictionaryClassAndCountGreaterThanZero:jsonData]) {
//            
//            success([Ticket ticket:jsonData]);
//        }
//        
//    } fail:^{
//        [GlobalConfig showAlertViewWithMessage:VALIDATE_DELFAILED superView:nil];
//    }];
//}


//上传本地验票结果
- (void) uploadTicketWitheid:(NSString *)eid
                         dic:(NSDictionary *)dic
                      sucess:(void (^)(NSString *str))sucess
{
    [_request postRequestWithUrl:[NSString stringWithFormat:UPLOAD,eid,[GlobalConfig getObjectWithKey:USER_USERID]]
                             dic:dic
                    isAppendHost:YES
                       isEncrypt:Encrypt
                         success:^(NSString *str){
                           sucess(str);
    } fail:^{
        [GlobalConfig showAlertViewWithMessage:UPLOAD_DELFAILED superView:nil];
    }];

}

//上传本地验票结果
- (void) uploadTicketWitheid:(NSString *)eid
                         dic:(NSDictionary *)dic
                      sucess:(void (^)(NSString *str))sucess
                        fail:(void(^)(void))fail
{
    [_request postRequestWithUrl:[NSString stringWithFormat:UPLOAD,eid,[GlobalConfig getObjectWithKey:USER_USERID]]
                             dic:dic
                    isAppendHost:YES
                       isEncrypt:Encrypt
                         success:^(NSString *str){
                           sucess(str);
                       } fail:^{
                           fail();
                       }];
    
}

//得到最后一次加载时间
- (NSNumber *) getLastDownloadDateWithKey:(NSString *)key
{
    NSNumber *date = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (![date isKindOfClass:[NSNumber class]]) {
        date = @0;
    }
    return date;
}

//保存最后一次加载时间
- (void) saveLastDownloadDate:(NSNumber *)time key:(NSString *)key
{
    //记住时间
    if ([time isKindOfClass:[NSNumber class]]) {
        [[NSUserDefaults standardUserDefaults] setObject:time forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}





@end
