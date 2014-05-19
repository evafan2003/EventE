//
//  HTTPClient+TIckets.m
//  moshTickets
//
//  Created by 魔时网 on 14-4-2.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "HTTPClient+TIckets.h"
#import "GlobalConfig.h"
#import "MoshTicketDatabase.h"

@implementation HTTPClient (TIckets)


static NSInteger  requestNumber = 1000;//分页请求中每页返回数量
static NSString *DownloadDate = @"ListDate";

/*
 全部票信息
 */

- (void) ticketsInfoWithActivity:(Activity *)act
                      isall:(BOOL)all
                  backgroud:(BOOL)back
{
    NSString *uid = [GlobalConfig convertToString:[[NSUserDefaults standardUserDefaults] objectForKey:USER_USERID]];
    
    NSString *isall = (all) ? @"y" :@"n";
    
    self.act = act;

    MOSHLog(@"page:%d",self.ticket_Page);
    
    NSString *dateKey = [NSString stringWithFormat:@"%@%@",DownloadDate,self.act.eid];
    
    NSString *url = [NSString stringWithFormat:GET_ALL_LIST,self.act.eid,uid,[[self getLastDownloadDateWithKey:dateKey] integerValue],self.ticket_Page,isall];
    
    [self.request beginRequestWithUrl:url
                         isAppendHost:YES
                            isEncrypt:Encrypt
                              success:^(id json){
                        
                                  [self ticketInfoDownloadSuccess:json isall:all background:back];
                              }
                                 fail:^{
                                     if (!back) {
                                     //push消息
                                         [self postFailNotiWithBackground:back];
                                     }
                                     
                                 }];
    
}

- (void) ticketInfoDownloadSuccess:(id)json isall:(BOOL)isall background:(BOOL)back
{
    if ([GlobalConfig isKindOfNSDictionaryClassAndCountGreaterThanZero:json]) {
        
//        NSNumber *allCount = [GlobalConfig convertToNumber:json[@"t_count"]];//总数
        
        //插入数据库
          NSArray *ticketArray = [self insertToDatabase:json];
        
        //是否还有下一个
        self.ticket_hasMore = (ticketArray.count >= requestNumber) ? YES : NO;
        
        //后台更新时发送票数变更消息
        if (ticketArray.count > 0 && back) {
            [[NSNotificationCenter defaultCenter] postNotificationName:Notification_checkTicket object:nil];
        }
        
        if (self.ticket_hasMore) {//有更多
            
            if (!back) {
//                CGFloat allPage = (CGFloat)([allCount integerValue]/requestNumber);
//                CGFloat progress = self.ticket_Page/allPage;
                //push消息 加载进度增加
                [[NSNotificationCenter defaultCenter] postNotificationName:Notification_TicketSuccess object:[NSNumber numberWithFloat:0.0]];
            }
            self.ticket_Page ++;
            [self ticketsInfoWithActivity:self.act isall:isall backgroud:NO];
            
        }
        else {
            //push消息 加载完成
            [self postSuccessNotiWithBackground:back];
            //记住时间
            if (self.ticket_Page == 1) {
                NSString *dateKey = [NSString stringWithFormat:@"%@%@",DownloadDate,self.act.eid];
                [self saveLastDownloadDate:json[@"time"] key:dateKey];
            }
        }
    }
    else {
        [self postFailNotiWithBackground:back];
    }
    
}


//插入数据库
- (NSArray *) insertToDatabase:(NSDictionary *)json
{
    NSMutableArray *ticketArray = [NSMutableArray array];
    NSArray *array  = [GlobalConfig convertToArray:json[JSONLIST]];
    for (NSDictionary *dic in array) {
        Ticket *info = [Ticket ticket:dic act:self.act];
        [ticketArray addObject:info];
    }
    [[MoshTicketDatabase sharedInstance] insertTickets:ticketArray];
    return ticketArray;
}


- (void) postSuccessNotiWithBackground:(BOOL)back
{
    if (!back) {
        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_TicketSuccess object:[NSNumber numberWithFloat:1.0f]];
        
    }
    [self resetInfo];
    
}

- (void) postFailNotiWithBackground:(BOOL)back
{
    if (!back) {
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_TicketFail object:nil];
    }
    [self resetInfo];
}

//把参数设成初始状态
- (void) resetInfo
{
    self.ticket_Page = 1;
    self.ticket_hasMore = YES;
}


@end
