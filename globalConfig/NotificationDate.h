//
//  NotificationDate.h
//  moshTickets
//
//  Created by  evafan2003 on 13-12-3.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobalConfig.h"
#import "MOSHNotificationModel.h"
#import "Activity.h"

@interface NotificationDate : MOSHNotificationModel

- (NotificationDate *) initWithActivity:(Activity *)act;

@property (nonatomic, strong) Activity *act;
@end
