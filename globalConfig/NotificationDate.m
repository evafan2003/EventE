//
//  NotificationDate.m
//  moshTickets
//
//  Created by  evafan2003 on 13-12-3.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import "NotificationDate.h"
#import "MoshDefine.h"

static CGFloat timeInterval = 86400;

@implementation NotificationDate


- (NotificationDate *) initWithActivity:(Activity *)act
{
    if (self = [super init]) {
        self.act = act;
        self.TimeInterval = timeInterval;
        self.startDate = act.startDate;
    }
    return self;
}


- (NSDictionary *)userInfo
{
    return @{@"eid":self.act.eid};
}

- (NSString *)alertBody
{
    return [NSString  stringWithFormat:NOTIFICATION_ALERT,self.act.title];
}

@end
