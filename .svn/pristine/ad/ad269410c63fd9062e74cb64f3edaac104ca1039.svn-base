//
//  PartTaskModel.h
//  moshTickets
//
//  Created by 魔时网 on 14-5-18.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PartTaskModel : NSObject

@property (nonatomic, strong) NSString *tid;//id
@property (nonatomic, strong) NSString *name;//标题
@property (nonatomic, strong) NSString *peppleCount;//总访问人数
@property (nonatomic, strong) NSString *successOrder;//成功订单
@property (nonatomic, strong) NSString *ticketCount;//预售票
@property (nonatomic, strong) NSString *totalSales;//总销售额
@property (nonatomic, strong) NSString *orderPer;//订单转化率
@property (nonatomic, strong) NSString *outPer;//总跳出率
@property (nonatomic, strong) NSString *currency;//币种

@property (nonatomic, strong) NSMutableArray  *resourceStatistical;//来源top10统计

+ (PartTaskModel *) partTaskModel:(NSDictionary *)dic currency:(NSString *)currency;

@end
