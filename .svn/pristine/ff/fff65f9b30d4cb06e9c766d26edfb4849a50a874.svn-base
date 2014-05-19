//
//  MOSHLocalNotification.m
//  fenice
//
//  Created by 魔时网 on 13-12-3.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import "MOSHLocalNotification.h"
#import "GlobalConfig.h"

@implementation MOSHLocalNotification

//判断某个通知提醒是否存在
+ (UILocalNotification*)notificationIsExited:(MOSHNotificationModel *)noti
{
    NSArray *allNotifications = [[UIApplication sharedApplication]scheduledLocalNotifications];
//    MOSHLog(@"notiCount = %d",allNotifications.count);
    
    for(UILocalNotification *notification in allNotifications){
        if ([notification.userInfo isEqualToDictionary:[noti userInfo]]) {
            return notification;
        }
    }
    return nil;
}

+ (void)addNotification:(MOSHNotificationModel *)noti
{
    
    UILocalNotification *notification = [MOSHLocalNotification notificationIsExited:noti];
    
    NSDate *fireDate = [NSDate dateWithTimeIntervalSince1970:([noti.startDate integerValue] - noti.TimeInterval)];
    //如果没找到该通知提醒
    if(!notification){
        
        //注册通知条件（noti.startDate - 提前提醒时间）大于 当前时间
        if ([fireDate compare:[NSDate date]] == NSOrderedDescending) {
            
            [self addLocalNotification:noti];
            
            }
    }
    else {
        //如果已注册提醒时间与现有时间不相同 则删除原有的 添加新提醒
        if(([notification.fireDate compare:fireDate] != NSOrderedSame) && ([fireDate compare:[NSDate date]] == NSOrderedDescending)){
            [[UIApplication sharedApplication] cancelLocalNotification:notification];
            [self addLocalNotification:noti];
        }
        
    }
}

+ (void) addLocalNotification:(MOSHNotificationModel *)noti
{
    //注册提醒
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    
    if(notification){
        
        notification.fireDate =  [NSDate dateWithTimeIntervalSince1970:([noti.startDate integerValue] - noti.TimeInterval)];
        notification.timeZone = [NSTimeZone defaultTimeZone];
        
        notification.alertBody = [noti alertBody];
        notification.soundName = UILocalNotificationDefaultSoundName;
        
        notification.userInfo = [noti userInfo];
        [[UIApplication sharedApplication]scheduleLocalNotification:notification];
    }

}

+ (void) deleteNotification:(MOSHNotificationModel *)noti
{
   UILocalNotification *notification = [MOSHLocalNotification notificationIsExited:noti];
    //如果找到该通知提醒
    if(notification){
        // 删除订阅
        [[UIApplication sharedApplication]cancelLocalNotification:notification];
    }
}

+ (void) deletteAllNotification
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

@end
    
    
    
