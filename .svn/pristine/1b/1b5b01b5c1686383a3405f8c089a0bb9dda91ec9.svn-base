//
//  CheckTickets.m
//  moshTickets
//
//  Created by 魔时网 on 14-2-10.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "CheckTickets.h"
#import "MoshTicketDatabase.h"
#import "ServerManger.h"

@implementation CheckTickets

+ (void) checkTicket:(Ticket *)ticket
{
    if ([ticket.t_state isEqualToString:ticketState_unUse]) {
        //1.更新数据库
        MoshTicketDatabase *db = [MoshTicketDatabase sharedInstance];
        [db updateTicket:ticket state:ticketState_isUsed];
        [db updateTicket:ticket isPost:ticketUpdte_no];
        [db updateTicket:ticket useDate:[NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]]];
        
        //2.发消息
        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_checkTicket object:ticket];
        
        //3.把ticket交给上传类
        [[ServerManger shareServerManger] updateTicket:ticket];
    }
    
}

+ (void) cancheCheckTicket:(Ticket *)ticket
{
    //1.更新数据库
    MoshTicketDatabase *db = [MoshTicketDatabase sharedInstance];
    [db updateTicket:ticket state:ticketState_unUse];
    [db updateTicket:ticket isPost:ticketUpdte_no];
    [db updateTicket:ticket useDate:@"0"];
    
    //    2.发消息
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_cacelCheckTicket object:ticket];
    
    //    3.把ticket交给上传类
    
}

@end
