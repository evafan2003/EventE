//
//  ActivityStatistical.m
//  moshTickets
//
//  Created by 魔时网 on 13-11-22.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import "ActivityStatistical.h"
#import "GlobalConfig.h"
#import "ResourceStatistical.h"
#import "TicketStatistical.h"
#import "PartTaskModel.h"

@implementation ActivityStatistical

+ (ActivityStatistical *) activityStatistical:(NSDictionary *)dic
{
    ActivityStatistical *sta = [[ActivityStatistical alloc] init];

    sta.actTitle = [GlobalConfig convertToString:dic[@"event_title"]];
    sta.peppleCount = [GlobalConfig convertToString:dic[@"people_count"]];
    sta.successOrder = [GlobalConfig convertToString:dic[@"ordersucc_count"]];
    sta.ticketCount = [GlobalConfig convertToString:dic[@"ticket_count"]];
    sta.totalSales = [GlobalConfig convertToString:dic[@"allpaymoney"]];
    sta.orderPer = [GlobalConfig convertToString:dic[@"succorder_percent"]];
    sta.outPer = [GlobalConfig convertToString:dic[@"failorder_percent"]];
    sta.currency = [GlobalConfig convertToString:dic[@"currency"]];
    sta.taskArray = [ActivityStatistical converToPartTaskArray:[GlobalConfig convertToArray:dic[@"task"]] currency:sta.currency];
    sta.resourceStatistical = [ActivityStatistical converToResourceStatistical:[GlobalConfig convertToArray:dic[@"view_top10"]]];
    sta.ticketStatistical = [ActivityStatistical converToTicketStatistical:[GlobalConfig convertToArray:dic[@"ticket_st"]]];
    return sta;
}

+ (NSMutableArray *) converToResourceStatistical:(NSArray *)array
{
    NSMutableArray *resArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        ResourceStatistical *res = [ResourceStatistical resourceStatistical:dic];
        [resArray addObject:res];
    }
    return resArray;
}

+ (NSMutableArray *) converToTicketStatistical:(NSArray *)array
{
    NSMutableArray *resArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        TicketStatistical *res = [TicketStatistical ticketStatistical:dic];
        [resArray addObject:res];
    }
    return resArray;

}

+ (NSMutableArray *) converToPartTaskArray:(NSArray *)array currency:(NSString *)currency
{
    NSMutableArray *resArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        PartTaskModel *res = [PartTaskModel partTaskModel:dic currency:currency];
        [resArray addObject:res];
    }
    return resArray;
    
}

@end
