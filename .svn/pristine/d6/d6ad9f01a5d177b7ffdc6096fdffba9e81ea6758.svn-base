//
//  Activity.m
//  moshTickets
//
//  Created by 魔时网 on 13-11-18.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import "Activity.h"
#import "GlobalConfig.h"
#import "TicketType.h"

@implementation Activity

+ (Activity *) activity:(NSDictionary *)dic
{
    Activity *act = [[Activity alloc] init];
    //赋值
    act.eid = [GlobalConfig convertToString:dic[@"eid"]];
    act.title = [GlobalConfig convertToString:dic[@"title"]];
    act.imageUrl = [GlobalConfig convertToString:dic[@"img_url"]];
    act.startDate = [GlobalConfig convertToString:dic[@"start_date"]];
    act.endDate = [GlobalConfig convertToString:dic[@"end_date"]];
    act.oid = [GlobalConfig convertToString:dic[@"oid"]];
    act.status = [GlobalConfig convertToString:dic[@"status"]];
    act.address = [GlobalConfig convertToString:dic[@"address"]];
    act.currency = [GlobalConfig convertToString:dic[@"currency"]];
    
    
    //票种
    NSArray *array = [GlobalConfig convertToArray:dic[@"ticket_class"]];
    NSMutableArray *tArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        TicketType *type = [TicketType ticketType:dic];
        [tArray addObject:type];
    }
    act.tickedTypeArray = tArray;
    
    return act;
}

@end
