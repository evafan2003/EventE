//
//  CheckTickets.h
//  moshTickets
//
//  Created by 魔时网 on 14-2-10.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ticket.h"
#import "GlobalConfig.h"

@interface CheckTickets : NSObject

+ (void) checkTicket:(Ticket *)ticket;

+ (void) cancheCheckTicket:(Ticket *)ticket;

@end
