//
//  HTTPClient+Members.m
//  moshTickets
//
//  Created by 魔时网 on 14-3-26.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "HTTPClient+Members.h"
#import "GlobalConfig.h"
#import "MoshTicketDatabase.h"

static NSInteger  requestNumber = 500;//分页请求中每页返回数量
static NSString *memberDownloadDate = @"MemberDate";

@implementation HTTPClient (Members)

/*
 全部购票者信息
 */

- (void) memberInfoWithEid:(NSString *)eid
              ticketTypeID:(NSString *)tid
{
    NSString *uid = [GlobalConfig convertToString:[[NSUserDefaults standardUserDefaults] objectForKey:USER_USERID]];
    
    //如果换了活动，则将page设为1
    if (![eid isEqual:self.member_eid]) {
        self.member_Page = 1;
    }
    self.member_eid = eid;
    self.member_tid = tid;
    MOSHLog(@"page:%d",self.member_Page);
    
    NSString *dateKey = [NSString stringWithFormat:@"%@%@",memberDownloadDate,self.member_eid];

    NSString *url = [NSString stringWithFormat:URL_MEMBERINFO,uid,eid,tid,self.member_Page,[[self getLastDownloadDateWithKey:dateKey] integerValue]];
    
    [self.request beginRequestWithUrl:url
                     isAppendHost:YES
                        isEncrypt:Encrypt
                          success:^(id json){
                              [self memberInfoDownloadSuccess:json];
                          }
                                 fail:^{
                                     //push消息
                                     [self postFailNoti];
                                     
                                 }];
    
}

- (void) memberInfoDownloadSuccess:(id)json
{
    if ([GlobalConfig isKindOfNSDictionaryClassAndCountGreaterThanZero:json]) {
        
        NSNumber *pageCount = [GlobalConfig convertToNumber:json[@"curpagecount"]];//每一页返回的购买者数量，不足requestNumber则认为没有更多
        //是否还有下一个
        self.member_hasMore = ([pageCount integerValue] >= requestNumber) ? YES : NO;
        
//        NSNumber *allCount = [GlobalConfig convertToNumber:json[@"ticketcount"]];//总数
        
        //插入数据库
        [self insertMemberToDatabase:json];
        
        if (self.member_hasMore) {//有更多

//            CGFloat allPage = (CGFloat)([allCount integerValue]/requestNumber);
//             CGFloat progress = self.member_Page/allPage;
            //push消息 加载进度增加
            [[NSNotificationCenter defaultCenter] postNotificationName:Notification_MemberSuccess object:[NSNumber numberWithFloat:0.0]];
            
            self.member_Page ++;
            [self memberInfoWithEid:self.member_eid ticketTypeID:self.member_tid];
            
        }
        else {
            //push消息 加载完成
            [self postSuccessNoti];
            //记住时间
            if (self.member_Page == 1) {
                NSString *dateKey = [NSString stringWithFormat:@"%@%@",memberDownloadDate,self.member_eid];
                [self saveLastDownloadDate:json[@"time"] key:dateKey];
            }
        }
    }
    else {
        [self postFailNoti];
    }
    
}

//插入数据库
- (void) insertMemberToDatabase:(NSDictionary *)json
{
    NSMutableArray *memberArray = [NSMutableArray array];
    NSArray *array  = [GlobalConfig convertToArray:json[JSONKEY]];
    for (NSDictionary *dic in array) {
        MemberInfo *info = [MemberInfo memberInfo:dic];
        [memberArray addObject:info];
    }
    
    [[MoshTicketDatabase sharedInstance] insertMembers:memberArray];
}


- (void) postSuccessNoti
{
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_MemberSuccess object:[NSNumber numberWithFloat:1.0f]];
    [self resetInfo];
    
}

- (void) postFailNoti
{
     [[NSNotificationCenter defaultCenter] postNotificationName:Notification_MemberFail object:nil];
    [self resetInfo];
}

//把参数设成初始状态
- (void) resetInfo
{
    self.member_Page = 1;
    self.member_hasMore = YES;
}
/*
 单个购票者信息
 */

- (void) singleMemberInfoWithEid:(NSString *)eid
                             tid:(NSString *)tid
                            uuid:(NSString *)uuid
                         isentry:(NSString *)isentry
                         success:(void (^)(MemberInfo *info))success
                            fail:(void (^)(void))fail
{
    NSString *uid = [GlobalConfig convertToString:[[NSUserDefaults standardUserDefaults] objectForKey:USER_USERID]];
    NSString *url = [NSString stringWithFormat:URL_SINGLEMEMBERINFO,tid,eid,uuid,isentry,uid];
    
    [self.request beginRequestWithUrl:url
                     isAppendHost:YES
                        isEncrypt:Encrypt
                          success:^(id json){
                              if ([GlobalConfig isKindOfNSDictionaryClassAndCountGreaterThanZero:json]) {
                                  NSDictionary *dic  = [GlobalConfig convertToDictionary:json[JSONKEY]];
                                  MemberInfo *info = [MemberInfo memberInfo:dic];
                                  success(info);
                              }
                              else {
                                  fail();
                              }
                              
                          }
                             fail:fail];
    
}


@end
