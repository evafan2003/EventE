//
//  HTTPClient.h
//  moshTickets
//
//  Created by 魔时网 on 13-11-14.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerRequest.h"   
#import "CacheHanding.h"
#import "UIImageView+AFNetworking.h"

#import "Activity.h"
#import "ActivityStatistical.h"
#import "Ticket.h"
#import "UserInfo.h"
#import "MemberInfo.h"  

@interface HTTPClient : NSObject

@property (nonatomic, strong) ServerRequest *request;

//member使用
@property (nonatomic, assign) NSUInteger member_Page;
@property (nonatomic, assign) BOOL  member_hasMore;
@property (nonatomic, strong) NSString *member_eid;
@property (nonatomic, strong) NSString *member_tid;

//tickets使用
@property (nonatomic, assign) NSUInteger ticket_Page;
@property (nonatomic, assign) BOOL  ticket_hasMore;
@property (nonatomic, strong)  Activity *act;


/*
 单例
 */
+ (HTTPClient *) shareHTTPClient;

/*
 登录
 name 用化名
 password 密码
 */
- (void) loginWithUserName:(NSString *)userName
                  password:(NSString *)password
                   success:(void (^)(id jsonData))success
                      fail:(void (^)(void))fail;
/*
 找回密码之获取验证码
 */
- (void) findPasswordWithUsername:(NSString *)username
                         userType:(NSString *)type
                          success:(void(^)(id jsondata))success
                             fail:(void(^)(void))fail;
/*
 找回密码之修改密码
 */
- (void) updatePasswordWithUsername:(NSString *)username
                           userType:(NSString *)type
                           password:(NSString *)password
                            success:(void(^)(id jsondata))success
                               fail:(void(^)(void))fail;


/*
 账户概览
 */
- (void) userInfoWithUid:(NSString *)uid
                 success:(void (^)(UserInfo *info))success
                    fail:(void (^)(void))fail;
/*
 活动列表
 page 加载的页数
 */
- (void) activityListWithPage:(int)page
                      success:(void (^)(NSMutableArray *array))success;
/*
 统计结果
 */
- (void) statisticalResultWithEid:(NSString *)eid
                          success:(void (^)(ActivityStatistical *sta))success;

/*
 添加/移除收藏
 */
- (void) addCollectWithEventID:(NSString *)eid;

- (void) removeCollectWithEventID:(NSString *)eid;



/*
 下载票数据 (还没想好存数据库在哪一步搞，姑且先返回之)
 */
//- (void) getAllTicketWitheid:(NSString *)eid
//                     success:(void (^)(NSMutableArray *tickets))success
//                        fail:(void(^)(void))fail;
///*
// 联机验票
// */
//- (void) checkTicketWithtid:(NSString *)tid eid:(NSString *)eid password:(NSString *)password
//                    success:(void (^)(Ticket *ticket))success;

/*
 上传本地验票结果
 */
- (void) uploadTicketWitheid:(NSString *)eid
                         dic:(NSDictionary *)dic
                      sucess:(void (^)(NSString *str))sucess;

- (void) uploadTicketWitheid:(NSString *)eid
                         dic:(NSDictionary *)dic
                      sucess:(void (^)(NSString *str))sucess
                        fail:(void(^)(void))fail;


//得到最后一次加载时间
- (NSNumber *) getLastDownloadDateWithKey:(NSString *)key;

//保存最后一次加载时间
- (void) saveLastDownloadDate:(NSNumber *)time key:(NSString *)key;

@end