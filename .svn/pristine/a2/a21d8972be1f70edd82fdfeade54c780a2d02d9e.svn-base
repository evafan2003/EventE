//
//  MOSHLocalNotification.h
//  fenice
//
//  Created by 魔时网 on 13-12-3.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

/*
 *注册消息提醒
 */
#import <Foundation/Foundation.h>
#import "MOSHNotificationModel.h"

@interface MOSHLocalNotification : NSObject

/*
 注册消息，如果有相同提醒则不添加，判断依据noti.userInfo是否相同
 */
+ (void)addNotification:(MOSHNotificationModel *)noti;

/*
 删除提醒 判断依据noti.userInfo是否相同
 */
+ (void) deleteNotification:(MOSHNotificationModel *)noti;

/*
 删除全部提醒
 */
+ (void) deletteAllNotification;

@end
