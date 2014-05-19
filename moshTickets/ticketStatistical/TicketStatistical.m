//
//  TicketStatistical.m
//  moshTickets
//
//  Created by 魔时网 on 13-11-25.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import "TicketStatistical.h"
#import "GlobalConfig.h"

@implementation TicketStatistical

+ (TicketStatistical *) ticketStatistical:(NSDictionary *)dic
{
    TicketStatistical *tic = [[TicketStatistical alloc] init];
    tic.eid = [GlobalConfig convertToString:dic[@"eid"]];
    tic.tid = [GlobalConfig convertToString:dic[@"ticket_id"]];
    tic.name = [GlobalConfig convertToString:dic[@"ticket_name"]];
    tic.remainCount = [GlobalConfig convertToString:dic[@"ticket_num"]];
    tic.saleCount = [GlobalConfig convertToString:dic[@"sold_num"]];
    tic.totalCount = [NSString stringWithFormat:@"%d",([tic.saleCount integerValue] + [tic.remainCount integerValue])];
    tic.checkedCount = [GlobalConfig convertToString:dic[@"wicket"]];
    tic.uncheckedCount = [GlobalConfig convertToString:dic[@"nowicket"]];
    return tic;
}

@end
