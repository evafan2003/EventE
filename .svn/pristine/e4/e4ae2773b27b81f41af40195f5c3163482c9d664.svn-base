//
//  UserInfo.m
//  moshTickets
//
//  Created by 魔时网 on 14-2-18.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "UserInfo.h"
#import "GlobalConfig.h"

@implementation UserInfo

+ (UserInfo *) userInfo:(NSDictionary *)dic
{
    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:USER_USERID];
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:USER_USERNAME];
    
    UserInfo *info = [[UserInfo alloc] init];
    info.uid = [GlobalConfig convertToString:uid];
    info.username = [GlobalConfig convertToString:userName];
    info.actNumber = ([GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:dic[@"event"]] ? dic[@"event"] : @"0");
    info.peopleNumber = ([GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:dic[@"user_count"]] ? dic[@"user_count"] : @"0");
    info.saleNumber = ([GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:dic[@"ticket_count"]] ? dic[@"ticket_count"] : @"0");
    info.totalPrice = [NSMutableArray array];
    NSDictionary *total = [GlobalConfig convertToDictionary:dic[@"all_money"]];
    NSNumber *cny = [GlobalConfig convertToNumber:total[@"CNY"]];
    NSNumber *usd = [GlobalConfig convertToNumber:total[@"USD"]];
    NSNumber *hkd = [GlobalConfig convertToNumber:total[@"HKD"]];
    NSNumber *twd = [GlobalConfig convertToNumber:total[@"TWD"]];
    if ([cny floatValue] > 0) {
        NSString *str = [NSString stringWithFormat:@"%@/元",[GlobalConfig priceConver:cny]];
        [info.totalPrice addObject:str];
    }
    if ([usd floatValue] > 0) {
        NSString *str = [NSString stringWithFormat:@"%@/美元",[GlobalConfig priceConver:usd]];    [info.totalPrice addObject:str];
    }
    if ([hkd floatValue] > 0) {
        NSString *str = [NSString stringWithFormat:@"%@/港币",[GlobalConfig priceConver:hkd]];
        [info.totalPrice addObject:str];
    }
    if ([twd floatValue] > 0) {
        NSString *str = [NSString stringWithFormat:@"%@/台币",[GlobalConfig priceConver:twd]];
        [info.totalPrice addObject:str];
    }
    
    if (info.totalPrice.count == 0) {
        [info.totalPrice addObject:@"0/元"];
    }

    return info;
}

@end
