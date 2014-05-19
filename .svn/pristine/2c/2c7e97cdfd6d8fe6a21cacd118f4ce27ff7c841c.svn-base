//
//  MoshTicketDatabase.h
//  MoshTicket
//
//  Created by evafan2003 on 12-6-27.
//  Copyright (c) 2012年 bbdtek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ticket.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "MemberInfo.h"

@interface MoshTicketDatabase : NSObject {

    FMDatabase *db;
    FMDatabaseQueue *dbQueue;
     
}

+ (MoshTicketDatabase *)sharedInstance;

//票操作-------------------------------------------------------------------------------------------

//插入数据库
-(void) insertTicket:(Ticket *)ticket;
-(void) insertTickets:(NSArray *)array;

//查找一条票
-(Ticket *)getOneTicket:(NSString *)t_password eid:(NSString *)eid ticketID:(NSString *)ticketID;

//取票数量
-(int) getAllTicketCountByEid:(NSString *)eid status:(NSString *)status ticketID:(NSString *)ticketID;

//取一个活动某些票种的所有票
-(NSMutableArray *) getAllTicketByEid:(NSString *)eid status:(NSString *)status ticketID:(NSString *)ticketID;


//取未提交服务器的所有票
-(NSMutableArray *) getAllUnpostTickets;
-(NSMutableArray *) getAllUnpostTicketsByEid:(NSString *)eid;

//搜票
-(NSMutableArray *) searchTicket:(NSString *)passwordOrTel eid:(NSString *)eid ticketID:(NSString *)ticketID;

//删除
-(void) deleteOneTickt:(NSString *)t_id;
-(void) deleteAllTicketWitheid:(NSString *)eid;
//大杀器！注意！
-(void) deleteAllTicket;


/*
 更改票信息
 state 票状态
 ispost 是否同步
 usedate 使用日期
 */
- (void) updateTicket:(Ticket *)ticket state:(NSString *)state;
- (void) updateTicket:(Ticket *)ticket isPost:(NSString *)ispost;
- (void) updateTicket:(Ticket *)ticket useDate:(NSString *)usedate;
//验票(0.未使用 1.待上传 2.已使用)
-(void) UpdateTikcet:(NSString *)t_id status:(NSString *)status;


//取某个票种下的所有报名人
-(NSMutableArray *) getAllMemberByEid:(NSString *)eid ticketID:(NSString *)ticketID;

//插入数据库
-(void) insertMembers:(NSArray *)array;
@end
