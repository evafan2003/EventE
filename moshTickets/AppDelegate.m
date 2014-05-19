//
//  AppDelegate.m
//  moshTicket
//
//  Created by 魔时网 on 13-11-12.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import "AppDelegate.h"
#import "ControllerFactory.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    application.applicationIconBadgeNumber = 0;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //设置stateBar的字体颜色为亮色 前提在 infoplist 中 Set UIViewControllerBasedStatusBarAppearance to NO.

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.client = [HTTPClient shareHTTPClient];
    self.manger = [ServerManger shareServerManger];
    self.database = [MoshTicketDatabase sharedInstance];
    [_manger startNetNoti];
    [self updateWithServer];
    self.window.rootViewController = [[BaseNavigationController alloc] initWithRootViewController:[ControllerFactory controllerWithloginIn]];
    self.window.backgroundColor = [UIColor clearColor];
    [self.window makeKeyAndVisible];

    return YES;
}


//提交已验票数据
- (void) updateWithServer
{
    NSArray *array = [[MoshTicketDatabase sharedInstance] getAllUnpostTickets];
    if ([GlobalConfig isKindOfNSArrayClassAndCountGreaterThanZero:array]) {
        [[ServerManger shareServerManger] updateTickets:array];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    //点击提示框的打开
    application.applicationIconBadgeNumber = 0;
}

@end
