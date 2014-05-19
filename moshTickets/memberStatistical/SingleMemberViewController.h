//
//  SingleMemberViewController.h
//  moshTickets
//
//  Created by 魔时网 on 14-2-20.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "BaseTableViewController.h"
#import "MemberInfo.h"
#import "TicketType.h"

@interface SingleMemberViewController : BaseTableViewController

@property (strong, nonatomic) MemberInfo *member;

- (id) initWithMember:(MemberInfo *)member;

@end
