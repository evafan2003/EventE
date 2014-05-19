//
//  SourceStatistical.m
//  moshTickets
//
//  Created by 魔时网 on 13-11-25.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import "ResourceStatistical.h"
#import "GlobalConfig.h"

@implementation ResourceStatistical

+ (ResourceStatistical *) resourceStatistical:(NSDictionary *)dic
{
    ResourceStatistical *sou = [[ResourceStatistical alloc] init];
    
    sou.notBuy = [GlobalConfig convertToString:dic[@"notbuy"]];
        sou.notPay = [GlobalConfig convertToString:dic[@"notpay"]];
        sou.sucOrder = [GlobalConfig convertToString:dic[@"succ"]];
        sou.totalCount = [GlobalConfig convertToString:dic[@"times"]];
        sou.name = [GlobalConfig convertToString:dic[@"from_name"]];
        sou.saleCount = [GlobalConfig convertToString:dic[@"t_count"]];
        sou.sucPercent = [[GlobalConfig convertToString:dic[@"succpercent"]] stringByAppendingString:@"%"];
    
    return sou;
}

@end
