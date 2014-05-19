//
//  MoshTicketDatabase.m
//  MoshTicket
//
//  Created by evafan2003 on 12-6-27.
//  Copyright (c) 2012年 bbdtek. All rights reserved.
//

#import "MoshTicketDatabase.h"
#import "FMDatabaseAdditions.h"
#import "Ticket.h"
#import "GlobalConfig.h"

#define DB_NAME @"Ticket.db"

static MoshTicketDatabase *moshTicketDatabase = nil;

@implementation MoshTicketDatabase

+(MoshTicketDatabase *) sharedInstance {
    
    if (!moshTicketDatabase) {
        
        moshTicketDatabase = [[MoshTicketDatabase alloc] init];
    }
    return moshTicketDatabase;
}

-(id) init {
    
    if (self = [super init]) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:DB_NAME];
      
        MOSHLog(@"databaseAddress:%@",filePath);

        db = [FMDatabase databaseWithPath:filePath];
        dbQueue = [FMDatabaseQueue databaseQueueWithPath:filePath];
        
        if (![db open]) {
			NSLog(@"Could not open db.");
			return nil;
		}

		[self createTable];
        
		if ([db hadError]) {
			NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
			return nil;
		}
    }
    
    return self;
}

-(void) createTable {

    [db setShouldCacheStatements:YES];
    
    //票表
//    t_state 票状态 对应1未使用，2已使用，3已过期，4已退票,5删除票
//    ispost 是否同步服务器 0未同步 1已同步
    [db executeUpdate:@"create table  if not exists ticket (id  INTEGER PRIMARY KEY ASC,\
     eid text, email text, name text, t_id text, t_password text, t_price text, t_state text, tel text, ticket_id text, ticket_name text, use_date text, ispost text)"];
    
    //加入新的身份证列
    [self addNewColumn];
    //用票密码和活动名称创建唯一索引
    [db executeUpdate:@"create unique index if not exists t_status on ticket (t_password,eid)"];
    
    [db executeUpdate:@"create index if not exists password on ticket (t_password)"];
    [db executeUpdate:@"create index if not exists eid on ticket (eid)"];
    [db executeUpdate:@"create index if not exists ticketid on ticket (ticket_id)"];
    
    
    //创建报名表列表
    [db executeUpdate:@"create table  if not exists members (id  INTEGER PRIMARY KEY ASC,\
     eid text, tid text, name text, tel text, email text, isentry text, typeid, desc text)"];
    
    //用票密码和活动名称创建唯一索引
    [db executeUpdate:@"create unique index if not exists memberinfo on members (eid, tid, name, tel,email)"];
    
}

- (void) addNewColumn
{
    NSString *first = [[NSUserDefaults standardUserDefaults] objectForKey:@"firstLaunch"];
    if (![GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:first]) {
        BOOL res = [db executeUpdate:@"alter table ticket add idcard text"];
        if (res) {
            MOSHLog(@"成功");
        }
        else {
            MOSHLog(@"失败");
        }
        [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"firstLaunch"];
    }
}

//------------------------------------------------------------------------------------------------------
//票操作

//插入数据库
-(void) insertTicket:(Ticket *)ticket {
    
    [dbQueue inDatabase:^(FMDatabase *database) {
    
        //没有 插之
        NSString *sql = [NSString stringWithFormat:@"replace into ticket(`eid`, `email`, `name`, `t_id`, `t_password`, `t_price`, `t_state`, `tel`, `ticket_id`, `ticket_name`, `use_date`, `ispost`, `idcard`) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')", ticket.eid,ticket.email,ticket.name,ticket.t_id,ticket.t_password,ticket.t_price,ticket.t_state,ticket.tel,ticket.ticket_id,ticket.ticket_name,ticket.use_date,ticket.ispost,ticket.idCard];
        
        [database executeUpdate:sql];
    }];
}

//插入数据库
-(void) insertTickets:(NSArray *)array {
    
    [dbQueue inDatabase:^(FMDatabase *database) {
        NSMutableString *value = [[NSMutableString alloc] init];
        for (Ticket *ticket in array) {
            
            [value appendString:[NSString stringWithFormat:@"('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@'),",ticket.eid,ticket.email,ticket.name,ticket.t_id,ticket.t_password,ticket.t_price,ticket.t_state,ticket.tel,ticket.ticket_id,ticket.ticket_name,ticket.use_date,ticket.ispost,ticket.idCard]];
            
            if ([array indexOfObject:ticket] %400 == 0 && [array indexOfObject:ticket] != 0) {
                [value deleteCharactersInRange:NSMakeRange(value.length - 1, 1)];
                //没有 插之
                NSString *sql = [NSString stringWithFormat:@"replace into ticket(`eid`,`email`, `name`, `t_id`, `t_password`, `t_price`, `t_state`, `tel`, `ticket_id`, `ticket_name`, `use_date`, `ispost`,`idcard`) values%@",value];
                
                BOOL success = [database executeUpdate:sql];
                if (success) {
                    MOSHLog(@"插入成功");
                }
                else {
                    MOSHLog(@"插入失败");
                }
                value = [[NSMutableString alloc] init];
            }
            
        }
        if ([GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:value]) {
            [value deleteCharactersInRange:NSMakeRange(value.length - 1, 1)];
            //没有 插之
            NSString *sql = [NSString stringWithFormat:@"replace into ticket(`eid`,`email`, `name`, `t_id`, `t_password`, `t_price`, `t_state`, `tel`, `ticket_id`, `ticket_name`, `use_date`, `ispost`,`idcard`) values%@",value];
            
            BOOL success = [database executeUpdate:sql];
            if (success) {
                MOSHLog(@"插入成功");
            }
            else {
                MOSHLog(@"插入失败");
            }
            value = [[NSMutableString alloc] init];
        }
    }];
}



-(Ticket *)getOneTicket:(NSString *)t_password eid:(NSString *)eid ticketID:(NSString *)ticketID{
    
    Ticket *ticket = nil;
    NSMutableString *sql = [NSMutableString stringWithFormat:@"select * from ticket where eid = %@",eid];
    
    if ([GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:ticketID]) {
        [sql appendFormat:@" and ticket_id in (%@)",ticketID];
    }
    
    [sql appendFormat:@" and t_password = %@",t_password];
    
    FMResultSet *resultSet = [db executeQuery:sql];
    while ([resultSet next]) {
        ticket = [self ticketOfResultSet:resultSet];
    }
    [resultSet close];
    return ticket;
}

//-(NSMutableArray *) searchTicket:(NSString *)passwordOrTel eid:(NSString *)eid ticketID:(NSString *)ticketID{
//    
//    NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:0];
//    
//    NSMutableString *sql = [NSMutableString stringWithFormat:@"select * from ticket where (t_password like '%%%@%%' or tel like '%%%@%%')",passwordOrTel,passwordOrTel];
//    
//    if ([GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:eid]) {
//        [sql appendFormat:@" and eid = %@",eid];
//    }
//    if ([GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:ticketID]) {
//        [sql appendFormat:@" and ticket_id in (%@)",ticketID];
//    }
//    
//  
//    [sql appendFormat:@" and t_state in (1,2)"];
//
//    [sql appendString:@" order by use_date desc"];
//    
//    FMResultSet *resultSet = [db executeQuery:sql];
//    while ([resultSet next]) {
//        Ticket *ticket = [self ticketOfResultSet:resultSet];
//        [resultArray addObject:ticket];
//        
//    }
//    [resultSet close];
//    return resultArray;
//    
//}

-(NSMutableArray *) searchTicket:(NSString *)passwordOrTel eid:(NSString *)eid ticketID:(NSString *)ticketID{
    
    NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:0];
    
    NSMutableString *sql = [NSMutableString stringWithFormat:@"select * from ticket where  eid = %@",eid];
    

    if ([GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:ticketID]) {
        [sql appendFormat:@" and ticket_id in (%@)",ticketID];
    }
    
    
    [sql appendFormat:@" and t_state in (1,2) and (t_password like '%%%@%%' or tel like '%%%@%%')",passwordOrTel,passwordOrTel];
    
    [sql appendString:@" order by use_date desc"];
    
    FMResultSet *resultSet = [db executeQuery:sql];
    while ([resultSet next]) {
        Ticket *ticket = [self ticketOfResultSet:resultSet];
        [resultArray addObject:ticket];
        
    }
    [resultSet close];
    return resultArray;
    
}


//取一个活动所有票数量
-(int) getAllTicketCountByEid:(NSString *)eid status:(NSString *)status ticketID:(NSString *)ticketID
{
    
    int totalCount = 0;
    NSMutableString *sql = [NSMutableString stringWithFormat:@"select * from ticket where eid = %@",eid];
    
    if ([GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:ticketID]) {
        [sql appendFormat:@" and ticket_id in (%@)",ticketID];
    }

    
    if ([GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:status]) {
        [sql appendFormat:@" and t_state in (%@)",status];
    }
    else {
        [sql appendFormat:@" and t_state in (1,2)"];
    }
    
    
    FMResultSet *resultSet = [db executeQuery:sql];
    while ([resultSet next]) {
//        totalCount = [resultSet intForColumnIndex:0];
        totalCount ++;
    }
    [resultSet close];
    return totalCount;
}


//取某个状态的所有票
-(NSMutableArray *) getAllTicketByEid:(NSString *)eid status:(NSString *)status ticketID:(NSString *)ticketID{
    
    NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:0];
    
    NSMutableString *sql = [NSMutableString stringWithFormat:@"select * from ticket where eid = %@",eid];
    
    if ([GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:ticketID]) {
        [sql appendFormat:@" and ticket_id in (%@)",ticketID];
    }
    
    if ([GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:status]) {
        [sql appendFormat:@" and t_state in (%@)",status];
    }
    else {
        [sql appendFormat:@" and t_state in (1,2)"];
    }
   
//    [sql appendString:@"order by use_date desc"];
    
    FMResultSet *resultSet = [db executeQuery:sql];
    
    while ([resultSet next]) {
        Ticket *ticket = [self ticketOfResultSet:resultSet];
        [resultArray addObject:ticket];
    }
    [resultSet close];
    return resultArray;
    
}

//取未提交服务器的所有票
-(NSMutableArray *) getAllUnpostTicketsByEid:(NSString *)eid {
    
    NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:0];
    
    FMResultSet *resultSet = [db executeQuery:@"select * from ticket where eid = ? and ispost = ?", eid,ticketUpdte_no];
    
    while ([resultSet next]) {
        Ticket *ticket = [self ticketOfResultSet:resultSet];
        [resultArray addObject:ticket];
    }
    [resultSet close];
    return resultArray;
    
}

//取未提交服务器的所有票
-(NSMutableArray *) getAllUnpostTickets {
    
    NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:0];
    
    FMResultSet *resultSet = [db executeQuery:@"select * from ticket where ispost = ?",ticketUpdte_no];
    
    while ([resultSet next]) {
        Ticket *ticket = [self ticketOfResultSet:resultSet];
        [resultArray addObject:ticket];
    }
    [resultSet close];
    return resultArray;
    
}


//删除
-(void) deleteOneTickt:(NSString *)t_id {

    [dbQueue inDatabase:^(FMDatabase *database) {
        NSString *sql = [NSString stringWithFormat:@"delete from ticket where t_id =%@", t_id];
        [db executeUpdate:sql];
    }];
}

//全部删除
-(void) deleteAllTicketWitheid:(NSString *)eid {
    
    [dbQueue inDatabase:^(FMDatabase *database) {
      NSString *sql = [NSString stringWithFormat:@"delete from ticket where eid = %@", eid];
        [db executeUpdate:sql];
    }];
   
    
}

//大杀器！注意！
-(void) deleteAllTicket {
    
    [dbQueue inDatabase:^(FMDatabase *database) {
         [db executeUpdate:@"delete from ticket "];
    }];
    
}

- (Ticket *) ticketOfResultSet:(FMResultSet *)resultSet
{
    Ticket *ticket = [[Ticket alloc] init];
    ticket.eid = [GlobalConfig convertToString:[resultSet stringForColumn:@"eid"]];
    ticket.email = [GlobalConfig convertToString:[resultSet stringForColumn:@"email"]];
    ticket.name = [GlobalConfig convertToString:[resultSet stringForColumn:@"name"]];
    ticket.t_id = [GlobalConfig convertToString:[resultSet stringForColumn:@"t_id"]];
    ticket.t_price = [GlobalConfig convertToString:[resultSet stringForColumn:@"t_price"]];
    ticket.t_state = [GlobalConfig convertToString:[resultSet stringForColumn:@"t_state"]];
    ticket.t_password = [GlobalConfig convertToString:[resultSet stringForColumn:@"t_password"]];
    ticket.tel = [GlobalConfig convertToString:[resultSet stringForColumn:@"tel"]];
    ticket.ticket_id = [GlobalConfig convertToString:[resultSet stringForColumn:@"ticket_id"]];
    ticket.ticket_name = [GlobalConfig convertToString:[resultSet stringForColumn:@"ticket_name"]];
    ticket.use_date = [GlobalConfig convertToString:[resultSet stringForColumn:@"use_date"]];
    ticket.ispost = [GlobalConfig convertToString:[resultSet stringForColumn:@"ispost"]];
    ticket.idCard = [GlobalConfig convertToString:[resultSet stringForColumn:@"idcard"]];
    
    return ticket;
}
//
////----------------------------------------------------------------------------------------------------

//验票(0.错误 1.未使用 2.已使用)
-(void) UpdateTikcet:(NSString *)t_id status:(NSString *)status {
    
    [dbQueue inDatabase:^(FMDatabase *database) {
        NSString *time = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]];
        if ([status intValue] == 1) {
            time = @"0";
        }
        
        NSString *sql = [NSString stringWithFormat:@"update ticket set t_state = %@,use_date = %@ where t_id = %@", status, time, t_id];
         [db executeUpdate:sql];
    }];
}

- (void) updateTicket:(Ticket *)ticket state:(NSString *)state
{
    [dbQueue inDatabase:^(FMDatabase *database) {
        NSString *sql = [NSString stringWithFormat:@"update ticket set t_state = %@ where eid  = %@ and t_password = %@", state, ticket.eid,ticket.t_password];
        [db executeUpdate:sql];
    }];
}

- (void) updateTicket:(Ticket *)ticket isPost:(NSString *)ispost
{
     [dbQueue inDatabase:^(FMDatabase *database) {
         NSString *sql = [NSString stringWithFormat:@"update ticket set ispost = %@ where eid  = %@ and  t_password = %@", ispost, ticket.eid,ticket.t_password];
         [db executeUpdate:sql];
     }];
}

- (void) updateTicket:(Ticket *)ticket useDate:(NSString *)usedate
{
     [dbQueue inDatabase:^(FMDatabase *database) {
         NSString *sql = [NSString stringWithFormat:@"update ticket set use_date = %@ where eid  = %@ and t_password = %@", usedate, ticket.eid,ticket.t_password];
             [db executeUpdate:sql];
     }];
}


#pragma mark - members -

//插入数据库
-(void) insertMembers:(NSArray *)array {
    
//    [dbQueue inDatabase:^(FMDatabase *database) {
        NSMutableString *value = [[NSMutableString alloc] init];
        for (MemberInfo *info in array) {
            
            [value appendString:[NSString stringWithFormat:@"('%@','%@','%@','%@','%@','%@','%@','%@'),",info.eid,info.tid,info.name,info.phoneNumber,info.email,info.isentry,info.tTypeID,info.desc]];
            
            if ([array indexOfObject:info] %400 == 0 && [array indexOfObject:info] != 0) {
                [value deleteCharactersInRange:NSMakeRange(value.length - 1, 1)];
                //没有 插之
                NSString *sql = [NSString stringWithFormat:@"replace into members (`eid`,`tid`, `name`, `tel`, `email`, `isentry`, `typeid`,`desc`) values%@",value];
                
                BOOL success = [db executeUpdate:sql];
                if (success) {
                    MOSHLog(@"插入成功");
                }
                else {
                    MOSHLog(@"插入失败");
                }
                value = [[NSMutableString alloc] init];
            }
            
        }
        if ([GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:value]) {
            [value deleteCharactersInRange:NSMakeRange(value.length - 1, 1)];
            //没有 插之
            NSString *sql = [NSString stringWithFormat:@"replace into members (`eid`,`tid`, `name`, `tel`, `email`, `isentry`, `typeid`, `desc`) values%@",value];
            
            BOOL success = [db executeUpdate:sql];
            if (success) {
                MOSHLog(@"插入成功");
            }
            else {
                MOSHLog(@"插入失败");
            }
            value = [[NSMutableString alloc] init];
        }
//    }];
}


//取某个票种下的所有报名人
-(NSMutableArray *) getAllMemberByEid:(NSString *)eid ticketID:(NSString *)ticketID
{
    
    NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:0];
    
    NSMutableString *sql = [NSMutableString stringWithFormat:@"select * from members where eid = %@",eid];
    
    if ([GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:ticketID]) {
        [sql appendFormat:@" and (typeid like '%%%@%%')",ticketID];
    }
    
    FMResultSet *resultSet = [db executeQuery:sql];
    
    while ([resultSet next]) {
        MemberInfo *info = [self memberOfResultSet:resultSet];
        [resultArray addObject:info];
    }
    [resultSet close];
    return resultArray;
}

- (MemberInfo *) memberOfResultSet:(FMResultSet *)resultSet
{
    MemberInfo *info = [[MemberInfo alloc] init];
    info.eid = [resultSet stringForColumn:@"eid"];
    info.email = [resultSet stringForColumn:@"email"];
    info.name = [resultSet stringForColumn:@"name"];
    info.tid = [resultSet stringForColumn:@"tid"];
    info.phoneNumber = [resultSet stringForColumn:@"tel"];
    info.isentry = [resultSet stringForColumn:@"isentry"];
    info.desc = [resultSet stringForColumn:@"desc"];
    
    [info memberDescConvertToInfo];
    
    return info;
}

- (void) dealloc
{
    [db close];
}

@end
