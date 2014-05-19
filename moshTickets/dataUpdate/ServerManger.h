//
//  ServerManger.h
//  moshTickets
//
//  Created by 魔时网 on 14-2-11.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "Ticket.h"

#define UpdateTime 5

@interface ServerManger : NSObject
{
    Reachability *ability;
    NSTimer *_loadTimer;
    NSTimer *_postTimer;
    Activity *_act;
}

@property (nonatomic, strong) NSMutableArray *ticketsArray;
@property (nonatomic, strong) NSMutableArray *tmpArray;
@property (nonatomic, assign) BOOL isPosting;
@property (nonatomic, assign) BOOL isNetWorking;

//单例
+ (ServerManger *) shareServerManger;

/*
 开始工作
 */
- (void) startNetNoti;
- (void) startDownloadNewsTicket:(Activity *)act;

/*
 结束下载票数据
 */
- (void) endDownloadNewsTicket;

/*
 将已检的票数据提交服务器
 单个和批量
 */
- (void) updateTicket:(Ticket *)ticket;
- (void) updateTickets:(NSArray *)array;

@end
