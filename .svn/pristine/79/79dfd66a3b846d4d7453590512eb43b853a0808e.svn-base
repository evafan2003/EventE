//
//  Ticket.m
//  MoshTicket
//
//  Created by evafan2003 on 12-6-27.
//  Copyright (c) 2012年 bbdtek. All rights reserved.
//

#import "Ticket.h"
#import "GlobalConfig.h"


@implementation Ticket

@synthesize eid;
@synthesize email;
@synthesize name;
@synthesize t_id;
@synthesize t_price;
@synthesize t_state;
@synthesize t_password;
@synthesize tel;
@synthesize ticket_id;
@synthesize ticket_name;
@synthesize use_date;
@synthesize ispost;
+ (Ticket *) ticket:(NSDictionary *)dic
{
    Ticket *tic = [[Ticket alloc] init];
    //赋值
    tic.t_id = [GlobalConfig convertToString:dic[@"t_id"]];
    tic.use_date = [GlobalConfig convertToString:dic[@"use_date"]];
    tic.t_password = [GlobalConfig convertToString:dic[@"t_password"]];
    tic.t_price = [GlobalConfig convertToString:dic[@"t_price"]];
    tic.tel = [GlobalConfig convertToString:dic[@"tel"]];
    tic.email = [GlobalConfig convertToString:dic[@"email"]];
    tic.name = [GlobalConfig convertToString:dic[@"name"]];
    tic.ticket_name = [GlobalConfig convertToString:dic[@"ticket_name"]];
    tic.ticket_id = [GlobalConfig convertToString:dic[@"ticket_id"]];
    tic.t_state = [GlobalConfig convertToString:dic[@"t_state"]];
    tic.idCard = [GlobalConfig convertToString:dic[@"idcard"]];
    tic.ispost = [GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:dic[@"ispost"]]?dic[@"ispost"]:ticketUpdte_yes;
    return tic;
}

+ (Ticket *) ticket:(NSDictionary *)dic act:(Activity *)act
{
    Ticket *tic = [Ticket ticket:dic];
    //赋值
    tic.eid = act.eid;
    tic.t_price = ([GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:tic.t_price]?[NSString stringWithFormat:@"%@%@",tic.t_price,[GlobalConfig currencyConver:act.currency]]:@"");
    return tic;
}


@end
