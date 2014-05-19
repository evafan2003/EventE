//
//  TicketStatistical.h
//  moshTickets
//
//  Created by 魔时网 on 13-11-25.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

/*
 票种model
 */

#import <Foundation/Foundation.h>

@interface TicketStatistical : NSObject

@property (nonatomic, strong) NSString *eid;
@property (nonatomic, strong) NSString *tid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *totalCount;//总数
@property (nonatomic, strong) NSString *saleCount;//已售票数
@property (nonatomic, strong) NSString *remainCount;//可售票数
@property (nonatomic, strong) NSString *checkedCount;//检票数
@property (nonatomic, strong) NSString *uncheckedCount;//未检票数


+ (TicketStatistical *) ticketStatistical:(NSDictionary *)dic;

@end
