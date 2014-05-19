//
//  MOSHNotificationModel.h
//  fenice
//
//  Created by 魔时网 on 13-12-3.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

/*
 *消息model 
 *子类继承父类实现具体方法
 *
 */

#import <Foundation/Foundation.h>

@interface MOSHNotificationModel : NSObject

@property (nonatomic, assign) NSInteger    TimeInterval;//提醒提前时间（秒）
@property (nonatomic, assign) NSString      *startDate;//活动开始时间；

/*
 *用户信息 作为判断不同提醒的依据
 *子类重写
 */
- (NSDictionary *)userInfo;

/*
 *提示语
 *子类重写
 */
- (NSString *)alertBody;

@end
