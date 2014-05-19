//
//  BaseViewController.h
//  modelTest
//
//  Created by mosh on 13-10-21.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "MoshDefine.h"
#import "ServerRequest.h"
#import "GlobalConfig.h"
#import "HTTPClient.h"

static NSString *NAVBUTTON_back = @"nav_back";
static NSString *NAVBUTTON_share = @"nav_share";
static NSString *NAVBUTTON_list = @"nav_list";
static NSString *NAVBUTTON_user = @"nav_user";
static NSString *NAVBUTTON_exit = @"nav_exit";
static NSString *NAVBUTTON_back_h = @"nav_back";
static NSString *NAVBUTTON_share_h = @"nav_share_h";
static NSString *NAVBUTTON_list_h = @"nav_list_h";
static NSString *NAVBUTTON_user_h = @"nav_user_h";
static NSString *NAVBUTTON_exit_h = @"nav_exit";

static NSString *NAVBUTTON_delete_h = @"nav_delete";
static NSString *NAVBUTTON_delete = @"nav_delete";

static NSString *NAVBUTTON_refresh_h = @"nav_refresh";
static NSString *NAVBUTTON_refresh = @"nav_refresh";

static NSString *NAVBUTTON_check_h = @"nav_check";
static NSString *NAVBUTTON_check = @"nav_check";
typedef enum {
    MoshNavigationBarItemBack,
    MoshNavigationBarItemshare,
    MoshNavigationBarItemList,
    MoshNavigationBarItemUser,
    MoshNavigationBarItemUserExited,
    MoshNavigationBarItemNone,
    MoshNavigationBarItemDelete,
    MoshNavigationBarItemCheck,
    MoshNavigationBarItemRefresh
} MoshNavigationBarItemType;

@interface BaseViewController : UIViewController
{

}

@property (nonatomic, strong) MBProgressHUD         *loadingView;
@property (strong, nonatomic) NSMutableArray        *dataArray;


/*
 类方法 返回类实例 子类调用返回子类实例
 withNib 加载nib
 */
+ (BaseViewController *) viewController;
+ (BaseViewController *) viewControllerWithNib;

/*
 显示和隐藏加载页面
 */
- (void) showLoadingView;
- (void) hideLoadingView;
- (void)showProgressDialog:(int)current total:(int)total complete:(void (^)(void))complete;
/*
 加载页内容
 默认为 LOADING 正在加载。。。
 */
- (NSString *) returnLoadingViewLabelText;


/*
 创建导航按钮 
 leftItem 左导航类型
 rightItem 右导航类型
 title Controller标题
 导航按钮调用方法为
 - (void) navListClick;
 - (void) navBackClick;
 - (void) navUserClick;
 - (void) navShareClick;
 如果需要子类可重新
 */
- (void) createBarWithLeftBarItem:(MoshNavigationBarItemType)leftItem
                     rightBarItem:(MoshNavigationBarItemType)rightItem
                            title:(NSString *)title;

- (void) downloadData;

/*
 导航item调用方法
 分别对应list back user share userExit
 */
- (void) navListClick;
- (void) navBackClick;
- (void) navUserClick;
- (void) navShareClick;
- (void) navUserExitClick;
- (void) navDeleteClick;
- (void) navRefreshClick;
- (void) navCheckClick;

//获取数据库票种格式
- (NSString *) getDatabaseTicketID:(NSArray *)array;
@end
