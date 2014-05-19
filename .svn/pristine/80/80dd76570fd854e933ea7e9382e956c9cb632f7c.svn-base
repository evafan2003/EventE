//
//  PartTaskModel.m
//  moshTickets
//
//  Created by 魔时网 on 14-5-18.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "PartTaskModel.h"
#import "GlobalConfig.h"
#import "ResourceStatistical.h"

@implementation PartTaskModel

+ (PartTaskModel *) partTaskModel:(NSDictionary *)dic currency:(NSString *)currency
{
    PartTaskModel *sta = [[PartTaskModel alloc] init];
    
    sta.tid = [GlobalConfig convertToString:dic[@"task_id"]];
    sta.name = [GlobalConfig convertToString:dic[@"task_name"]];
    sta.peppleCount = [GlobalConfig convertToString:dic[@"people_count"]];
    sta.successOrder = [GlobalConfig convertToString:dic[@"ordersucc_count"]];
    sta.ticketCount = [GlobalConfig convertToString:dic[@"ticket_count"]];
    sta.totalSales = [GlobalConfig convertToString:dic[@"allpaymoney"]];
    sta.orderPer = [GlobalConfig convertToString:dic[@"succorder_percent"]];
    sta.outPer = [GlobalConfig convertToString:dic[@"failorder_percent"]];
    sta.currency = currency;
    sta.resourceStatistical = [PartTaskModel converToResourceStatistical:[GlobalConfig convertToArray:dic[@"view_top10"]]];
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




@end
