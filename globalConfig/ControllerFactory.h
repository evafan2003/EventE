//
//  ControllerFactory.h
//  moshTicket
//
//  Created by 魔时网 on 13-11-13.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobalConfig.h"
#import "HTTPClient.h"

#import "LoginViewController.h"
#import "BaseNavigationController.h"
#import "ActivityViewController.h"
#import "ActivityStatisticalViewController.h"
#import "StatisticalViewController.h"
#import "TicketStatisticalViewController.h"
#import "ResourceStatisticalViewController.h"
#import "SingleResourceStaViewController.h"
#import "SingleTicketStatisticalViewController.h"
#import "TicketConfigViewController.h"
#import "PasswordViewController.h"
#import "UserInfoViewController.h"
#import "MemberStatisticViewController.h"
#import "SingleMemberViewController.h"
#import "WebViewController.h"
#import "LaunchActivityViewController.h"
#import "AddTicketTypeViewController.h"
#import "PartSaleTaskViewController.h"


@interface ControllerFactory : NSObject

//返回登录页面的Controller
+ (UIViewController *) controllerWithloginIn;

//登录成功 进入活动列表
+(UIViewController *) controllerWithLoginSuccess;

//登录页面的Controller
+ (UIViewController *) loginInViewController;

//忘记密码
+(UIViewController *) controllerWithForgetPassWord;

//活动列表
+(UIViewController *) activityListViewController;

//活动统计
+ (UIViewController *) activityStatisticalWithActivity:(Activity *)act;

//票统计
+ (UIViewController *) ticketStatisticalWithData:(NSMutableArray *)array activity:(Activity *)act;

//来源统计
+ (UIViewController *) resourceStatisticalWithData:(NSMutableArray *)array activity:(Activity *)act;

//圆环图
+ (UIViewController *) singleresourceStaViewControllerWithResourceStatistical:(ResourceStatistical *)res;

//饼图
+ (UIViewController *) singleTicketStaViewControllerWithTicketStatistical:(TicketStatistical *)tic;

//验票设置
+ (UIViewController *) ticketConfigViewControllerWithActivity:(Activity *)act;

//报名信息
+ (UIViewController *) memberStatisticViewControllerWithActivity:(Activity *)act;

//报名者个人信息
+ (UIViewController *) singleMemberViewControllerWithMemberInfo:(MemberInfo *)info;

//网页
+ (UIViewController *) webViewControllerWithTitle:(NSString *)title Url:(NSString *)url;

//发布活动
+ (UIViewController *) launchAcitivityViewController;

//增加票种
+ (UIViewController *) addTicketTypeViewController;

//分销任务
+ (UIViewController *) partSaleTaskViewController;

@end
