//
//  Ticket.h
//  MoshTicket
//
//  Created by evafan2003 on 12-6-27.
//  Copyright (c) 2012年 bbdtek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Activity.h"

//票状态 : 0不存在,1未使用，2已使用，3已过期，4已退票,5删除票
#define ticketState_unExist @"0"
#define ticketState_unUse  @"1"
#define ticketState_isUsed  @"2"
#define ticketState_isOverdue  @"3"
#define ticketState_isCancle @"4"
#define ticketState_isDel  @"5"

//是否同步服务器 0未同步 1已同步
#define ticketUpdte_no  @"0"
#define ticketUpdte_yes  @"1"

@interface Ticket : NSObject

//票属活动
@property (nonatomic, strong) NSString* eid;            //活动ID

//票属票种
@property (nonatomic, strong) NSString* ticket_id;    //票种ID
@property (nonatomic, strong) NSString* ticket_name;    //票种名称

//票信息
@property (nonatomic, strong) NSString* t_id;           //票ID
@property (nonatomic, strong) NSString* t_password;     //验票密码
@property (nonatomic, strong) NSString* t_price;        //价钱
@property (nonatomic, strong) NSString* t_state;        //票状态  1未使用，2已使用，3已过期，4已退票,5删除票

//购票人信息
@property (nonatomic, strong) NSString* name;           //购票人姓名
@property (nonatomic, strong) NSString* email;          //邮箱
@property (nonatomic, strong) NSString* tel;            //电话
@property (nonatomic, strong) NSString* use_date;       //购票时间
@property (nonatomic, strong) NSString* idCard;         //身份证


@property (nonatomic, strong) NSString* ispost;         //是否同步服务器

+ (Ticket *) ticket:(NSDictionary *)dic act:(Activity *)act;
@end
