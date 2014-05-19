//
//  ActivityStatistical.h
//  moshTickets
//
//  Created by 魔时网 on 13-11-22.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityStatistical : NSObject

@property (nonatomic, strong) NSString *actTitle;//标题
@property (nonatomic, strong) NSString *peppleCount;//总访问人数
@property (nonatomic, strong) NSString *successOrder;//成功订单
@property (nonatomic, strong) NSString *ticketCount;//预售票
@property (nonatomic, strong) NSString *totalSales;//总销售额
@property (nonatomic, strong) NSString *orderPer;//订单转化率
@property (nonatomic, strong) NSString *outPer;//总跳出率
@property (nonatomic, strong) NSString *currency;//币种
@property (nonatomic, strong) NSMutableArray  *taskArray;//分销任务
@property (nonatomic, strong) NSMutableArray  *resourceStatistical;//来源top10统计
@property (nonatomic, strong) NSMutableArray  *ticketStatistical;//票种销售统计

+ (ActivityStatistical *) activityStatistical:(NSDictionary *)dic;

@end
