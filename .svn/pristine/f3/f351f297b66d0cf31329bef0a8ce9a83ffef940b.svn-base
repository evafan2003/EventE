//
//  ControllerFactory.m
//  moshTicket
//
//  Created by 魔时网 on 13-11-13.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import "ControllerFactory.h"

@implementation ControllerFactory

+ (UIViewController *) controllerWithloginIn
{
    if ([GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:[[NSUserDefaults standardUserDefaults] objectForKey:USER_USERID]]) {
        return [ControllerFactory controllerWithLoginSuccess];
    }
    return [ControllerFactory loginInViewController];
}

+ (UIViewController *) loginInViewController
{
    return [LoginViewController viewControllerWithNib];
}

+(UIViewController *) controllerWithLoginSuccess
{
    return [UserInfoViewController viewControllerWithNib];
}

+(UIViewController *) controllerWithForgetPassWord
{
    return [PasswordViewController viewControllerWithNib];
}

+ (UIViewController *) activityListViewController
{
    return [ActivityViewController viewController];
}

+ (UIViewController *) activityStatisticalWithActivity:(Activity *)act
{
    return [[ActivityStatisticalViewController alloc] initWithNibName:NSStringFromClass([ActivityStatisticalViewController class]) bundle:nil activity:act];
}

+ (UIViewController *) ticketStatisticalWithData:(NSMutableArray *)array activity:(Activity *)act
{
    return [[TicketStatisticalViewController alloc] initWithActivity:act dataArray:array];
}

+ (UIViewController *) resourceStatisticalWithData:(NSMutableArray *)array activity:(Activity *)act
{
    return [[ResourceStatisticalViewController alloc] initWithActivity:act dataArray:array];
}

+ (UIViewController *) singleresourceStaViewControllerWithResourceStatistical:(ResourceStatistical *)res
{
    return [[SingleResourceStaViewController alloc] initWithNibName:NSStringFromClass([SingleResourceStaViewController class]) bundle:nil resourceStatistical:res];
}

+ (UIViewController *) singleTicketStaViewControllerWithTicketStatistical:(TicketStatistical *)tic
{
    return [[SingleTicketStatisticalViewController alloc] initWithTicketStatistical:tic];
}


+ (UIViewController *) ticketConfigViewControllerWithActivity:(Activity *)act
{
    return [[TicketConfigViewController alloc] initWithNibName:NSStringFromClass([TicketConfigViewController class]) bundle:nil activity:act];
}

+ (UIViewController *) memberStatisticViewControllerWithActivity:(Activity *)act
{
    return [[MemberStatisticViewController alloc] initWithActivity:act dataArray:nil];
}

+ (UIViewController *) singleMemberViewControllerWithMemberInfo:(MemberInfo *)info
{
    return [[SingleMemberViewController alloc] initWithMember:info];
}

+ (UIViewController *) webViewControllerWithTitle:(NSString *)title Url:(NSString *)url
{
    return [[WebViewController  alloc] initWithTitle:title URL:[NSURL URLWithString:url]];
}

+ (UIViewController *) launchAcitivityViewController
{
    return [LaunchActivityViewController viewControllerWithNib];
}

//增加票种
+ (UIViewController *) addTicketTypeViewController
{
    return [AddTicketTypeViewController viewControllerWithNib];
}

+ (UIViewController *) partSaleTaskViewController
{
    return [PartSaleTaskViewController viewControllerWithNib];
}
@end
